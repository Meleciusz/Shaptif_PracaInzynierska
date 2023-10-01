import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/app.dart';
import 'package:shaptifii/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: (){
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.settings),
        ),
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
            GymModeButton(user: user),
          ],
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}