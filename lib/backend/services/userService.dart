import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';
import 'package:pitchboxadmin/backend/utility/userInterface.dart';
import 'package:pitchboxadmin/test%20oop/model/user.dart';

class UserService implements UserInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<DocumentReference> addAdmin(MainUser mainUser) async{
    final docRef = userCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
      'userType': mainUser.userType,
    });

    return docRef;
  }

  @override
  Future<DocumentReference> addEntrepreneur(MainUser mainUser) async{
    final docRef = userCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
      'userType': mainUser.userType,
    });

    return docRef;
  }

  @override
  Future<DocumentReference> addInvestor(MainUser mainUser) async{
    final docRef = userCollection.doc();
    await docRef.set({
      'userId': docRef.id,
      'userName': mainUser.userName,
      'userEmail': mainUser.userEmail,
      'userPassword': mainUser.userPassword,
      'userType': mainUser.userType,
    });

    return docRef;
  }

  @override
  Future<List<MainUser>> getAdminList() async {
    QuerySnapshot querySnapshot =
    await userCollection.where('userType', isEqualTo: 'admin').get();
    List<MainUser> adminList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the business ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],
        userType: doc['userType'],
      );
      adminList.add(mainUser);
    });

    return adminList;
  }



  @override
  Future<List<MainUser>> getEntrepreneurList() async{
    QuerySnapshot querySnapshot =
    await userCollection.where('userType', isEqualTo: 'entrepreneur').get();
    List<MainUser> entrepreneurList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the Entrepreneur ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],
        userType: doc['userType'],

      );


      entrepreneurList.add(mainUser);
    });

    return entrepreneurList;
  }

  @override
  Future<List<MainUser>> getInvestorList() async {
    QuerySnapshot querySnapshot =
    await userCollection.where('userType', isEqualTo: 'investor').get();
    List<MainUser> investotList = [];

    querySnapshot.docs.forEach((doc) {
      MainUser mainUser = MainUser(
        userId: doc.id, // use Firebase's document ID as the investor ID
        userName: doc['userName'],
        userEmail: doc['userEmail'],
        userPassword: doc['userPassword'],
        userType: doc['userType'],

      );


      investotList.add(mainUser);
    });

    return investotList;
  }

  @override
  Future<List<MainUser>> getAdmin(String userName) async{
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
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
        .collection('users')
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
        .collection('users')
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
    await _firestore.collection('users').doc(userId).delete();
  }

  @override
  Future<void> deleteEntrepreneur(String userId) async{
    await _firestore.collection('users').doc(userId).delete();
  }

  @override
  Future<void> deleteInvestor(String userId) async{
    await _firestore.collection('users').doc(userId).delete();
  }

  @override
  Future<void> updateAdmin(MainUser mainUser) async{
    await _firestore
        .collection('users')
        .doc(mainUser.userId)
        .update(mainUser.toMap());
  }

  @override
  Future<void> updateEntrepreneur(MainUser mainUser) async{
    await _firestore
        .collection('users')
        .doc(mainUser.userId)
        .update(mainUser.toMap());
  }

  @override
  Future<void> updateInvestor(MainUser mainUser) async{
    await _firestore
        .collection('users')
        .doc(mainUser.userId)
        .update(mainUser.toMap());
  }

  @override
  Future<List<MainUser>> getUserDetails(String id) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('userId', isEqualTo: id)
        .get();
    List<MainUser> investors = [];
    querySnapshot.docs.forEach((doc) {
      investors.add(MainUser.fromSnapshot(doc));
    });
    return investors;
  }

}