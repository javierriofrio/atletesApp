import 'package:atletes_sport_app/home_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atletes_sport_app/services/helper.dart';
import 'package:atletes_sport_app/ui/auth/authentication_bloc.dart';
import 'package:atletes_sport_app/ui/auth/login/login_bloc.dart';
import 'package:atletes_sport_app/ui/loading_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color: isDarkMode(context) ? Colors.white : Colors.black),
            elevation: 0.0,
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    pushAndRemoveUntil(
                        context, HomeEvents(user: state.user!), false);
                  } else {
                    showSnackBar(context,
                        state.message ?? 'No se pudo loguear, Intente nuevamente.');
                  }
                },
              ),
            ],
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (old, current) =>
                  current is LoginFailureState && old != current,
              builder: (context, state) {
                if (state is LoginFailureState) {
                  _validate = AutovalidateMode.onUserInteraction;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/atletes.jpg',
                        height: 200,
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        MaterialButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                          ),
                          onPressed: () {
                            context.read<LoadingCubit>().showLoading(
                                context, 'Logging in, Please wait...', false);
                            context.read<AuthenticationBloc>().add(
                                  LoginWithGoogleEvent(),
                                );
                          },
                          minWidth: double.infinity,
                          height: 40,
                          child: Text(
                            'Login Google'.toUpperCase(),
                          ),
                          color: Colors.redAccent,
                          textColor: Colors.white,
                        ),
                      ],
                    )),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
