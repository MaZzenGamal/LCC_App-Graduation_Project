import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:http/http.dart' as http;
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
import 'package:graduation_project/modules/search_screen/search_screen.dart';
import 'package:graduation_project/modules/settings_screen/settings_screen.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(SignOutState());
  }

  var serverToken =
      "AAAArNo_QCM:APA91bHCNJ0QspqY1jOrmltOrhHJ50n1I4jB5cb0v_W1V8bnI9V02Nfv_yKR7AxRVi945BcfNtybVDb9XTApqSqCgINz3NtDfu2Y6-OfFkEbrZglup5-O-iA6g8Je0fMQhDKVRl1jPsT";
  sendNotfiy(String title,String body,String token) async {
    print('dddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK'
          },
          'to':token,
        },
      ),
    );
  }
  void getUserData() {
    if (type == "patient") {
      emit(GetPatientLoadingState());
      FirebaseFirestore.instance.collection('patient').doc(uID).get().then((value) {
        print(value.data());
        patModel = PatientModel.fromJson(value.data()!);
        emit(GetPatientSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetPatientErrorState(error.toString()));
      });
    }else if(type == "doctor"){
      emit(GetDoctorLoadingState());
      FirebaseFirestore.instance.collection('doctor').doc(uID).get().then((value) {
        print(value.data());
        docModel = DoctorModel.fromJson(value.data()!);
        emit(GetDoctorSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetDoctorErrorState(error.toString()));
      });
    }
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
          emit(GetAllDoctorsSuccessState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllDoctorsErrorState(error.toString()));
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
          emit(GetAllPatientsSuccessState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllPatientsErrorState(error.toString()));
        });
      }
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    required String token,
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
        var title="nada";
        var body="xxxxx";
        sendNotfiy(title,body,token);
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
        var title="nada";
        var body="xxxxx";
        sendNotfiy(title,body,token);
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

  void updateDocProfile({
    required String name,
    required String phone,
    required String age,
    required String address,
    required String university,
    required String gender,
    required String regisNumber,
    required String specialization,
    required String certificates,
    String? image,
  }){
    emit(UpdateDocProfileLoadingState());
    DoctorModel model = DoctorModel(
        fullName: name,
        phone: phone,
        email: docModel.email,
        image: image??docModel.image,
        uId: docModel.uId,
        token: docModel.token,
        createdAt: docModel.createdAt,
        address: address,
        age: age,
        gender:gender,
        university:university,
        certificates: certificates,
        specialization: specialization,
        regisNumber: regisNumber
    );
    FirebaseFirestore.instance
        .collection('doctor')
        .doc(docModel.uId)
        .update(model.toMap())
        .then((value)
    {
      showToast(text: 'Profile Updated successfully', state: ToastStates.SUCCESS);
      emit(UpdateDocProfileSuccessState());
      getUserData();
    }).catchError((error)
    {
      var index=(error.toString()).indexOf(']');
      String showError=(error.toString()).substring(index+1);
      showToast(text: showError, state: ToastStates.ERROR);
      print(error);
      emit(UpdateDocProfileErrorState(error));
    });
  }

  void uploadDocProfileImage({
    required String name,
    required String phone,
    required String gender,
    required String age,
    required String address,
    required String university,
    required String regisNumber,
    required String specialization,
    required String certificates,
  }){
    emit(UploadDocProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('doctor/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value)
      {
        print(value.toString());
        updateDocProfile(
          gender: gender,
            name: name,
            phone: phone,
            address: address,
            age: age,
            university: university,
            certificates: certificates,
            specialization: specialization,
            regisNumber: regisNumber,
            image: value);
        showToast(text: 'Profile image uploaded successfully', state: ToastStates.SUCCESS);
        emit(UploadDocProfileImageSuccessState());
        //emit(UploadProfileImageLoadingState2());
        profileImage = null;
      }).catchError((error)
      {
        var index=(error.toString()).indexOf(']');
        String showError=(error.toString()).substring(index+1);
        showToast(text: showError, state: ToastStates.ERROR);
        print(error);
        emit(UploadDocProfileImageErrorState(error));
      });
    }).catchError((error)
    {
      var index=(error.toString()).indexOf(']');
      String showError=(error.toString()).substring(index+1);
      showToast(text: showError, state: ToastStates.ERROR);
      print(error);
      emit(UploadDocProfileImageErrorState(error));
    });
  }

  void updatePatProfile({
    required String name,
    required String phone,
    required String age,
    required String address,
    required String gender,
    String? image,
  }){
    emit(UpdatePatProfileLoadingState());
    PatientModel model = PatientModel(
        fullName: name,
        phone: phone,
        email: patModel.email,
        image: image??patModel.image,
        uId: patModel.uId,
        token: patModel.token,
        createdAt: patModel.createdAt,
        address: address,
        age: age,
        gender:gender,
    );
    FirebaseFirestore.instance
        .collection('patient')
        .doc(patModel.uId)
        .update(model.toMap())
        .then((value)
    {
      showToast(text: 'Profile Updated successfully', state: ToastStates.SUCCESS);
      emit(UpdatePatProfileSuccessState());
      getUserData();
    }).catchError((error)
    {
      var index=(error.toString()).indexOf(']');
      String showError=(error.toString()).substring(index+1);
      showToast(text: showError, state: ToastStates.ERROR);
      print(error);
      emit(UpdatePatProfileErrorState(error));
    });
  }

  void uploadPatProfileImage({
    required String name,
    required String phone,
    required String gender,
    required String age,
    required String address,
  }){
    emit(UploadPatProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('patient/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value)
      {
        print(value.toString());
        updatePatProfile(
            gender: gender,
            name: name,
            phone: phone,
            address: address,
            age: age,
            image: value);
        showToast(text: 'Profile image uploaded successfully', state: ToastStates.SUCCESS);
        emit(UploadPatProfileImageSuccessState());
        //emit(UploadProfileImageLoadingState2());
        profileImage = null;
      }).catchError((error)
      {
        var index=(error.toString()).indexOf(']');
        String showError=(error.toString()).substring(index+1);
        showToast(text: showError, state: ToastStates.ERROR);
        print(error);
        emit(UploadPatProfileImageErrorState(error));
      });
    }).catchError((error)
    {
      var index=(error.toString()).indexOf(']');
      String showError=(error.toString()).substring(index+1);
      showToast(text: showError, state: ToastStates.ERROR);
      print(error);
      emit(UploadPatProfileImageErrorState(error));
    });
  }
}