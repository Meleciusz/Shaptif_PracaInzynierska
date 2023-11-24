import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/app.dart';
import 'package:shaptifii/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);


    // log(user.name!);
    // log(user.email!.split('@').first);

    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -2/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const HeaderTitle(),


            Text(
              "Welcome ${user.name != null && user.name!.isNotEmpty ? user.name! : (user.email != null ? user.email!.split('@').first : 'Unknown')}!",
              style: textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),
            Avatar(photo: user.photo),
            const SizedBox(height: 100),
            FutureBuilder(
                future: _checkInternetConnection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      return const SizedBox(height: 0);
                    }
                    else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.red,),
                          Text("You got no Internet connection, application may work without some functionalities", style: textTheme.bodySmall, overflow: TextOverflow.clip,)
                        ],
                      );
                    }
                  }else {
                    return const CircularProgressIndicator();
                  }
                }
            ),
            const SizedBox(height: 40),
            const GymModeButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      drawer: const DrawerWidget(),
    );
  }
}

Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}