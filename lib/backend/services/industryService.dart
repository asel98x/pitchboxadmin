import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/industry.dart';
import 'package:pitchboxadmin/backend/utility/IndustryInterface.dart';

class IndustryService implements IndustryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('industries');


  @override
  Future<DocumentReference> addIndustry(Industry industry) {
    return usersCollection.add(industry.toMap());
  }

  @override
  Future<List<Industry>> getIndustries() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('industries').get();
    List<Industry> industries = [];
    querySnapshot.docs.forEach((doc) {
      industries.add(Industry.fromSnapshot(doc));
    });
    return industries;
  }

  Future<List<Industry>> getIndustry(String industryName) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('industries')
        .where('name', isEqualTo: industryName)
        .get();
    List<Industry> industries = [];
    querySnapshot.docs.forEach((doc) {
      industries.add(Industry.fromSnapshot(doc));
    });
    return industries;
  }



  @override
  Future<void> updateIndustry(Industry industry) async {
    await _firestore
        .collection('industries')
        .doc(industry.id)
        .update(industry.toMap());
  }

  @override
  Future<void> deleteIndustry(String industryId) async {
    await _firestore.collection('industries').doc(industryId).delete();
  }

  @override
  Future<List<String>> getIndustryNames() async {
    QuerySnapshot querySnapshot = await _firestore.collection('industries').get();
    List<String> industryNames = [];
    querySnapshot.docs.forEach((doc) {
      industryNames.add(doc.get('name'));
    });
    return industryNames;
  }
}
