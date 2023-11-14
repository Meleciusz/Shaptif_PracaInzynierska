import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onQuickStartTap});

  final VoidCallback onQuickStartTap;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: "Go back",
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, size: 40,)
          ),
        ),
        Tooltip(
          message: "Start quick training",
          child: IconButton(
              onPressed: (){
                onQuickStartTap();
              },
              icon: const Icon(Icons.local_fire_department_rounded, color: Color.fromARGB(
                  255, 204, 42, 42), size: 40,)
          ),
        ),
      ],
    );
  }
}