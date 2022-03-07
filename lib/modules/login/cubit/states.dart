abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final String UID;
  LoginSuccessState(this.UID);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}