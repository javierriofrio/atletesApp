import 'package:bloc/bloc.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User? user;
  late SharedPreferences prefs;
  late bool finishedOnBoarding;

  AuthenticationBloc({this.user})
      : super(const AuthenticationState.unauthenticated()) {

    on<LoginWithFacebookEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.loginWithFacebook();
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Login incorrecto, Intente de nueva.'));
      }
    });
    on<LoginWithGoogleEvent>((event, emit) async {
      dynamic result = await FireStoreUtils.loginWithGoogle();
      if (result != null && result is User) {
        user = result;
        emit(AuthenticationState.authenticated(user!));
      } else if (result != null && result is String) {
        emit(AuthenticationState.unauthenticated(message: result));
      } else {
        emit(const AuthenticationState.unauthenticated(
            message: 'Login incorrecto, Intente de nueva.'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await FireStoreUtils.logout();
      user = null;
      emit(const AuthenticationState.unauthenticated());
    });
  }
}
