abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppBotNavState extends AppStates{}

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
class replaceDoctorSuccessState extends AppStates{}
class DeleteDoctorSuccessState extends AppStates{}
class replacePatientSuccessState extends AppStates{}
class DeletePatientSuccessState extends AppStates{}