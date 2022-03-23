import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  //LoginCubit(LoginStates initialState) : super(initialState);
  LoginCubit():super (LoginInitialState()) ;

  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
  required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      var index=(error.toString()).indexOf(']');
      String showerror=(error.toString()).substring(index+1);
      showToast(
          text: '${showerror}', state: ToastStates.ERROR
      );
      emit(LoginErrorState(error.toString()));
    });

  }

  DoctorModel docModel = DoctorModel();
  PatientModel patModel= PatientModel();
  var uID = CacheHelper.getData(key: 'uId');
  var type=CacheHelper.getData(key: 'type');
  List<DoctorModel> doctors = [];
  List<PatientModel>patients= [];

  void getUsers() {
    //print ('${type}');
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
          emit(GetAllUsersSuccessLoginState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllUsersErrorLoginState(error.toString()));
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
          emit(GetAllUsersSuccessLoginState());
        })
            .catchError((error) {
          print(error.toString());
          emit(GetAllUsersErrorLoginState(error.toString()));
        });
      }
    }
  }

}
