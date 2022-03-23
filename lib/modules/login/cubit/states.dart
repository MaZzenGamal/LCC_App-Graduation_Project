abstract class LoginStates {}
class LoginInitialState extends LoginStates{}
class LoginPasswordVisibilityState extends LoginStates{}
class GetAllUsersSuccessLoginState extends LoginStates{}
class GetAllUsersErrorLoginState extends LoginStates{
  final String error;
  GetAllUsersErrorLoginState(this.error);
}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}