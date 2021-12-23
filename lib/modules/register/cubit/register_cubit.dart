import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

enum condition {patient , doctor}

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super (RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  condition? val = condition.patient;
  bool flag = false;

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

}