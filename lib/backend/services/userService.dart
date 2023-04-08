import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';
import 'package:pitchboxadmin/backend/utility/userInterface.dart';
import 'package:pitchboxadmin/test%20oop/model/user.dart';

class UserService implements UserInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference entrepreneurCollection = FirebaseFirestore.instance.collection('Entrepreneur');
  final CollectionReference investorCollection = FirebaseFirestore.instance.collection('investor');
  final CollectionReference adminCollection = FirebaseFirestore.instance.collection('Admin');

  @override
  Future<DocumentReference> addAdmin(MainUser mainUser) async{
    final docRef = adminCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
    });

    return docRef;
  }

  @override
  Future<DocumentReference> addEntrepreneur(MainUser mainUser) async{
    final docRef = entrepreneurCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
    });

    return docRef;
  }

  @override
  Future<DocumentReference> addInvestor(MainUser mainUser) async{
    final docRef = investorCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
    });

    return docRef;
  }

  @override
  Future<List<MainUser>> getAdminList() async{
    QuerySnapshot querySnapshot = await adminCollection.get();
    List<MainUser> adminList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the business ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],

      );


      adminList.add(mainUser);
    });

    return adminList;
  }


  @override
  Future<List<MainUser>> getEntrepreneurList() async{
    QuerySnapshot querySnapshot = await entrepreneurCollection.get();
    List<MainUser> entrepreneurList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the Entrepreneur ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],

      );


      entrepreneurList.add(mainUser);
    });

    return entrepreneurList;
  }

  @override
  Future<List<MainUser>> getInvestorList() async {
    QuerySnapshot querySnapshot = await investorCollection.get();
    List<MainUser> investotList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the investor ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],

      );


      investotList.add(mainUser);
    });

    return investotList;
  }

  @override
  Future<List<MainUser>> getAdmin(String userName) async{
    QuerySnapshot querySnapshot = await _firestore
        .collection('Admin')
        .where('userName', isEqualTo: userName)
        .get();
    List<MainUser> admins = [];
    querySnapshot.docs.forEach((doc) {
      admins.add(MainUser.fromSnapshot(doc));
    });
    return admins;
  }

  @override
  Future<List<MainUser>> getEntrepreneur(String userName) async{
    QuerySnapshot querySnapshot = await _firestore
        .collection('Entrepreneur')
        .where('userName', isEqualTo: userName)
        .get();
    List<MainUser> entrepreneurs = [];
    querySnapshot.docs.forEach((doc) {
      entrepreneurs.add(MainUser.fromSnapshot(doc));
    });
    return entrepreneurs;
  }

  @override
  Future<List<MainUser>> getInvestor(String userName) async{
    QuerySnapshot querySnapshot = await _firestore
        .collection('investor')
        .where('userName', isEqualTo: userName)
        .get();
    List<MainUser> investors = [];
    querySnapshot.docs.forEach((doc) {
      investors.add(MainUser.fromSnapshot(doc));
    });
    return investors;
  }

  @override
  Future<void> deleteAdmin(String userId) async{
    await _firestore.collection('Admin').doc(userId).delete();
  }

  @override
  Future<void> deleteEntrepreneur(String userId) async{
    await _firestore.collection('Entrepreneur').doc(userId).delete();
  }

  @override
  Future<void> deleteInvestor(String userId) async{
    await _firestore.collection('investor').doc(userId).delete();
  }

  

}