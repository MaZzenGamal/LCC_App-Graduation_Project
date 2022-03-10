import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/home_screen/home_screen.dart';
import 'package:graduation_project/modules/search_screen/search_screen.dart';
import 'package:graduation_project/modules/settings_screen/settings_screen.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/components/conestants.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/styles/icon_broken.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';

import '../../shared/network/local/cash_helper.dart';
/*class AppCubit extends Cubit<AppStates> {

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

  List<DoctorModel> doctors = [];
  List<PatientModel>patients = [];

  void getUsers() {
    if (doctors.isEmpty) {
      FirebaseFirestore.instance
          .collection('doctors')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != patModel.uId) {
            doctors.add(DoctorModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      })
          .catchError((error) {
        print(error.toString());
        emit(GetAllUsersErrorState(error.toString()));
      });
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
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    })
        .catchError((error) {
      emit(SendMessagesErrorState());
    });
  }
  List<MessagesModel> messages = [];
  void getMessage({
    required String receiverId,
  })
  {
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
          emit(GetMessagesSuccessState());
        });
      });
}}*/
class AppCubit extends Cubit<AppStates>{

  AppCubit(): super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  DoctorModel docModel = DoctorModel();
  PatientModel patModel= PatientModel();
  var uID = CacheHelper.getData(key: 'uId');
  var type=CacheHelper.getData(key: 'type');
  int currentIndex = 0;
  List<String>titles=[
    'Home',
    'Search',
    'Settings'
  ];
  List<Widget>screens=const[
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems =const[
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

  void changeBotNavBar(int index){
    currentIndex = index;
    if(index == 1)
     const SearchScreen();
    emit(AppBotNavState());
  }
  List<DoctorModel> doctors = [];
  List<PatientModel>patients=[];
  void getUsers() {
      if (CacheHelper.getData(key: 'type') == 'patient') {
        if (doctors.isEmpty) {
          FirebaseFirestore.instance
              .collection('doctor')
              .get()
              .then((value) {
            value.docs.forEach((element) {
              if (element.data()['uId'] != docModel.uId) {
                doctors.add(DoctorModel.fromJson(element.data()));
              }
            });
            emit(GetAllUsersSuccessState());
          })
              .catchError((error) {
            print(error.toString());
            emit(GetAllUsersErrorState(error.toString()));
          });
        }
      }
      else if (CacheHelper.getData(key: 'type') == 'doctor') {
        if (patients.isEmpty) {
          FirebaseFirestore.instance
              .collection('patient')
              .get()
              .then((value) {
            value.docs.forEach((element) {
              if (element.data()['uId'] != patModel.uId) {
                patients.add(PatientModel.fromJson(element.data()));
              }
            });
            emit(GetAllUsersSuccessState());
          })
              .catchError((error) {
            print(error.toString());
            emit(GetAllUsersErrorState(error.toString()));
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
    if (CacheHelper.getData(key: 'type') == 'patient') {
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
    else if (CacheHelper.getData(key: 'type') == 'doctor') {
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
  })
  {
    if(CacheHelper.getData(key: 'type')=='patient') {
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
          emit(GetMessagesSuccessState());
        });
      });
    }
    else if(CacheHelper.getData(key: 'type')=='doctor') {
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
          emit(GetMessagesSuccessState());
        });
      });
    }
  }

}
