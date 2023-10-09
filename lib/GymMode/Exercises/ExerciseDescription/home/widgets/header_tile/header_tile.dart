import 'package:flutter/material.dart';

const _avatarSize = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.veryfied});
  final bool veryfied;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, size: _avatarSize),
        ),
        const SizedBox(width: 30.0),
        veryfied ? const SizedBox() : IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever, size: _avatarSize)),
      ],
    );
  }
}