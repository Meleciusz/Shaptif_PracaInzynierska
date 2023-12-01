import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:shaptifii/authorization/app/app.dart';


/*
 * Main description:
This is main function, where widgets, observers, blocs and repositories are initialized
 */
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();

  runApp(const App());
}