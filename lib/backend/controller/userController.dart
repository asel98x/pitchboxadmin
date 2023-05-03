import 'package:flutter/material.dart';
import 'package:pitchboxadmin/backend/model/mainUser.dart';
import 'package:pitchboxadmin/backend/services/userService.dart';

class UserController {
  final _userService = UserService();

  Future<void> addAdmin({
  required String userId,
  required String userName,
  required String userEmail,
  required String userPassword,
  required String userType,

  })async {
    final mainUser = MainUser(
        userId: userId,
        userName: userName,
        userEmail: userEmail,
        userPassword: userPassword,
        userType: userType
    );

    await _userService.addAdmin(mainUser);

  }

  Future<void> addEntrepreneur({
    required String userId,
    required String userName,
    required String userEmail,
    required String userPassword,
    required String userType,
  })async {
    final mainUser = MainUser(
        userId: userId,
        userName: userName,
        userEmail: userEmail,
        userPassword: userPassword,
        userType: userType);

    await _userService.addEntrepreneur(mainUser);
  }


  Future<void> addInvestor({
    required String userId,
    required String userName,
    required String userEmail,
    required String userPassword,
    required String userType,
  })async {
    final mainUser = MainUser(
        userId: userId,
        userName: userName,
        userEmail: userEmail,
        userPassword: userPassword,
        userType: userType);

    await _userService.addInvestor(mainUser);
  }

  Future<List<MainUser>> getAdminList() async {
    List<MainUser> AdminList = await _userService.getAdminList();
    return AdminList;
  }

  Future<List<MainUser>> getInvestorList() async {
    List<MainUser> investotList = await _userService.getInvestorList();
    return investotList;
  }

  Future<List<MainUser>> getEntrepreneurList() async {
    List<MainUser> entrepreneurList = await _userService.getEntrepreneurList();
    return entrepreneurList;
  }

  Future<List<MainUser>> getAdmin(String userName) async {
    return await _userService.getAdmin(userName);
  }

  Future<List<MainUser>> getEntrepreneur(String userName) async {
    return await _userService.getEntrepreneur(userName);
  }

  Future<List<MainUser>> getInvestor(String userName) async {
    return await _userService.getInvestor(userName);
  }

  Future<void> updateAdmin(String id, String name, String email, String password, String userType) async {
    try{
      MainUser mainUser = MainUser(
          userId: id,
          userName: name,
          userEmail: email,
          userPassword: password,
          userType: userType);
        await _userService.updateAdmin(mainUser);

    }catch(e){
      debugPrint('Error updating user: $e');
    }

  }

  Future<void> updateEntrepreneur(String id, String name, String email, String password, String userType) async {
    try{
      MainUser mainUser = MainUser(
          userId: id,
          userName: name,
          userEmail: email,
          userPassword: password,
          userType: userType);
      await _userService.updateEntrepreneur(mainUser);

    }catch(e){
      debugPrint('Error updating user: $e');
    }

  }

  Future<void> updateInvestor(String id, String name, String email, String password, String userType) async {
    try{
      MainUser mainUser = MainUser(
          userId: id,
          userName: name,
          userEmail: email,
          userPassword: password,
          userType: userType);
      await _userService.updateInvestor(mainUser);

    }catch(e){
      debugPrint('Error updating user: $e');
    }

  }

  Future<void> deleteAdmin(String userId) async {
    await _userService.deleteAdmin(userId);
  }

  Future<void> deleteEntrepreneur(String userId) async {
    await _userService.deleteEntrepreneur(userId);
  }

  Future<void> deleteInvestor(String userId) async {
    await _userService.deleteInvestor(userId);
  }

  Future<List<MainUser>> getUserDetails(String id) async {
    return await _userService.getUserDetails(id);
  }
}
