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
    //var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        // leading: IconButton(
        //   onPressed: (){
        //     scaffoldKey.currentState?.openDrawer();
        //   },
        //   icon: const Icon(Icons.settings),
        // ),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            }
          )
        ]
      ),
      body: Align(
        alignment: const Alignment(0, -2/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Witaj ${user.name}!" ?? '', style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Avatar(photo: user.photo),
            const SizedBox(height: 100),
            FutureBuilder(
                future: _checkInternetConnection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == true) {
                      return SizedBox(height: 0);
                    }
                    else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.red,),
                          Text("Brak połączenia z internetem, aplikacja może działać bez niektórych funkcji", style: textTheme.bodySmall)
                        ],
                      );
                    }
                  }else {
                    return const CircularProgressIndicator();
                  }
                }
            ),
            SizedBox(height: 100),
            GymModeButton(),
          ],
        ),
      ),
      drawer: DrawerWidget(),
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