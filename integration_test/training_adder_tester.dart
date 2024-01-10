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
  String trainingName = List.generate(20, (index) => random.nextInt(10)).join();

  return trainingName;
}

void main() {

  // Enable integration testing
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  testWidgets('Log in, add training and delete it',
          (WidgetTester tester) async {

            // Run the app
            app.main();
            await tester.pumpAndSettle();

            // Log in
            await logIn(tester);

            // Go to gym mode
            await goToGymMode(tester);

            // Go to new training screen
            await goToTrainingAdder(tester);

            // Initialize objects
            FirebaseFirestore firestore = FirebaseFirestore.instance;
            String trainingName;
            QuerySnapshot snapshot;
            bool exists;
            do{
              trainingName = generateName();

              snapshot = await firestore.collection('Training').where('name', isEqualTo: trainingName).get();
              exists = snapshot.docs.isNotEmpty;
            }while(exists);

            // Add training
            await addTraining(tester, trainingName);

            // Check if training exists
            snapshot = await firestore.collection('Training').where('name', isEqualTo: trainingName).get();
            exists = snapshot.docs.isNotEmpty;
            expect(exists, true);

            // Remove training
            await removeTraining(tester, trainingName);

            // Check if training does not exist
            snapshot = await firestore.collection('Training').where('name', isEqualTo: trainingName).get();
            exists = snapshot.docs.isNotEmpty;
            expect(exists, false);
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

Future<void> goToTrainingAdder(WidgetTester tester) async {
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

Future<void> addTraining(WidgetTester tester, String trainingName) async {
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder addExercisesButton = find.byIcon(Icons.add);
  await tester.tap(addExercisesButton);

  await tester.pumpAndSettle();
  final Finder exercise = find
      .byIcon(Icons.radio_button_unchecked_rounded)
      .first;
  await tester.tap(exercise);

  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final Finder saveExercises = find.byIcon(Icons.save_rounded);
  await tester.tap(saveExercises);
  await Future.delayed(const Duration(seconds: 1));

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  final Finder trainingNameTextField = find.byKey(const Key('trainingName'));
  await tester.enterText(trainingNameTextField, trainingName);
  await Future.delayed(const Duration(seconds: 1));
  await tester.testTextInput.receiveAction(TextInputAction.done);

  await Future.delayed(const Duration(seconds: 1));
  final Finder saveAsNewTraining = find.byIcon(Icons.add_task_rounded);
  await tester.tap(saveAsNewTraining);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> removeTraining(WidgetTester tester, String trainingName) async {
  final Finder closeMenu = find.byIcon(Icons.close);
  await tester.tap(closeMenu);
  await Future.delayed(const Duration(seconds: 1));

  final Finder searchBar = find.byKey(const Key('searchBar'));
  await tester.enterText(searchBar, trainingName);
  await Future.delayed(const Duration(seconds: 2));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await Future.delayed(const Duration(seconds: 1));

  final Finder removeExercise = find
      .byIcon(Icons.remove)
      .first;
  await tester.tap(removeExercise);
  await Future.delayed(const Duration(seconds: 2));
  final Finder confirmRemoving = find.byKey(const Key('delete'));
  await tester.tap(confirmRemoving);
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
}
