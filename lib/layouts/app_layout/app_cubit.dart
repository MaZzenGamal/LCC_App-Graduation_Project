
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:graduation_project/modules/home_screen/home_screen.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/search_screen/search_screen.dart';
import 'package:graduation_project/modules/settings_screen/settings_screen.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/icon_broken.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  DoctorModel docModel = DoctorModel();
  PatientModel patModel = PatientModel();
  var uID = CacheHelper.getData(key: 'uId');
  var type = CacheHelper.getData(key: 'type');

  int currentIndex = 0;

  List<String>titles = [
    'Home',
    'Search',
    'Settings'
  ];
  List<Widget>screens = const[
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];


  List<BottomNavigationBarItem> bottomItems = const[
    BottomNavigationBarItem(
        icon: Icon(
            Icons.home
        ),
        label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
        label: 'search'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'search'),
  ];

  void changeBotNavBar(int index) {
    currentIndex = index;
    if (index == 1)
      const SearchScreen();
    emit(AppBotNavState());
  }


  void getDoctorData() {
    emit(GetDoctorLoadingState());
    FirebaseFirestore.instance.collection('doctor').doc(uId).get().then((value) {
      print(value.data());
      docModel = DoctorModel.fromJson(value.data()!);
      emit(GetDoctorSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDoctorErrorState(error.toString()));
    });
  }

  int age = 20;
  void selectAge(value){
    age = value;
    emit(UpdateProfileAgeValueState());
  }

  List<DoctorModel> doctors = [];
  List<PatientModel>patients = [];

  void getUsers() {
    if (type == "patient") {
      if (doctors.isEmpty) {
        FirebaseFirestore.instance
            .collection("doctor")
            .orderBy('createdAt', descending: true).get()
            .then((value) {
          value.docs.forEach((element) {
            if (element.data()['uId'] != docModel.uId) {
              doctors.add(DoctorModel.fromJson(element.data()));
            }
          });
          emit(GetAllPatientsSuccessState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllPatientsErrorState(error.toString()));
        });
      }
    }
    else if (type == "doctor") {
      if (patients.isEmpty) {
        FirebaseFirestore.instance
            .collection("patient")
            .orderBy('createdAt', descending: true).get()
            .then((value) {
          value.docs.forEach((element) {
            if (element.data()['uId'] != patModel.uId) {
              patients.add(PatientModel.fromJson(element.data()));
            }
          });
          emit(GetAllDoctorsSuccessState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllDoctorsErrorState(error.toString()));
        });
      }
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessagesModel model = MessagesModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: uID,
        text: text
    );
    if (type == "patient") {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      })
          .catchError((error) {
        emit(SendMessagesErrorState());
      });
      FirebaseFirestore.instance
          .collection('doctor')
          .doc(receiverId)
          .collection('chats')
          .doc(uID)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      })
          .catchError((error) {
        emit(SendMessagesErrorState());
      });
    }
    else if (type == "doctor") {
      FirebaseFirestore.instance
          .collection('doctor')
          .doc(uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      })
          .catchError((error) {
        emit(SendMessagesErrorState());
      });
      FirebaseFirestore.instance
          .collection('patient')
          .doc(receiverId)
          .collection('chats')
          .doc(uID)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      })
          .catchError((error) {
        emit(SendMessagesErrorState());
      });
    }
  }

  List<MessagesModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    if (type == "patient") {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        messages = [];
        event.docs.forEach((element) {
          messages.add(MessagesModel.fromJson(element.data()));
        });
        emit(GetMessagesSuccessState());
      });
    }
    else if (type == "doctor") {
      FirebaseFirestore.instance
          .collection('doctor')
          .doc(uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        messages = [];
        event.docs.forEach((element) {
          messages.add(MessagesModel.fromJson(element.data()));
        });
        emit(GetMessagesSuccessState());
      });
    }
  }

  void replaceDoctor(DoctorModel docModel) {
    doctors.insert(0, docModel);
    emit(ReplaceDoctorSuccessState());
  }

  void removeDoctor(int index) {
    doctors.removeAt(index);
    emit(DeleteDoctorSuccessState ());
  }

  void replacePatient(PatientModel patModel) {
    patients.insert(0, patModel);
    emit(ReplacePatientSuccessState());
  }

  void removePatient(int index) {
    patients.removeAt(index);
    emit(DeletePatientSuccessState ());
  }

  //var visible= RegisterCubit.get(context).visible1;
  File? profileImage;
  bool image=false;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image=true;
      print('image picked');
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('No image selected');
      image=false;
      emit(ProfileImagePickerErrorState());
    }
  }
  // void profileImageValidation(){
  //   visible=true;
  // emit(ProfileImageValidationState());
  // }

  void updateProfile({
    required String name,
    required String phone,
    required String age,
    required String address,
    required String university,
    required String gender,
    String? image,
  }
      ) {
    emit(UpdateProfileLoadingState());
    DoctorModel model = DoctorModel(
        fullName: name,
        phone: phone,
        email: docModel.email,
        image: image??docModel.image,
        uId: docModel.uId,
        token: docModel.token,
        address: address,
        age: age,
        gender:gender,
        university:university,
    );
    FirebaseFirestore.instance
        .collection('doctor')
        .doc(docModel.uId)
        .update(model.toMap())
        .then((value)
    {
      getDoctorData();
    }).catchError((error)
    {
      emit(UpdateProfileErrorState(error));
    });
  }

  // void uploadProfileImage({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String gender,
  //   required int age,
  //   required String address,
  //   required String university,
  // }) {
  //   emit(UploadProfileImageLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('doctor/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL()
  //         .then((value)
  //     {
  //       print(value.toString());
  //       updateProfile(
  //         gender: gender,
  //           name: name,
  //           phone: phone,
  //           address: address,
  //           //age: age,
  //           university: university,
  //           image: value);
  //       showToast(text: 'Profile image uploaded successfully', state: ToastStates.SUCCESS);
  //       emit(UploadProfileImageSuccessState());
  //     })
  //         .catchError((error)
  //     {
  //       showToast(text: 'Check your internet connection', state: ToastStates.ERROR);
  //       emit(UploadProfileImageErrorState(error));
  //     });
  //   }).catchError((error)
  //   {
  //     showToast(text: 'Check your internet connection', state: ToastStates.ERROR);
  //     print(error);
  //     emit(UploadProfileImageErrorState(error));
  //   });
  // }
}