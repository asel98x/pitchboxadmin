import 'package:cloud_firestore/cloud_firestore.dart';

class Industry {
  String id;
  final String name;
  final String imgUrl;

  Industry({
    required this.id,
    required this.name,
    required this.imgUrl,
  });

  factory Industry.fromSnapshot(DocumentSnapshot snapshot) {
    return Industry(
      name: snapshot['name'],
      imgUrl: snapshot['imgUrl'],
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
    };
  }
}
