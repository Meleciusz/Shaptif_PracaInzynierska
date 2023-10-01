import 'package:authorization_repository/authorization_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';

class HomePageGym extends StatelessWidget {
  const HomePageGym({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = this.user;

    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: MultiBlocProvider(
        providers: [],
        child: //HomeLayout(),
      ),
    );
  }
}