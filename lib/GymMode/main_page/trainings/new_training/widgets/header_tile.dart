import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onRefreshTap});
  final VoidCallback onRefreshTap;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: "Go back",
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
            icon: const Icon(Icons.arrow_back_ios),
          )
        ),
        Tooltip(
            message: "Refresh",
            child: IconButton(
              onPressed: (){
                onRefreshTap();
              },
              icon: const Icon(Icons.refresh),
            )
        )
      ],
    );
  }
}