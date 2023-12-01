import 'package:flutter/material.dart';
import '../../GymMode/main_page/view/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/app.dart';


/*
*Main description:
This class describes user avatar
 */
const _avatarSize = 70.0;
class Avatar extends StatelessWidget {
  const Avatar({super.key, this.photo});

  //user photo
  final String? photo;

  @override
  Widget build(BuildContext context) {

    final photo = this.photo;
    return  CircleAvatar(
      radius: _avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null ? const Icon(Icons.person_outline, size: _avatarSize) : null,
    );

  }
}

/*
*Main description:
This class describes gym mode button

* Navigator:
User can navigate to gym mode page
 */
class GymModeButton extends StatelessWidget {
  const GymModeButton({super.key});


  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const MainPage())
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27.0),
        ),
        backgroundColor: const Color.fromARGB(255, 120, 178, 124),
        minimumSize: const Size(300, 70),
      ),
      child: const Text('Gym Mode', style: TextStyle(fontSize: 20, color: Color.fromARGB(
          255, 234, 233, 233), fontWeight: FontWeight.w700)),
    );
  }
}

/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 40,),
        Tooltip(
          message: "Open drawer",
          child: IconButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.drag_indicator)
          ),
        ),
        Tooltip(
          message: "Log out",
          child: IconButton(
              onPressed: (){
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
              icon: const Icon(Icons.exit_to_app)
          ),
        ),
      ],
    );
  }
}
