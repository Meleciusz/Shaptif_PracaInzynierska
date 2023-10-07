import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../authorization/app/bloc/app_bloc.dart';

const _avatarSize = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.assignment_return_outlined, size: _avatarSize),
        ),

        Text(
          name, style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(width: 30.0),
        const CircleAvatar(
          radius: _avatarSize,
          child: Icon(Icons.abc_outlined, size: _avatarSize),
        )
      ],
    );
  }
}