abstract class PatientStates{}

class PatientInitialState extends PatientStates{}

class PatientBotNavState extends PatientStates{}

class GetAllUsersSuccessState extends PatientStates{}

class GetAllUsersErrorState extends PatientStates
{
  final String error;
  GetAllUsersErrorState(this.error);
}

class SendMessagesSuccessState extends PatientStates{}

class SendMessagesErrorState extends PatientStates {}

class GetMessagesSuccessState extends PatientStates{}

class GetMessagesErrorState extends PatientStates {}