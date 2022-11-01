import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/Brew.dart';

class database {
  final String uid;
  database({required this.uid});
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew>? _brewListFromSnapshots(QuerySnapshot snapshot) {
    print('here2');
    return snapshot.docs.map((doc) {
      //print(doc.get("name"));
      return Brew(
        name: doc.get("name") ?? '',
        sugars: doc.get("sugars") ?? '',
        strength: doc.get("strength") ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>?> get brews {
    print('here');
    return brewCollection
        .snapshots()
        .map((event) => _brewListFromSnapshots(event));
  }
}
