part of 'auth_bloc.dart';

sealed class AuthEvents {}

class LoginEvent extends AuthEvents {
  final BuildContext context;
  LoginEvent(this.context);
}

class RegisterEvent extends AuthEvents {
  final BuildContext context;
  RegisterEvent(this.context);
}

class ToggleAuthModeEvent extends AuthEvents {}

class TogglePasswordVisibilityEvent extends AuthEvents {}

class ToggleConfirmPasswordVisibilityEvent extends AuthEvents {}
