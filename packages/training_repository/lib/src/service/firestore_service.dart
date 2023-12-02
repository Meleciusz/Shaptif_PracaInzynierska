import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:training_repository/src/model/model.dart';

/*
FirestoreBodyPartsService - service to make requests to Firestore
 */
class FirestoreTrainingService {
  FirestoreTrainingService() {
    _checkInternetConnection();
  }

  //function to check internet connection
  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {

      //function to check internet connection
      await clearFirestoreCache();
    }
  }

  //function to clear firestore cache
  Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Błąd podczas czyszczenia pamięci podręcznej Firestore: $e');
    }
  }

  //reference to training collection
  final CollectionReference _trainingCollection =
  FirebaseFirestore.instance.collection('Training');

  //function to get all trainings of user
  Future<List<Training>> getAllTrainings(String userID) async {
    final querySnapshot = await _trainingCollection
        .where('adding_user_id', isEqualTo: userID)
        .get();


    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Training(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        addingUserId: data['adding_user_id'],
        exercises: List<String>.from(data['exercises']),
        mainlyUsedBodyPart: data['mainly_used_body_part'],
        verified: data['verified'],
        allBodyParts: List<String>.from(data['all_body_parts']),
        isFinished: List<bool>.from(data['is_finished']),
      );
    }).toList();
  }


  //function to get trainings by category of user
  Future<List<Training>> getTrainingsByCategory(String category, String userID) async{
    final querySnapshot = await _trainingCollection
        .where('mainly_used_body_part', isEqualTo: category)
        .where('adding_user_id', isEqualTo: userID)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Training(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        addingUserId: data['adding_user_id'],
        exercises: List<String>.from(data['exercises']),
        mainlyUsedBodyPart: data['mainly_used_body_part'],
        verified: data['verified'],
        allBodyParts: List<String>.from(data['all_body_parts']),
        isFinished: List<bool>.from(data['is_finished']),
      );
    }).toList();
  }

  //function to add training
  Future<void> addTraining(Training training) {
    return _trainingCollection.add({
      'name': training.name,
      'description': training.description,
      'adding_user_id': training.addingUserId,
      'exercises': training.exercises,
      'mainly_used_body_part': training.mainlyUsedBodyPart,
      'verified': training.verified,
      'all_body_parts': training.allBodyParts,
      'is_finished': training.isFinished
    });
  }

  //function to delete training
  Future<void> deleteTraining(String id) {
    return _trainingCollection.doc(id).delete();
  }

  //function to update training
  Future<void> updateTraining(Training training) {
    return _trainingCollection.doc(training.id).update({
      'name': training.name,
      'description': training.description,
      'adding_user_id': training.addingUserId,
      'exercises': training.exercises,
      'mainly_used_body_part': training.mainlyUsedBodyPart,
      'verified': training.verified,
      'all_body_parts': training.allBodyParts,
      'is_finished': training.isFinished
    });
  }
}