import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../authorization/app/bloc/app_bloc.dart';

const _avatarSize = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final photo = user.photo;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Witaj ${user.name}!" ?? '', style: textTheme.headlineMedium,
        ),
        const SizedBox(width: 30.0),
        CircleAvatar(
          radius: _avatarSize,
          backgroundImage: photo != null ? NetworkImage(photo) : null,
          child: photo == null ? const Icon(Icons.person_outline, size: _avatarSize) : null,
          ),
      ],
    );
  }
}