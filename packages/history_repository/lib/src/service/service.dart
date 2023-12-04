import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/model.dart';

/*
FirestoreBodyPartsService - service to make requests to Firestore
 */
class FirestoreHistoryService{
  FirestoreExerciseService(){
    _checkInternetConnection();
  }

  //function to check internet connection
  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {

      //if device has internet connection, clear firestore cache
      await clearFirestoreCache();
    }
  }

  //function to clear firestore cache
  Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Error: $e');
    }
  }

  //firestore reference to history
  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('History');


  //function to get history for specific user
  Future<List<History>> getHistoryForUser(String currentUserId) async {
    final querySnapshot = await _exerciseCollection.where('adding_user_id', isEqualTo: currentUserId)
        .orderBy('date', descending: true)
        .get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return History(
          id: doc.id,
          name: data['name'],
          adding_user_id: data['adding_user_id'],
          exercises_name: List<String>.from(data['exercises_name']),
          exercises_sets_count: List<int>.from(data['exercises_sets_count']),
          exercises_weights: List<String>.from(data['exercises_weights']),
          date: data['date']
      );
    }).toList();
  }

  //function to add history record
  Future<void> addHistoricalTraining(History history) async {
    await _exerciseCollection.add({
      'name': history.name,
      'adding_user_id': history.adding_user_id,
      'exercises_name': history.exercises_name,
      'exercises_sets_count': history.exercises_sets_count,
      'exercises_weights': history.exercises_weights,
      'date': history.date
    });
  }

}