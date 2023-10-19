import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../model/model.dart';

class FirestoreBodyPartsService{
  FirestoreBodyPartsService(){
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

  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('MainBodyParts');

  Future<List<BodyParts>> getBodyParts() async {
    final querySnapshot = await _exerciseCollection.get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return BodyParts(
        id: data['id'],
        part : data['part'],
      );
    }).toList();
  }
}