import 'package:authorization_repository/authorization_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/sign_up/sign_up.dart';


/*
 * Main description:
This is the home page
This class is used to provide bloc and repository to layout and displays sign up page
 */
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route(){
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthorizationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}