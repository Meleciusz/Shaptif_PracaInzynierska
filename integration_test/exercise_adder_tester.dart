import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shaptifii/main.dart' as app;

// Generate a random name
String generateName() {
  final random = Random();
  String exerciseName = List.generate(20, (index) => random.nextInt(10)).join();

  return exerciseName;
}

void main() {

  // Enable integration testing
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  testWidgets('Log in, add exercise',
          (WidgetTester tester) async {

        // Run the app
        app.main();
        await tester.pumpAndSettle();

        // Log in
        await logIn(tester);

        // Go to gym mode
        await goToGymMode(tester);

        // Go to exercise screen
        await goToExerciseScreen(tester);

        // Go to exercise adder
        await goToExerciseAdder(tester);

        // Initialize objects
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        String exerciseName;
        QuerySnapshot snapshot;
        bool exists;
        do{
          exerciseName = generateName();

          snapshot = await firestore.collection('Exercise').where('name', isEqualTo: exerciseName).get();
          exists = snapshot.docs.isNotEmpty;
        }while(exists);

        // Add exercise
        await addExercise(tester, exerciseName);

        // Check if exercise exists
        snapshot = await firestore.collection('Exercise').where('name', isEqualTo: exerciseName).get();
        exists = snapshot.docs.isNotEmpty;
        expect(exists, true);

      });
}

Future<void> logIn(WidgetTester tester) async {
  final Finder emailTextField = find.byKey(const Key('loginForm_emailInput_textField'));
  final Finder passwordTextField = find.byKey(const Key('loginForm_passwordInput_textField'));
  final Finder logInButton = find.byKey(const Key('loginForm_continue_raisedButton'));

  await tester.enterText(emailTextField, 'mikini@o2.pl');
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(passwordTextField, 'mikini12');
  await Future.delayed(const Duration(seconds: 1));
  await tester.testTextInput.receiveAction(TextInputAction.done);

  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.tap(logInButton);
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> goToGymMode(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder gymModeButton = find.byKey(const Key('gymModeButton'));
  await tester.tap(gymModeButton);
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> goToExerciseScreen(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder menuButton = find.byIcon(Icons.switch_left_rounded);
  await tester.tap(menuButton);
  await tester.pumpAndSettle();
}

Future<void> goToExerciseAdder(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder menuButton = find.byIcon(Icons.menu);
  await tester.tap(menuButton);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  final Finder addButton = find.byIcon(Icons.add);
  await tester.tap(addButton);
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> addExercise(WidgetTester tester, String exerciseName) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));


  await tester.drag(
    find.byType(Flexible),
    const Offset(0, -500),
  );
  await tester.pumpAndSettle();


  final Finder exercise = find
      .byIcon(Icons.radio_button_unchecked_outlined)
      .first;
  await tester.tap(exercise);

  await tester.drag(
    find.byType(Flexible),
    const Offset(0, 500),
  );
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder trainingNameTextField = find.byKey(const Key('exerciseName'));
  await tester.enterText(trainingNameTextField, exerciseName);
  await Future.delayed(const Duration(seconds: 1));
  await tester.testTextInput.receiveAction(TextInputAction.done);

  await Future.delayed(const Duration(seconds: 2));
  final Finder saveAsNewTraining = find.byIcon(Icons.add_task_rounded);
  await tester.tap(saveAsNewTraining);
  await Future.delayed(const Duration(seconds: 1));

  await tester.pumpAndSettle();
}

