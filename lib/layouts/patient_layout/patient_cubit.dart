import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/patient_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/messages_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/Patient/home_screen/home_screen.dart';
import 'package:graduation_project/modules/Patient/search_screen/search_screen.dart';
import 'package:graduation_project/modules/Patient/settings_screen/settings_screen.dart';
import 'package:graduation_project/modules/syndromes/syndromes_screen.dart';
import 'package:graduation_project/shared/styles/icon_broken.dart';
import 'package:graduation_project/shared/styles/my_flutter_app_icons.dart';

class PatientCubit extends Cubit<PatientStates>{

  PatientCubit(): super(PatientInitialState());

  static PatientCubit get(context)=>BlocProvider.of(context);

  DoctorModel docModel = DoctorModel();
  PatientModel patModel = PatientModel();

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
    emit(PatientBotNavState());
  }


  List<DoctorModel> doctors = [];
  void getUsers()
  {
    if(doctors.isEmpty ) {
      FirebaseFirestore.instance
          .collection('doctor')
          .get()
          .then((value)
      {
        value.docs.forEach((element) {
          if(element.data()['uId'] != docModel.uId) {
            doctors.add(DoctorModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      })
          .catchError((error)
      {
        print(error.toString());
        emit(GetAllUsersErrorState(error.toString()));
      });
    }

  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  })
  {
    MessagesModel model = MessagesModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: patModel.uId,
        text: text
    );
    FirebaseFirestore.instance
        .collection('patient')
        .doc(patModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    })
        .catchError((error){
      emit(SendMessagesErrorState());
    });
    FirebaseFirestore.instance
        .collection('doctor')
        .doc(receiverId)
        .collection('chats')
        .doc(patModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    })
        .catchError((error){
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
        .doc(patModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      event.docs.forEach((element)
      {
        messages.add(MessagesModel.fromJson(element.data()));
        emit(GetMessagesSuccessState());
      });
    });

  }

}
