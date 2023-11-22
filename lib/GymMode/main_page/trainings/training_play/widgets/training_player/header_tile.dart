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
          message: "Stop and save training",
          child: IconButton(
              onPressed: (){
                onExitTap();
              },
              icon: const Icon(Icons.stop_circle_outlined, size: 40,)
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