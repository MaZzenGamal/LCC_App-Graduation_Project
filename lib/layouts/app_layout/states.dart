abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppBotNavState extends AppStates{}

class GetDoctorLoadingState extends AppStates{}

class GetDoctorSuccessState extends AppStates{}

class GetDoctorErrorState extends AppStates
{
  final String error;
  GetDoctorErrorState(this.error);
}

class GetAllDoctorsSuccessState extends AppStates{}

class GetAllDoctorsErrorState extends AppStates
{
  final String error;
  GetAllDoctorsErrorState(this.error);
}

class GetAllPatientsSuccessState extends AppStates{}

class GetAllPatientsErrorState extends AppStates
{
  final String error;
  GetAllPatientsErrorState(this.error);
}

class SendMessagesSuccessState extends AppStates{}

class SendMessagesErrorState extends AppStates {}

class GetMessagesSuccessState extends AppStates{}

class GetMessagesErrorState extends AppStates {}

class ReplaceDoctorSuccessState extends AppStates{}

class DeleteDoctorSuccessState extends AppStates{}

class ReplacePatientSuccessState extends AppStates{}

class DeletePatientSuccessState extends AppStates{}

class ProfileImagePickerSuccessState extends AppStates{}

class ProfileImagePickerErrorState extends AppStates{}

class ProfileImageValidationState extends AppStates{}

class UpdateProfileLoadingState extends AppStates{}

class UpdateProfileSuccessState extends AppStates{}

class UpdateProfileErrorState extends AppStates{
  final String error;
  UpdateProfileErrorState(this.error);
}

class UploadProfileImageLoadingState extends AppStates{}

class UploadProfileImageLoadingState2 extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadProfileImageErrorState extends AppStates{
  final String error;
  UploadProfileImageErrorState(this.error);
}

class UpdateProfileAgeValueState extends AppStates{}
