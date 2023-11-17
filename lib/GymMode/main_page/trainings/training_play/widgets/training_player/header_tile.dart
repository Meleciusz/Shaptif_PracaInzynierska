import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onRefreshTap, required this.onExitTap});
  final VoidCallback onRefreshTap;
  final VoidCallback onExitTap;

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
                onExitTap();
              },
              icon: const Icon(Icons.arrow_back_ios, size: 40,)
          ),
        ),
        Tooltip(
          message: "Refresh training",
          child: IconButton(
              onPressed: (){
                onRefreshTap();
              },
              icon: const Icon(Icons.refresh,  size: 40,)
          ),
        ),
      ],
    );
  }
}