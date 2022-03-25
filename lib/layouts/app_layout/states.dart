abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppBotNavState extends AppStates{}

class GetPatientLoadingState extends AppStates{}

class GetPatientSuccessState extends AppStates{}

class GetPatientErrorState extends AppStates
{
  final String error;
  GetPatientErrorState(this.error);
}

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

class UpdateDocProfileLoadingState extends AppStates{}

class UpdateDocProfileSuccessState extends AppStates{}

class UpdateDocProfileErrorState extends AppStates{
  final String error;
  UpdateDocProfileErrorState(this.error);
}

class UploadDocProfileImageLoadingState extends AppStates{}

class UploadDocProfileImageSuccessState extends AppStates{}

class UploadDocProfileImageErrorState extends AppStates{
  final String error;
  UploadDocProfileImageErrorState(this.error);
}

class UpdatePatProfileLoadingState extends AppStates{}

class UpdatePatProfileSuccessState extends AppStates{}

class UpdatePatProfileErrorState extends AppStates{
  final String error;
  UpdatePatProfileErrorState(this.error);
}

class UploadPatProfileImageLoadingState extends AppStates{}

class UploadPatProfileImageSuccessState extends AppStates{}

class UploadPatProfileImageErrorState extends AppStates{
  final String error;
  UploadPatProfileImageErrorState(this.error);
}

class UpdateProfileAgeValueState extends AppStates{}
