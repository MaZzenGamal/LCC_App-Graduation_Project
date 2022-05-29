abstract class AppStates{}

class AppInitialState extends AppStates{
}

class AppBotNavState extends AppStates{}

class SignOutLoadingState extends AppStates{}

class SignOutSuccessState extends AppStates{}

class SignOutErrorState extends AppStates{
  final String error;
  SignOutErrorState(this.error);
}

class SignOutTerminateSuccessState extends AppStates{}

class SignOutTerminateErrorState extends AppStates{
  final String error;
  SignOutTerminateErrorState(this.error);
}

class SignOutClearSuccessState extends AppStates{}

class SignOutClearErrorState extends AppStates{
  final String error;
  SignOutClearErrorState(this.error);
}

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
class GetAllDoctorsLoadingState extends AppStates{}

class GetAllDoctorsSuccessState extends AppStates{}

class GetAllDoctorsErrorState extends AppStates {}

class GetAllPatientsLoadingState extends AppStates{}

class GetAllPatientsSuccessState extends AppStates{}

class GetAllPatientsErrorState extends AppStates {}

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

class SendCommentsSuccessState extends AppStates{}

class SendCommentsErrorState extends AppStates{
  final String error;
  SendCommentsErrorState(this.error);
}

class GetCommentsLoadingState extends AppStates{}

class GetCommentsSuccessState extends AppStates{}

class GetCommentsZeroState extends AppStates{}

class GetCommentsErrorsState extends AppStates{
  final String error;
  GetCommentsErrorsState(this.error);
}

class Updated extends AppStates{}

class UnReadMessages extends AppStates{}

class ReadMessages extends AppStates{}

class IncrementCount extends AppStates{}

class SetCount extends AppStates{}

class CreateCallSuccess extends AppStates{}

class CreateCallError extends AppStates{
  final String error;
  CreateCallError(this.error);
}

class ReservationErrorState extends AppStates{
  final String error;
  ReservationErrorState(this.error);
}

class ReservationSuccessState extends AppStates{}

class ChangeRemoteUid extends AppStates{}

class SecondChangeOfRemoteUid extends AppStates{}

class LocalUserJoin extends AppStates{}

class RemoteUserJoin extends AppStates{}

class RemoteUserLeave extends AppStates{}

class OnTimeChangeState extends AppStates{}

class OnDateChangeState extends AppStates{}

class RemoveReservationSuccessState extends AppStates{}

class InsertReservationSuccessState extends AppStates{}

class UploadChatImageLoadingState extends AppStates{}

class UploadChatImageSuccessState extends AppStates{}

class UploadChatImageErrorState extends AppStates{
  final String error;
  UploadChatImageErrorState(this.error);

}
class UpdateReservationLoadingState extends AppStates{}

class UpdateReservationSuccessState extends AppStates{}

class UpdateReservationErrorState extends AppStates{
  final String error;
  UpdateReservationErrorState(this.error);
}

class GetPatUpComingReservationLoadingState extends AppStates{}

class GetPatUpComingReservationSuccessState extends AppStates{}

class GetPatUpComingReservationErrorState extends AppStates{}

class GetPatCompletedReservationLoadingState extends AppStates{}

class GetPatCompletedReservationSuccessState extends AppStates{}

class GetPatCompletedReservationErrorState extends AppStates{}

class GetDocUpComingReservationLoadingState extends AppStates{}

class GetDocUpComingReservationSuccessState extends AppStates{}

class GetDocUpComingReservationErrorState extends AppStates{}

class GetDocCompletedReservationLoadingState extends AppStates{}

class GetDocCompletedReservationSuccessState extends AppStates{}

class GetDocCompletedReservationErrorState extends AppStates{}