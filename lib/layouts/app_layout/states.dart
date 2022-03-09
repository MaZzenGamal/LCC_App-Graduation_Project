abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppBotNavState extends AppStates{}

class GetAllUsersSuccessState extends AppStates{}

class GetAllUsersErrorState extends AppStates
{
  final String error;
  GetAllUsersErrorState(this.error);
}

class SendMessagesSuccessState extends AppStates{}

class SendMessagesErrorState extends AppStates {}

class GetMessagesSuccessState extends AppStates{}

class GetMessagesErrorState extends AppStates {}