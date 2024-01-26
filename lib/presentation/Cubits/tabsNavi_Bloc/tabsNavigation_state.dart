part of 'tabsNavigation_bloc.dart';

@immutable
abstract class RegisterNavigationState {
  final int defaultIndex;

  const RegisterNavigationState(this.defaultIndex);
}

@immutable
abstract class UserState {
  final UserModel user;
  const UserState(this.user);
}

class RegisterNavigation extends RegisterNavigationState {
  const RegisterNavigation() : super(0);
}

class UserRegisterState extends UserState {
  UserRegisterState(UserModel userModel) : super(UserModel.loadingUser());
}

class LoginScreen extends RegisterNavigationState {
  const LoginScreen(int currentIndex) : super(0);
}

class RegisterScreenOne extends RegisterNavigationState {
  const RegisterScreenOne(int currentIndex) : super(0);
}

class RegisterScreenTwo extends RegisterNavigationState {
  const RegisterScreenTwo(int currentIndex) : super(0);
}

class RegisterScreenThree extends RegisterNavigationState {
  const RegisterScreenThree(int currentIndex) : super(0);
}
