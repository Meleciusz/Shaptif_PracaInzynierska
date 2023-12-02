import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../model/model.dart';

/*
FirestoreBodyPartsService - service to make requests to Firestore
 */
class FirestoreBodyPartsService{

  //constructor - check internet connection
  FirestoreBodyPartsService(){
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

  //reference to main body parts collection
  final CollectionReference _exerciseCollection =
  FirebaseFirestore.instance.collection('MainBodyParts');

  //function to get body parts
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