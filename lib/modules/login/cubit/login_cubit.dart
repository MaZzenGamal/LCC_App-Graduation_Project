import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/doctor_model.dart';
import 'package:graduation_project/models/patient_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

import '../../../shared/components/conestants.dart';

class LoginCubit extends Cubit<LoginStates> {
  //LoginCubit(LoginStates initialState) : super(initialState);
  LoginCubit():super (LoginInitialState()) ;

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixLogin = Icons.visibility;
  bool isPasswordLogin = true;
  final firebase=FirebaseFirestore.instance;
  void changeLoginPasswordVisibility()
  {
    isPasswordLogin = !isPasswordLogin;
    suffixLogin = isPasswordLogin? Icons.visibility : Icons.visibility_off ;
    emit(LoginPasswordVisibilityState());
  }

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
  // void userLoginUser({
  //   required String email,
  //   required String password,
  // }){
  //   FirebaseFirestore.instance.terminate();
  //   FirebaseFirestore.instance
  //       .clearPersistence()
  //       .then((value) => userLogin(email: email, password: password));
  // }


  DoctorModel docModel = DoctorModel();
  PatientModel patModel= PatientModel();
  var uID = CacheHelper.getData(key: 'uId');
  var type=CacheHelper.getData(key: 'type');
  List<DoctorModel> doctors = [];
  List<PatientModel>patients= [];


  Future<String> updateToken({required String userId}) async {
    String?currentToken=await FirebaseMessaging.instance.getToken();
    String type=CacheHelper.getData(key: 'type');
    try {
      if(type=="doctor")
      {
        firebase.collection('doctor').doc(userId).update({'token':currentToken});
      }
      else if(type=="patient")
      {
        firebase.collection('patient').doc(userId).update({'token':currentToken});
      }

      return "Token Updated Successfully...";
    } on Exception catch (e) {
      return e.toString();
    }
  }

  void getUserData() {
    if (type == "patient") {
      emit(GetPatientLoadingState());
      firebase.collection('patient').doc(uID).get().then((value) {
        print(value.data());
        patModel = PatientModel.fromJson(value.data()!);
        emit(GetPatientSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetPatientErrorState(error.toString()));
      });
    }else if(type == "doctor"){
      emit(GetDoctorLoadingState());
      firebase.collection('doctor').doc(uID).get().then((value) {
        print(value.data());
        docModel = DoctorModel.fromJson(value.data()!);
        emit(GetDoctorSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetDoctorErrorState(error.toString()));
      });
    }
  }

}