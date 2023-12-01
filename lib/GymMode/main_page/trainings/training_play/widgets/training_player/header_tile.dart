import 'package:flutter/material.dart';

/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onRefreshTap, required this.onExitTap});

  //This function is called when refresh button is pressed(returns training play to original state)
  final VoidCallback onRefreshTap;

  //This function is called when exit button is pressed(exit from training play and save)
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