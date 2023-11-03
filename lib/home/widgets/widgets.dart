import 'package:flutter/material.dart';
import '../../GymMode/main_page/view/main_page.dart';



const _avatarSize = 70.0;

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.photo});

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null ? const Icon(Icons.person_outline, size: _avatarSize) : null,
    );
  }
}

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
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        backgroundColor: Colors.orangeAccent,
        minimumSize: const Size(300, 70),
      ),
      child: const Text('Gym Mode', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
    );
  }
}


//////////////////////////////////////////////////////////
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              shape: BoxShape.circle,
              ),
            child: Center(child: Text('Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),)
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwitchTheme(),
          ])
        ]
      )
    );
  }
}
class SwitchTheme extends StatefulWidget {
  const SwitchTheme({super.key});

  @override
  State<SwitchTheme> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchTheme> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Switch(
        value: light,
        activeColor: Colors.orange,
        thumbColor: const MaterialStatePropertyAll<Color>(Colors.grey),
        onChanged: (bool value) {

          setState(() {
            light = value;
          });
        },

      ),
    );
  }
}