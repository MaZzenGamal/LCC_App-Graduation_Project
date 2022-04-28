// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:graduation_project/models/call_model.dart';
import 'package:http/http.dart' as http;
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
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/comment_model.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  DoctorModel docModel = DoctorModel();
  PatientModel patModel = PatientModel();
  CommentModel commModel = CommentModel();
  var uID = CacheHelper.getData(key: 'uId');
  var type = CacheHelper.getData(key: 'type');
  final firebase = FirebaseFirestore.instance;

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
    if (index == 1) {
      const SearchScreen();
    }
    emit(AppBotNavState());
  }

  // Future<void> signOut() async {
  //   emit(SignOutLoadingState());
  //   // await FirebaseFirestore.instance.terminate().
  //   // then((value) {
  //   //   emit(SignOutTerminateSuccessState());
  //   // }).catchError((error){
  //   //   print(error.toString());
  //   //   emit(SignOutTerminateErrorState(error));});
  //   // await FirebaseFirestore.instance.clearPersistence().then((value) {
  //   //   emit(SignOutClearSuccessState());
  //   // }).catchError((error){
  //   //   print(error.toString());
  //   //   emit(SignOutClearErrorState(error));
  //   // });
  //   //await FirebaseMessaging.instance.deleteToken();
  //   // late String table;
  //   // if(type=='doctor') {
  //   //   table='doctor';
  //   // } else if(type=='patient') {
  //   //   table='patient';
  //   // }
  //   // print(table);
  //   // await FirebaseFirestore.instance.collection(table).get().then((value){
  //   //   value.docs.forEach((element)async{
  //   //     if(type=='patient'){
  //   //       FirebaseFirestore.instance.collection('patient').doc(uID).get().then((value) {
  //   //         print(value.data());
  //   //         patModel = PatientModel.fromJson(value.data()!);
  //   //       });
  //   //       if(element.id==patModel.uId){
  //   //         element.reference.update({'token':null});
  //   //       }
  //   //     }
  //   //     else if(type=='doctor')
  //   //     {
  //   //       FirebaseFirestore.instance.collection('doctor').doc(uID).get().then((value) {
  //   //         print(value.data());
  //   //         docModel = DoctorModel.fromJson(value.data()!);
  //   //       });
  //   //       if(element.id==docModel.uId){
  //   //         element.reference.update({'token':null});
  //   //       }
  //   //     }
  //   //   });
  //   // });
  //   await FirebaseAuth.instance.signOut()
  //       .then((value) {
  //      emit(SignOutSuccessState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(SignOutErrorState(error));
  //   });
  // }
  //
  // // void signOut(context){
  // //   CacheHelper.removeDate(
  // //       key: 'uId',
  // //   ).then((value){
  // //     if(value){
  // //       navigateAndFinish(context, LoginScreen());
  // //     }
  // //   });
  // // }
  var serverToken =
      "AAAArNo_QCM:APA91bHCNJ0QspqY1jOrmltOrhHJ50n1I4jB5cb0v_W1V8bnI9V02Nfv_yKR7AxRVi945BcfNtybVDb9XTApqSqCgINz3NtDfu2Y6-OfFkEbrZglup5-O-iA6g8Je0fMQhDKVRl1jPsT";
  sendNotfiy(String title, String body, String token) async {
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
            "sound": "default",
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'done',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'uidsender':uID,
          },
          'to': token,
        },
      ),
    );
  }

  void getUserData() {
    if (type == "patient") {
      emit(GetPatientLoadingState());
      firebase
          .collection("patient")
      .doc(uID)
          .snapshots()
          .listen((event) {
        patModel = PatientModel.fromJson(event.data()!);
        });
      // firebase.collection('doctor').
      // doc(commModel.receiverId).
      // collection('comments').
      // doc(uID).snapshots()
      //     .listen((event) {
      //   commModel = CommentModel.fromJson(event.data()!);
      // });
        emit(GetPatientSuccessState());
      }
    else if (type == "doctor") {
      emit(GetDoctorLoadingState());
      firebase
          .collection("doctor")
          .doc(uID)
          .snapshots()
          .listen((event) {
        docModel = DoctorModel.fromJson(event.data()!);
      });
      emit(GetDoctorSuccessState());
    }
  }

  int age = 20;

  void selectAge(value) {
    age = value;
    emit(UpdateProfileAgeValueState());
  }

  List<DoctorModel> doctors = [];
  List<PatientModel>patients = [];
  List<DoctorModel>alldoctor=[];
  void getDoctors() {
      firebase
          .collection("doctor")
      .orderBy('rate',descending: true)
          .snapshots()
          .listen((event) {
        alldoctor= [];
        event.docs.forEach((element) {
          alldoctor.add(DoctorModel.fromJson(element.data()));
        });
        emit(GetAllDoctorsSuccessState());
      });
  }

  void getUsers() {
    if (type == "patient") {
      firebase
          .collection("doctor")
         // .orderBy('createdAt',descending: true)
          .snapshots()
          .listen((event) {
        doctors= [];
        event.docs.forEach((element) {
          doctors.add(DoctorModel.fromJson(element.data()));
        });
        emit(GetAllDoctorsSuccessState());
      });
    }
    else if (type == "doctor") {
      firebase
          .collection("patient")
          //.orderBy('createdAt',descending: true)
          .snapshots()
          .listen((event) {
        patients= [];
        event.docs.forEach((element) {
          patients.add(PatientModel.fromJson(element.data()));
        });
        emit(GetAllDoctorsSuccessState());
      });
    }
  }

  Future<void> sendComment({
    required String receiverId,
    required DateTime dateTime,
    required String text,
    required double rate,
  })  async {
    String? name;
    String?photo;
    firebase
        .collection("patient")
        .doc(uID)
        .snapshots()
        .listen((event) {
      patModel = PatientModel.fromJson(event.data()!);
      print("pation model is $patModel");
    });
    name = patModel.fullName;
    photo = patModel.image;
    CommentModel model = CommentModel(
      receiverId: receiverId,
      senderId: uID,
      message: text,
      rate: rate,
      createdAt: dateTime,
      fullName: name,
      image: photo,

    );
    firebase
        .collection('doctor')
        .doc(receiverId).collection('comments').doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(SendCommentsSuccessState());
    })
        .catchError((error) {
      emit(SendCommentsErrorState(error));
    });
  }

  List<CommentModel> comments = [];
  void getComment({
    required String receiverId,
  }) {
    comments=[];
      firebase
          .collection('doctor')
          .doc(receiverId)
          .collection('comments')
          .snapshots()
          .listen((event) {
        comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
        print(element.data());
        //commModel = CommentModel.fromJson(element.data());
        // print('FFFFFFFFFFFFFFFFFFFFFFFFF');
        // print(commModel.toString());
      });
        print(commModel.message);
        emit(GetCommentsSuccessState());
    });
    }

    late MessagesModel messModel;
  int count = 0;
  Map<String, int> answers = {};
  void createCall() {
    CallsModel model = CallsModel(
      channelName: uID,
    );
    if (type == "patient") {
      FirebaseFirestore.instance.
      collection('patient').
      doc(uID).collection('calls').doc(uID).
      set(model.toMap())
          .then((value)
      {
        emit(CreateCallSuccess());
      }).catchError((error)
      {
        emit(CreateCallError(error.toString()));
      });
    }
    else if (type == "doctor") {
      FirebaseFirestore.instance.
      collection('doctor').
      doc(uID).collection('calls').doc(uID).
      set(model.toMap())
          .then((value)
      {
        emit(CreateCallSuccess());
      }).catchError((error)
      {
        emit(CreateCallError(error.toString()));
      });
    }
  }
    void sendMessage({
      required String receiverId,
      required DateTime dateTime,
      required String text,
      required String token,

    }) {
      MessagesModel model = MessagesModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: uID,
        text: text,
      );
      if (type == "patient") {
        firebase
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
        firebase
            .collection('doctor')
            .doc(receiverId)
            .collection('chats')
            .doc(uID)
            .collection('messages')
            .add(model.toMap())
            .then((value) {
          String? title =patModel.fullName;
          String body = text;
         sendNotfiy(title!, body, token);
          firebase.collection('doctor').doc(receiverId).update({'read': false});
          emit(SendMessagesSuccessState());
        })
            .catchError((error) {
          emit(SendMessagesErrorState());
        });
      }
      else if (type == "doctor") {
        firebase
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
        firebase
            .collection('patient')
            .doc(receiverId)
            .collection('chats')
            .doc(uID)
            .collection('messages')
            .add(model.toMap())
            .then((value) {
          String? title = docModel.fullName;
          String body = text;
          sendNotfiy(title!, body, token);
          firebase.collection('patient').doc(uID).update({'read': false});
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
        firebase
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
        firebase
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

    /*void replaceDoctor(DoctorModel docModel) {
      doctors.insert(0, docModel);
      emit(ReplaceDoctorSuccessState());
    }

    void removeDoctor(int index) {
      doctors.removeAt(index);
      emit(DeleteDoctorSuccessState());
    }

    void replacePatient(PatientModel patModel) {
      patients.insert(0, patModel);
      emit(ReplacePatientSuccessState());
    }

    void removePatient(int index) {
      patients.removeAt(index);
      emit(DeletePatientSuccessState());
    }*/

    //var visible= RegisterCubit.get(context).visible1;
    File? profileImage;
    bool image = false;
    var picker = ImagePicker();
    Future<void> getProfileImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = true;
        print('image picked');
        profileImage = File(pickedFile.path);
        emit(ProfileImagePickerSuccessState());
      } else {
        print('No image selected');
        image = false;
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
    }) {
      emit(UpdateDocProfileLoadingState());
      DoctorModel model = DoctorModel(
          fullName: name,
          phone: phone,
          email: docModel.email,
          image: image ?? docModel.image,
          uId: docModel.uId,
          token: docModel.token,
          createdAt: docModel.createdAt,
          address: address,
          age: age,
          gender: gender,
          university: university,
          certificates: certificates,
          specialization: specialization,
          regisNumber: regisNumber,
          rate: 0.000001,
          allRateValue: 0.00000001,
          allRateNumber: 3

      );
      firebase
          .collection('doctor')
          .doc(docModel.uId)
          .update(model.toMap())
          .then((value) {
        showToast(
            text: 'Profile Updated successfully', state: ToastStates.SUCCESS);
        emit(UpdateDocProfileSuccessState());
        getUserData();
      }).catchError((error) {
        var index = (error.toString()).indexOf(']');
        String showError = (error.toString()).substring(index + 1);
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
    }) {
      emit(UploadDocProfileImageLoadingState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('doctor/${Uri
          .file(profileImage!.path)
          .pathSegments
          .last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL()
            .then((value) {
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
          showToast(text: 'Profile image uploaded successfully',
              state: ToastStates.SUCCESS);
          emit(UploadDocProfileImageSuccessState());
          //emit(UploadProfileImageLoadingState2());
          profileImage = null;
        }).catchError((error) {
          var index = (error.toString()).indexOf(']');
          String showError = (error.toString()).substring(index + 1);
          showToast(text: showError, state: ToastStates.ERROR);
          print(error);
          emit(UploadDocProfileImageErrorState(error));
        });
      }).catchError((error) {
        var index = (error.toString()).indexOf(']');
        String showError = (error.toString()).substring(index + 1);
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
  }) {
    emit(UpdatePatProfileLoadingState());
    PatientModel model = PatientModel(
      fullName: name,
      phone: phone,
      email: patModel.email,
      image: image ?? patModel.image,
      uId: patModel.uId,
      token: patModel.token,
      createdAt: patModel.createdAt,
      address: address,
      age: age,
      gender: gender,
    );
    firebase
        .collection('patient')
        .doc(patModel.uId)
        .update(model.toMap())
        .then((value) {
      showToast(
          text: 'Profile Updated successfully', state: ToastStates.SUCCESS);
      emit(UpdatePatProfileSuccessState());
      getUserData();
    }).catchError((error) {
      var index = (error.toString()).indexOf(']');
      String showError = (error.toString()).substring(index + 1);
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
    }) {
      emit(UploadPatProfileImageLoadingState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('patient/${Uri
          .file(profileImage!.path)
          .pathSegments
          .last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL()
            .then((value) {
          print(value.toString());
          updatePatProfile(
              gender: gender,
              name: name,
              phone: phone,
              address: address,
              age: age,
              image: value);
          showToast(text: 'Profile image uploaded successfully',
              state: ToastStates.SUCCESS);
          emit(UploadPatProfileImageSuccessState());
          firebase.collection('doctor').get().then((value) {
            value.docs.forEach((result) {
              firebase.collection('comments').get().then((docs) {
                docs.docs.forEach((element) {
                  commModel = CommentModel.fromJson(element.data());
                  if(commModel.senderId==uID) {
                    CommentModel cmodel =CommentModel(
                        fullName: commModel.fullName,
                        message: commModel.message,
                        createdAt: commModel.createdAt,
                        receiverId: commModel.receiverId,
                        senderId: commModel.senderId,
                        image: commModel.image,
                        rate: commModel.rate
                    );
                    firebase
                        .collection('doctor').doc(commModel.receiverId)
                        .collection('comments').doc(commModel.senderId).
                    update(cmodel.toMap());

                  }
                });
              });
            });
          }).catchError((error){
            print(error.toString());
          });
          //emit(UploadProfileImageLoadingState2());
          profileImage = null;
        }).catchError((error) {
          var index = (error.toString()).indexOf(']');
          String showError = (error.toString()).substring(index + 1);
          showToast(text: showError, state: ToastStates.ERROR);
          print(error);
          emit(UploadPatProfileImageErrorState(error));
        });
      }).catchError((error) {
        var index = (error.toString()).indexOf(']');
        String showError = (error.toString()).substring(index + 1);
        showToast(text: showError, state: ToastStates.ERROR);
        print(error);
        emit(UploadPatProfileImageErrorState(error));
      });
    }



}