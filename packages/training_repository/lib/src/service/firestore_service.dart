import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:training_repository/src/model/model.dart';

class FirestoreTrainingService {
  FirestoreTrainingService() {
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {

      await clearFirestoreCache();
    }
  }

  Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Błąd podczas czyszczenia pamięci podręcznej Firestore: $e');
    }
  }

  final CollectionReference _trainingCollection =
  FirebaseFirestore.instance.collection('Training');

  Future<List<Training>> getTrainings() async {
    final querySnapshot = await _trainingCollection.get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Training(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        addingUserId: data['adding_user_id'],
        addingUserName: data['adding_user_name'],
        exercises: List<String>.from(data['exercises']),
        mainlyUsedBodyPart: data['mainly_used_body_part'],
        verified: data['verified'],
        allBodyParts: List<String>.from(data['all_body_parts']),
        isFinished: List<bool>.from(data['is_finished']),
      );
    }).toList();
  }

  Future<List<Training>> getTrainingsByCategory(String category) async{
    final querySnapshot = await _trainingCollection
        .where('mainly_used_body_part', isEqualTo: category)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Training(
        id: doc.id,
        name: data['name'],
        description: data['description'],
        addingUserId: data['adding_user_id'],
        addingUserName: data['adding_user_name'],
        exercises: List<String>.from(data['exercises']),
        mainlyUsedBodyPart: data['mainly_used_body_part'],
        verified: data['verified'],
        allBodyParts: List<String>.from(data['all_body_parts']),
        isFinished: List<bool>.from(data['is_finished']),
      );
    }).toList();
  }

  Future<void> addTraining(Training training) {
    return _trainingCollection.add({
      'name': training.name,
      'description': training.description,
      'adding_user_id': training.addingUserId,
      'adding_user_name': training.addingUserName,
      'exercises': training.exercises,
      'mainly_used_body_part': training.mainlyUsedBodyPart,
      'verified': training.verified,
      'all_body_parts': training.allBodyParts,
      'is_finished': training.isFinished
    });
  }

  Future<void> deleteTraining(String id) {
    return _trainingCollection.doc(id).delete();
  }

  Future<void> updateTraining(Training training) {
    return _trainingCollection.doc(training.id).update({
      'name': training.name,
      'description': training.description,
      'adding_user_id': training.addingUserId,
      'adding_user_name': training.addingUserName,
      'exercises': training.exercises,
      'mainly_used_body_part': training.mainlyUsedBodyPart,
      'verified': training.verified,
      'all_body_parts': training.allBodyParts,
      'is_finished': training.isFinished
    });
  }
}