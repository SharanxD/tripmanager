import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripmanager/modals/places.dart';

class FirebaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addPlace(places place) async {
    Map<String, dynamic> obj = {
      "Name": place.PlaceName,
      "Location": place.PlaceLocation,
      "Imageurl": place.imageurl,
      "visited": place.visited,
      "datevisited": place.datevisited,
      "remarks": place.remarks
    };
    String docId = place.PlaceName;
    final DocumentReference tasksRef =
        firestore.collection("Places").doc(docId);
    await tasksRef.set(obj);
    print("Added");
  }

  Future<List> readPlace() async {
    List<places> placeslist = [];
    final snapshot = await firestore.collection("Places").get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    for (DocumentSnapshot element in documents) {
      placeslist.add(places(
          PlaceName: element["Name"],
          PlaceLocation: element["Location"],
          visited: element["visited"],
          datevisited: element["datevisited"],
          imageurl: element["Imageurl"],
          remarks: element["remarks"]));
    }
    return placeslist;
  }

  Future<void> deleteplace(places place) async {
    String docid = place.PlaceName;
    await firestore.collection("Places").doc(docid).delete();
  }

  Future<void> visitplace(places place, String url) async {
    print(url);
    DocumentReference docref =
        firestore.collection("Places").doc(place.PlaceName);
    docref.update({
      'visited': true,
      'datevisited':
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      'Imageurl': url
    });
  }
}
