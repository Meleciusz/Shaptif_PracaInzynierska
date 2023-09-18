import 'package:flutter/material.dart';
import 'package:shaptifii/CyclistMode/home_page.dart';

import '../GymMode/home_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Screen'),
        centerTitle: true
      ),
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
                  'What do you want to be today?',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePageGym()));
                            },
                            child: const Text('Gym Maniac')
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: ElevatedButton(
                            onPressed: (){
                              //TODO: Navigate to next screen
                            },
                            child: const Text('Cyclist')
                        ),
                      )
                    ]
                ),
              )
          )
        ]
      )
    );
  }


}