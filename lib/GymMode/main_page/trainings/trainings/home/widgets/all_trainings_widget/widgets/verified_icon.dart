import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';


class AllTrainingsIcon extends StatelessWidget {
  const AllTrainingsIcon({super.key, required this.veryfied, required this.addingUserName, required this.addingUserId});

  final String addingUserName;
  final String addingUserId;
  final bool veryfied;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Row(
        children: [
          const Text("Verified:  "),
          const SizedBox(width: 3),
          veryfied ? const Icon(Icons.check, color: Colors.green)
              : const Icon(Icons.not_interested_rounded, color: Colors.red),
          const SizedBox(width: 3),
          veryfied ? Container() :
              addingUserId != user.id ?
          Text("Added by:  $addingUserName" ?? '')
                  : const Text("Added by:  You" ?? '')
        ]
    );
  }
}