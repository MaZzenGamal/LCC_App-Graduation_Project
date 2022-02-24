import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:image_picker/image_picker.dart';

enum condition {patient , doctor}

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super (RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  condition? val = condition.patient;
  bool flag = false;
  int age = 25;
  void radioPatient(value){
    val = value;
    flag = false;
    emit(RegisterRadioPatientState());
  }

  void radioDoctor(value){
    val = value;
    flag = true;
    emit(RegisterRadioDoctorState());
  }


  void selectAge(value){
    age = value;
    emit(RegisterAgeValueState());
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility : Icons.visibility_off ;
    emit(RegisterPasswordVisibilityState());
  }

  IconData suffix2 = Icons.visibility;
  bool isPassword2 = true;

  void changeConfPasswordVisibility()
  {
    isPassword2 = !isPassword2;
    suffix2 = isPassword2? Icons.visibility : Icons.visibility_off ;
    emit(RegisterConfPasswordVisibilityState());
  }

  IconData suffixLogin = Icons.visibility;
  bool isPasswordLogin = true;
  void changeLoginPasswordVisibility()
  {
    isPasswordLogin = !isPasswordLogin;
    suffixLogin = isPasswordLogin? Icons.visibility : Icons.visibility_off ;
    emit(LoginPasswordVisibilityState());
  }

  String gender ='Male';
  bool chosenGender = false;
  void changeExpansionToMale(){
    gender = 'Male';
    chosenGender = true;
    emit(ExpansionTitleMaleState());
  }

  void changeExpansionToFemale(){
    gender = 'Female';
    chosenGender = true;
    emit(ExpansionTitleFemaleState());
  }

  String status = 'Single';
  bool chosenStatus = false;
  void changeExpansionToSingle(){
    status = 'Single';
    chosenStatus = true;
    emit(ExpansionTitleSingleState());
  }

  void changeExpansionToMarried(){
    status = 'Married';
    chosenStatus = true;
    emit(ExpansionTitleMarriedState());
  }

  void changeExpansionToWidowed(){
    status = 'Widowed';
    chosenStatus = true;
    emit(ExpansionTitleWidowedState());
  }

  void changeExpansionToDivorced(){
    status = 'Divorced';
    chosenStatus = true;
    emit(ExpansionTitleDivorcedState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('image picked');
      // profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickerErrorState());
    }
  }

}
