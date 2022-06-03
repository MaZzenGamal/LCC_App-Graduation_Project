// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project/models/call_model.dart';
import 'package:graduation_project/models/docRef_model.dart';
import 'package:graduation_project/models/reservation_model.dart';
import 'package:graduation_project/modules/reservation_screen/doctors.dart';
import 'package:graduation_project/modules/reservation_screen/show_reservation.dart';
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
import 'package:graduation_project/modules/settings_screen/settings_screen.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../models/comment_model.dart';
import '../../models/user_model.dart';
import '../../modules/machine_connection/connection.dart';
import '../../modules/reservation_screen/doctor_reservation.dart';
import '../../modules/reservation_screen/patient_reservation.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  DoctorModel docModel = DoctorModel();
  PatientModel patModel = PatientModel();
  CommentModel commModel = CommentModel();
  //var uID = CacheHelper.getData(key: 'uId');
  //var type = CacheHelper.getData(key: 'type');
  final firebase = FirebaseFirestore.instance;

  int currentIndex = 2;
  List<String> titles = ['Check', 'Search', 'Home','Schedule','settings'];
  List<Widget> screens =  [
    const Connection(),
    const DoctorsScreen(),
    const HomeScreen(),
   const ShowReservation(),
   // usermodel.type=='patient'?ShowPatientReservation() : ShowDoctorReservation(),
    //CacheHelper.getData(key: 'type')=='patient'? ShowPatientReservation() : ShowDoctorReservation(),
    const SettingsScreen(),
  ];
  var kPages = <String, IconData>{
    'check': Icons.image_search,
    'search': Icons.search,
    'home': Icons.home,
    'schedule': Icons.schedule,
    'settings': Icons.settings,
  };
  TabStyle tabStyle = TabStyle.reactCircle;
  void changeBotNavBar(index){
    currentIndex = index;
    emit(AppBotNavState());
  }


  var serverToken =
      "AAAArNo_QCM:APA91bHCNJ0QspqY1jOrmltOrhHJ50n1I4jB5cb0v_W1V8bnI9V02Nfv_yKR7AxRVi945BcfNtybVDb9XTApqSqCgINz3NtDfu2Y6-OfFkEbrZglup5-O-iA6g8Je0fMQhDKVRl1jPsT";
  sendNotfiy(String title, String body, String token,String option) async {
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
            'uidsender': FirebaseAuth.instance.currentUser!.uid,
            'option':option,
          },
          'to': token,
        },
      ),
    );
  }
   UserModel usermodel=UserModel();
  Future<void>?changeUserModel() async {
    try {
      await firebase.collection("user").doc(
          FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        usermodel = UserModel.fromJson(value.data()!);
        emit(UserModelChange());
      });
    }
    catch(c){
      print("eeeeeeeeeeeeeeeeeeeeeee");
    }
  }
  Future<void>? getUserData() async{
    print("the type is ${usermodel.type}");
    if (usermodel.type == "doctor") {
      emit(GetDoctorLoadingState());
      try {
        await firebase.collection("doctor").doc(
            FirebaseAuth.instance.currentUser!.uid).get().then((value) {
          docModel = DoctorModel.fromJson(value.data()!);
          print("the data of user is ${ docModel}");
          emit(GetDoctorSuccessState());
        }).catchError((Error){
          print("the error is ${Error.toString()}");
          emit(GetDoctorErrorState(Error));

        });
      }catch(c){

        print("errrrrrrrrrrrrrrrrrrrr");
      }

    }
    else if (usermodel.type == "patient") {
      emit(GetPatientLoadingState());
      try {
        await firebase.collection("patient").doc(
            FirebaseAuth.instance.currentUser!.uid).get().then((value) {
          patModel = PatientModel.fromJson(value.data()!);
          emit(GetPatientSuccessState());
        }).catchError((Error){
          print("the error is ${Error.toString()}");
          emit((GetPatientErrorState(Error)));
        });
      }catch(c){
        print("errrrrrrrrrrrrrrrrrrrr");
      }
    }
  }

  int age = 20;

  void selectAge(value) {
    age = value;
    emit(UpdateProfileAgeValueState());
  }

  List<DoctorModel> doctors = [];
  List<PatientModel> patients = [];
  List<DoctorModel> alldoctor = [];
  int i=0;
  void getDoctors() {
    firebase
        .collection("doctor")
        .orderBy('rate', descending: true)
        .snapshots()
        .listen((event) {
      alldoctor = [];
      event.docs.forEach((element) {
        DoctorModel model=DoctorModel.fromJson(element.data());
        if(searchController.text.isNotEmpty)
          {
            if(model.specialization==searchController.text) {
              alldoctor.add(model);
            }
          }
        else
          {
            alldoctor.add(model);
          }

      });
      emit(GetAllDoctorsSuccessState());
    });
  }
  Future<void> getUsers()async{
    upcomingReservations=[];
    completeReservations=[];
    late QuerySnapshot querySnapshot;
    List<String> doc=[];
    if(usermodel.type=='patient') {
      emit(GetAllDoctorsLoadingState());
      doctors = [];
      print("vvvvvvvvvvvvvvvvv");
      querySnapshot =
      await firebase.collection('patient').doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('reservation')
          .get();
      querySnapshot.docs.forEach((element) {
        docrefmodel =
            DocRefModel.fromJson(element.data() as Map<String, dynamic>);
        doc.add(docrefmodel.docRef!);
      });
      print("the doc is $doc ");
      for (String element in doc) {
        print("hhhhhhhhhhhhhhhhhhhh");
        DocumentSnapshot documentSnapshot = await firebase.collection(
            'reservation').doc(element).get();
        ReservationModel resvModel = ReservationModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        print("the data is${resvModel.date!}");
        print("DateTime is ${DateTime.now()}");
        if((resvModel.date!).isBefore(DateTime.now())||(resvModel.date!)==(DateTime.now())) {
          DocumentSnapshot documentSnapshot = await firebase.collection(
              'doctor').doc(resvModel.doctorId).get();
          DoctorModel docModel = DoctorModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
           doctors.add(docModel);
          emit(GetAllDoctorsSuccessState());
          print("trueeeeeeeeeeeeeeeeeeeeeeeeeee");
          print("ttyyyyyyyyyyyyyyyyyyyyyyyy$doctors");
        }
      }
      List<DoctorModel> dupicate=doctors;
      for(int i=0;i<doctors.length;i++)
        {
          for(int j=0;j<dupicate.length;j++)
            {
              if(i!=j)
                {
                  if(doctors[i].uId==dupicate[j].uId)
                    {
                      dupicate.removeAt(j);
                    }
                }
            }
        }
      doctors=dupicate.toList();
    }
    else if(usermodel.type=='doctor') {
      emit(GetAllPatientsLoadingState());
      patients = [];
      //emit(GetAllPatientsLoadingState());
      print("vvvvvvvvvvvvvvvvv");
      querySnapshot =
      await firebase.collection('doctor').doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('reservation')
          .get();
      querySnapshot.docs.forEach((element) {
        docrefmodel =
            DocRefModel.fromJson(element.data() as Map<String, dynamic>);
        doc.add(docrefmodel.docRef!);
      });
      print("the doc is $doc ");
      for (String element in doc) {
        print("hhhhhhhhhhhhhhhhhhhh");
        DocumentSnapshot documentSnapshot = await firebase.collection(
            'reservation').doc(element).get();
        ReservationModel resvModel = ReservationModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        print("the data is${resvModel.date!}");
        print("DateTime is ${DateTime.now()}");
        if((resvModel.date!).isBefore(DateTime.now())||(resvModel.date!)==(DateTime.now())) {
          DocumentSnapshot documentSnapshot = await firebase.collection(
              'patient').doc(resvModel.patientId).get();
          PatientModel patModel = PatientModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
            patients.add(patModel);
          emit(GetAllPatientsSuccessState());
          print("trueeeeeeeeeeeeeeeeeeeeeeeeeee");
          print("ttyyyyyyyyyyyyyyyyyyyyyyyy$patients");
        }
      }
      List<PatientModel> dupicate=patients;
      for(int i=0;i<patients.length;i++)
      {
        for(int j=0;j<dupicate.length;j++)
        {
          if(i!=j)
          {
            if(patients[i].uId==dupicate[j].uId)
            {
              dupicate.removeAt(j);
            }
          }
        }
      }
      patients=dupicate.toList();
    }
  }

  Future<void> sendComment({
    required String receiverId,
    required DateTime dateTime,
    required String text,
    required double rate,
  }) async {
    CommentModel model = CommentModel(
      senderId: FirebaseAuth.instance.currentUser!.uid,
      comment: text,
      rate: rate,
      createdAt: dateTime,
    );
    firebase
        .collection('doctor')
        .doc(receiverId)
        .collection('comments')
        .doc( FirebaseAuth.instance.currentUser!.uid)
        .set(model.toMap())
        .then((value) {
      emit(SendCommentsSuccessState());
    }).catchError((error) {
      emit(SendCommentsErrorState(error));
    });
  }

  List<CommentModel> comments = [];
  Stream<void>? getComment({
    required String receiverId,
  }) {
    emit(GetCommentsLoadingState());
    comments = [];
    firebase
        .collection('doctor')
        .doc(receiverId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCommentsSuccessState());
    });
    emit(GetCommentsZeroState());
    return null;
  }

  late MessagesModel messModel;
  int count = 0;
  Map<String, int> answers = {};
  void createCall({
    String? receiverId,
    String? senderId
  }) {
    CallsModel model = CallsModel(
      channelName:  FirebaseAuth.instance.currentUser!.uid,
      senderId:senderId,
      receiverId: receiverId
    );
      FirebaseFirestore.instance
          .collection('calls')
          .doc( FirebaseAuth.instance.currentUser!.uid)
          .set(model.toMap())
          .then((value) {
        emit(CreateCallSuccess());
      }).catchError((error) {
        emit(CreateCallError(error.toString()));
      });
  }

  Future<void> sendMessage({
    required String receiverId,
    required DateTime dateTime,
    required String text,
    required String token,
  }) async {
    MessagesModel model = MessagesModel(
      dateTime: dateTime,
      receiverId: receiverId,
      senderId:  FirebaseAuth.instance.currentUser!.uid,
      text: text,
      type:'text',
    );
    if (usermodel.type== "patient") {
      firebase
          .collection('patient')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      }).catchError((error) {
        emit(SendMessagesErrorState());
      });
      firebase
          .collection('doctor')
          .doc(receiverId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        String? title = patModel.fullName;
        String body = text;
        sendNotfiy(title!, body, token,'chat');
        firebase.collection('doctor').doc(receiverId).update({'read': false});
        emit(SendMessagesSuccessState());
      }).catchError((error) {
        emit(SendMessagesErrorState());
      });
    }
    else if (usermodel.type == "doctor") {
      firebase
          .collection('doctor')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SendMessagesSuccessState());
      }).catchError((error) {
        emit(SendMessagesErrorState());
      });
      firebase
          .collection('patient')
          .doc(receiverId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        String? title = docModel.fullName;
        String body = text;
        sendNotfiy(title!, body, token,'chat');
        firebase.collection('patient').doc(FirebaseAuth.instance.currentUser!.uid).update({'read': false});
        emit(SendMessagesSuccessState());
      }).catchError((error) {
        emit(SendMessagesErrorState());
      });
    }
  }

  List<MessagesModel> messages = [];
  Future<void> getChatImage({
    required String receiverId,
    required DateTime dateTime,
    required String token,
}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = true;
      print('image picked');
      profileImage = File(pickedFile.path);
      uploadImage(receiverId,dateTime,token);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('No image selected');
      image = false;
      emit(ProfileImagePickerErrorState());
    }
  }

  Future uploadImage(String receiverId,DateTime dateTime,String token) async{
    {
      emit(UploadChatImageLoadingState());
       firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chats/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value.toString());
          MessagesModel model = MessagesModel(
            dateTime: dateTime,
            receiverId: receiverId,
            senderId: FirebaseAuth.instance.currentUser!.uid,
            text:value ,
            type:'image',
          );
          if (usermodel.type == "patient") {
            firebase
                .collection('patient')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('chats')
                .doc(receiverId)
                .collection('messages')
                .add(model.toMap())
                .then((value) {
              emit(SendMessagesSuccessState());
            }).catchError((error) {
              emit(SendMessagesErrorState());
            });
            firebase
                .collection('doctor')
                .doc(receiverId)
                .collection('chats')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('messages')
                .add(model.toMap())
                .then((value) {
              String? title = patModel.fullName;
              String body = model.text!;
              sendNotfiy(title!, body, token,'chat');
              firebase.collection('doctor').doc(receiverId).update({'read': false});
              emit(SendMessagesSuccessState());
            }).catchError((error) {
              emit(SendMessagesErrorState());
            });
          }
          else if (usermodel.type== "doctor") {
            firebase
                .collection('doctor')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('chats')
                .doc(receiverId)
                .collection('messages')
                .add(model.toMap())
                .then((value) {
              emit(SendMessagesSuccessState());
            }).catchError((error) {
              emit(SendMessagesErrorState());
            });
            firebase
                .collection('patient')
                .doc(receiverId)
                .collection('chats')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('messages')
                .add(model.toMap())
                .then((value) {
              String? title = docModel.fullName;
              String body =model.text! ;
              sendNotfiy(title!, body, token,'chat');
              firebase.collection('patient').doc(FirebaseAuth.instance.currentUser!.uid).update({'read': false});
              emit(SendMessagesSuccessState());
            }).catchError((error) {
              emit(SendMessagesErrorState());
            });
          }
          showToast(
              text: 'image uploaded successfully',
              state: ToastStates.SUCCESS);
          emit(UploadChatImageSuccessState());
          //emit(UploadProfileImageLoadingState2());
          profileImage = null;
        }).catchError((error) {
          var index = (error.toString()).indexOf(']');
          String showError = (error.toString()).substring(index + 1);
          showToast(text: showError, state: ToastStates.ERROR);
          print(error);
          emit(UploadChatImageErrorState(error));
        });
      }).catchError((error) {
        var index = (error.toString()).indexOf(']');
        String showError = (error.toString()).substring(index + 1);
        showToast(text: showError, state: ToastStates.ERROR);
        print(error);
        emit(UploadChatImageErrorState(error));
      });
    }
  }

  void getMessage({
    required String receiverId,
  }) {
    if (usermodel.type == "patient") {
      firebase
          .collection('patient')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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
    } else if (usermodel.type == "doctor") {
      firebase
          .collection('doctor')
          .doc(FirebaseAuth.instance.currentUser!.uid)
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
  /*void uploadChatImage({
    required String name,
    required String phone,
    required String gender,
    required String age,
    required String address,
  }) {
    emit(UploadChatImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        showToast(
            text: 'image uploaded successfully',
            state: ToastStates.SUCCESS);
        emit(UploadChatImageSuccessState());
        //emit(UploadProfileImageLoadingState2());
        profileImage = null;
      }).catchError((error) {
        var index = (error.toString()).indexOf(']');
        String showError = (error.toString()).substring(index + 1);
        showToast(text: showError, state: ToastStates.ERROR);
        print(error);
        emit(UploadChatImageErrorState(error));
      });
    }).catchError((error) {
      var index = (error.toString()).indexOf(']');
      String showError = (error.toString()).substring(index + 1);
      showToast(text: showError, state: ToastStates.ERROR);
      print(error);
      emit(UploadChatImageErrorState(error));
    });
  }*/

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
//////////////////////////////////////// PROFILE //////////////////////////////
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
    required DateTime startTime,
    required DateTime endTime,
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
        startTime: startTime,
        endTime: endTime,
        rate: 0.000001,
        allRateValue: 0.00000001,
        allRateNumber: 3);
    firebase
        .collection('doctor')
        .doc(docModel.uId)
        .update(model.toMap())
        .then((value) {
      showToast(
          text: 'Profile Updated successfully', state: ToastStates.SUCCESS);
      emit(UpdateDocProfileSuccessState());
      timeOfWork(startTime: docModel.startTime!, endTime: docModel.endTime!);
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
    required DateTime startTime,
    required DateTime endTime,
  }) {
    emit(UploadDocProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('doctor/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
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
            startTime: startTime,
            endTime: endTime,
            image: value);
        showToast(
            text: 'Profile image uploaded successfully',
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
        .then((value) async {
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
        .child('patient/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        updatePatProfile(
            gender: gender,
            name: name,
            phone: phone,
            address: address,
            age: age,
            image: value);
        showToast(
            text: 'Profile image uploaded successfully',
            state: ToastStates.SUCCESS);
        emit(UploadPatProfileImageSuccessState());
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
//////////////////////////// RESERVATION ///////////////////////////////////////
  DateTime dateSelectedValue=DateTime.now().weekday==5?DateTime.now().add(const Duration(days: 1)):DateTime.now();
  //DateTime dateSelectedValue=DateTime.parse('2022-05-07 00:00:00.000');
  DateTime timeSelectedValue = DateTime.parse("1990-01-01 00:00:00");
  void onTimeChange(value) {
    String value1=DateFormat('HH:mm:ss').format(value);
    timeSelectedValue = DateTime.parse('1990-02-02 $value1');
    print("the time in app is ${timeSelectedValue} ");
    emit(OnTimeChangeState());
  }
  void onDateChange(value){
    dateSelectedValue=value;
    emit(OnDateChangeState());
  }

  List<DateTime> dates = [];

  Stream<void>? checkHoliday() {
    dates = [];
    DateTime dateTime = DateTime.now();
    var givenYear = dateTime.year;
    var dateIter = DateTime(givenYear);
    while (dateIter.year < givenYear + 1) {
      dateIter = dateIter.add(const Duration(days: 1));
      if (dateIter.weekday == 5) {
        //1 for Monday, 2 for Tuesday, 3 for Wednesday and so on.
        dates.add(dateIter);
      }
    }
    return null;
  }

  List<DateTime> times = [];
  Stream<void>? timeOfWork({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    times = [];
    DateTime timeIter = startTime;
    while (timeIter.isBefore(endTime)) {
      if(times.isEmpty)
        {
          times.add(timeIter);
        }
      timeIter = timeIter.add(const Duration(minutes: 15));
      if(!(timeIter.isBefore(endTime))){
        break;
      }
      times.add(timeIter);
    }
    return null;
  }
  DocRefModel docrefmodel = DocRefModel();
  bool exist=false;
  ReservationModel reservatiomModel = ReservationModel();
 Future<bool> isExist({required String doctorId,required DateTime work}) async{
    print("vvvvvvvvvvvvvvvvv");
    exist=false;
    late QuerySnapshot querySnapshot;
    List<String> reservedDates = [];
    List<String> doc=[];
    List<ReservationModel> rese=[];
      try {
        querySnapshot =
        await firebase.collection('doctor').doc(doctorId).collection(
            'reservation').get();
        querySnapshot.docs.forEach((element) {
          docrefmodel =
              DocRefModel.fromJson(element.data() as Map<String, dynamic>);
          doc.add(docrefmodel.docRef!);
        });
        print("the doc is $doc ");
        for (String element in doc) {
          DocumentSnapshot documentSnapshot = await firebase.collection(
              'reservation').doc(element).get();
          rese.add(ReservationModel.fromJson(
              documentSnapshot.data()! as Map<String, dynamic>));
          /* reservatiomModel = ReservationModel.fromJson(
            documentSnapshot.data()! as Map<String, dynamic>);*/
        }
        print(rese);
      }catch(_){print('errrrorrrrrrr');}

    rese.forEach((element) {
      print(element.date);
      if (DateFormat('EEEE, MMM d, yyyy').format(element.date!) ==
          DateFormat('EEEE, MMM d, yyyy').format(dateSelectedValue)) {
        reservedDates.add(DateFormat('HH:mm:ss').format(element.date!));
        print("the dates is $reservedDates");
        print("trueeeeeeeeeeeeeeeeeeeeeeeeeeee");
      }
    });

      exist=reservedDates.contains(DateFormat('HH:mm:ss').format(work));
      print("the time is$exist");
      return exist;
  }
  String reservationId=" ";
  Future<void> patReservation({
    required DateTime date,
    required String doctorId,
    String? docRef,
  }) async {
    print("vvvvvvvvvvvvvvvvv");
    if (reservationId != " ") {
      {
        emit(UpdateReservationLoadingState());
        firebase
            .collection('reservation')
            .doc(reservationId)
            .update({'date':date.toString()})
            .then((value) async {
          showToast(
              text: 'Reservation Updated successfully', state: ToastStates.SUCCESS);
          emit(UpdateReservationSuccessState());
        }).catchError((error) {
          var index = (error.toString()).indexOf(']');
          String showError = (error.toString()).substring(index + 1);
          showToast(text: showError, state: ToastStates.ERROR);
          print(error);
          emit(UpdateReservationErrorState(error));
        });
      }

    }
    else {
      bool existpatient = false;
      late QuerySnapshot querySnapshot;
      List<ReservationModel> rese = [];
      try {
        querySnapshot =
        await firebase.collection('reservation').get();
        querySnapshot.docs.forEach((element) {
          rese.add(ReservationModel.fromJson(
              element.data()! as Map<String, dynamic>));
        });
        print(rese);
      } catch (_) {
        print('errrrorrrrrrr');
      }
      rese.forEach((element) {
        if (element.doctorId == doctorId && element.patientId == FirebaseAuth.instance.currentUser!.uid&&((element.date!.add(const Duration(minutes: 15))).isAfter(DateTime.now()))) {
          existpatient = true;
          print("trueeeeeeeeeeeeeeeeeeeeeeeeeeee");
        }
      });
      if (existpatient == false) {
        ReservationModel model = ReservationModel(
          date: date,
          doctorId: doctorId,
          patientId: FirebaseAuth.instance.currentUser!.uid,
        );
        firebase.collection('reservation').add(model.toMap()).then((docRef) {
          firebase.collection('reservation').doc(docRef.id).update(
              {'reservationId': docRef.id});
          DocRefModel docRefModel = DocRefModel(
            docRef: docRef.id,
          );
          firebase
              .collection('patient')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('reservation')
              .doc(docRef.id)
              .set(docRefModel.toMap());
          firebase
              .collection('doctor')
              .doc(doctorId)
              .collection('reservation')
              .doc(docRef.id)
              .set(docRefModel.toMap());
          emit(ReservationSuccessState());
        }).catchError((error) {
          emit(ReservationErrorState(error));
        });
        showToast(text: 'Reservation booked successfully', state: ToastStates.SUCCESS);
      }
      else {
        showToast(text: 'you already have an appointment with this doctor', state: ToastStates.ERROR);
      }
    }
    reservationId=" ";
  }

 /////////////////////////////////show reservation/////////////////////
 List<ReservationModel> upcomingReservations=[];
 List<ReservationModel>completeReservations=[];
 int currentTape=0;
 bool specializationExist=false;
 var searchController = TextEditingController();
 Future<void> existSpecialization() async {
   List<String>specializations=[];
   late QuerySnapshot querySnapshot;
     print("vvvvvvvvvvvvvvvvv");
     querySnapshot =
         await firebase.collection('doctor').get();
     querySnapshot.docs.forEach((element) {
       DoctorModel model =
       DoctorModel.fromJson(element.data() as Map<String, dynamic>);
       specializations.add(model.specialization!);
     });
     specializationExist=specializations.contains(searchController.text);
     print("the specializations are $specializations");
     print("the specialization is $specializationExist");
   }
 void removeReservation({
  required int index,
   required ReservationModel model
}){
   firebase.collection('reservation').doc(model.reservationId).delete();
   firebase.collection('patient').doc(model.patientId).collection('reservation').doc(model.reservationId).delete();
   firebase.collection('doctor').doc(model.doctorId).collection('reservation').doc(model.reservationId).delete();
   upcomingReservations.removeAt(index);
   showToast(
       text: 'Reservation has been deleted successfully', state: ToastStates.SUCCESS);
   emit(RemoveReservationSuccessState());
 }
  Future<void> showReservation() async {
    upcomingReservations=[];
    completeReservations=[];
    late QuerySnapshot querySnapshot;
    List<String> doc=[];
    emit(GetReservationLoadingStates());
    if(usermodel.type=='patient') {
      print('the user is ${usermodel.type}');
      doctors = [];
      print("vvvvvvvvvvvvvvvvv");
      querySnapshot =
      await firebase.collection('patient').doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('reservation')
          .get();
      querySnapshot.docs.forEach((element) {
        docrefmodel =
            DocRefModel.fromJson(element.data() as Map<String, dynamic>);
        doc.add(docrefmodel.docRef!);
      });
      print("the doc is $doc ");
      for (String element in doc) {
        print("hhhhhhhhhhhhhhhhhhhh");
        DocumentSnapshot documentSnapshot = await firebase.collection(
            'reservation').doc(element).get();
        ReservationModel resvModel = ReservationModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        print("the data is${resvModel.date!}");
        print("DateTime is ${DateTime.now()}");
        if((resvModel.date!.add(const Duration(minutes: 15))).isAfter(DateTime.now())) {
          print("trueeeeeeeeeeeeeeeeeeeeeeeeeee");
          emit(GetPatUpComingReservationLoadingState());
          upcomingReservations.add(ReservationModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>));
          print("ttyyyyyyyyyyyyyyyyyyyyyyyy$upcomingReservations");
          emit(GetPatUpComingReservationSuccessState());
        }
        else
        {
          emit(GetPatCompletedReservationLoadingState());
          completeReservations.add(ReservationModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>));
          print("tttttttttttttttttttt$completeReservations");
          emit(GetPatCompletedReservationSuccessState());
        }
      }
      }
    else if(usermodel.type=='doctor'){
      doctors=[];
      print("vvvvvvvvvvvvvvvvv");
      querySnapshot =
      await firebase.collection('doctor').doc(FirebaseAuth.instance.currentUser!.uid).collection(
          'reservation').get();
      querySnapshot.docs.forEach((element) {
        docrefmodel =
            DocRefModel.fromJson(element.data() as Map<String, dynamic>);
        doc.add(docrefmodel.docRef!);
      });
      print("the doc is $doc ");
      for (String element in doc) {
        print("hhhhhhhhhhhhhhhhhhhh");
        DocumentSnapshot documentSnapshot = await firebase.collection('reservation').doc(element).get();
        ReservationModel resvModel= ReservationModel.fromJson(documentSnapshot.data()as Map<String,dynamic>);
        print("the data is${resvModel.date!}");
        print("DateTime is ${DateTime.now()}");
        if((resvModel.date!.add(const Duration(minutes: 15))).isAfter(DateTime.now())){
          emit(GetDocUpComingReservationLoadingState());
          upcomingReservations.add(ReservationModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>));
          print("ttyyyyyyyyyyyyyyyyyyyyyyyy$upcomingReservations");
          emit(GetDocUpComingReservationSuccessState());
        }
        else
        {
          emit(GetDocCompletedReservationLoadingState());
          completeReservations.add(ReservationModel.fromJson(documentSnapshot.data()! as Map<String, dynamic>));
          print("tttttttttttttttttttt$completeReservations");
          emit(GetDocCompletedReservationSuccessState());
        }
      }
    }
    upcomingReservations.sort((a, b) => a.date!.compareTo(b.date!));
    completeReservations.sort((a, b) => a.date!.compareTo(b.date!));
  }
  Future<DoctorModel> getDoctorData({
 required String uid
}) async {
    DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection('doctor').doc(FirebaseAuth.instance.currentUser!.uid).get();
    DoctorModel Model=DoctorModel.fromJson(documentSnapshot.data()! as Map<String,dynamic>);
    if (kDebugMode) {
      print("the data is ${patModel.fullName}");
    }
    return Model;
  }
  Future<PatientModel> getPatientData(String uid) async {
    DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection('patient').doc(FirebaseAuth.instance.currentUser!.uid).get();
    patModel=PatientModel.fromJson(documentSnapshot.data()! as Map<String,dynamic>);
    if (kDebugMode) {
      print("the data is ${patModel.fullName}");
    }
    return patModel;
  }
}





///////||DateTime.parse(appoinment)==DateTime.now()
/*
DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection('doctor').doc(resvModel.doctorId).get();
          DoctorModel model=DoctorModel.fromJson(documentSnapshot.data()! as Map<String,dynamic>);
          print(model);
          doctors.add(model);
              print(doctors);
 */