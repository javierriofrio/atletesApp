import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/app.dart';
import 'package:atletes_sport_app/simple_bloc_observer.dart';

import 'authentication/repository/autenticacion/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver(); // Crear simpleBlocObserver
  runApp(App(authenticationRepository: AuthenticationRepository())); // App
}
