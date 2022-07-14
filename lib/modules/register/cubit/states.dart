abstract class RegisterStates {}
class ProfileImageValidationState extends RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterRadioPatientState extends RegisterStates{}

class RegisterRadioDoctorState extends RegisterStates{}

class RegisterAgeValueState extends RegisterStates{}

class RegisterPasswordVisibilityState extends RegisterStates{}

class RegisterConfPasswordVisibilityState extends RegisterStates{}

class LoginPasswordVisibilityState extends RegisterStates{}

class ExpansionTitleMaleState extends RegisterStates{}

class ExpansionTitleFemaleState extends RegisterStates{}

class ExpansionTitleMarriedState extends RegisterStates{}

class ExpansionTitleSingleState extends RegisterStates{}

class ExpansionTitleWidowedState extends RegisterStates{}

class ExpansionTitleDivorcedState extends RegisterStates{}

class ProfileImagePickerSuccessState extends RegisterStates{}

class ProfileImagePickerErrorState extends RegisterStates{}

class PatientRegisterLoadingState extends RegisterStates{}

class PatientRegisterErrorState extends RegisterStates{
  final String error;

  PatientRegisterErrorState(this.error);
}

class PatientCreateSuccessState extends RegisterStates{
}

class PatientCreateErrorState extends RegisterStates{
  final String error;
  PatientCreateErrorState(this.error);
}

class DoctorRegisterLoadingState extends RegisterStates{}

class DoctorRegisterErrorState extends RegisterStates{
  final String error;

  DoctorRegisterErrorState(this.error);
}

class DoctorCreateSuccessState extends RegisterStates{}

class DoctorCreateErrorState extends RegisterStates{
  final String error;
  DoctorCreateErrorState(this.error);
}
class PhoneCreateErrorState extends RegisterStates{}
