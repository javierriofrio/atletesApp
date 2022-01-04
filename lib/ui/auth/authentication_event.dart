part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginWithFacebookEvent extends AuthenticationEvent {}

class LoginWithGoogleEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}


