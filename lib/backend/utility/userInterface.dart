
import 'package:pitchboxadmin/backend/model/mainUser.dart';


abstract class UserInterface {
  void addInvestor(MainUser mainUser);
  void addEntrepreneur(MainUser MainUser);
  void addAdmin(MainUser MainUser);
  Future<List<MainUser>> getUserDetails(String id);

  Future<List<MainUser>> getEntrepreneurList();
  Future<List<MainUser>> getInvestorList();
  Future<List<MainUser>> getAdminList();

  Future<List<MainUser>> getAdmin(String userName);
  Future<List<MainUser>> getInvestor(String userName);
  Future<List<MainUser>> getEntrepreneur(String userName);

  Future<void> updateAdmin(MainUser mainUser);
  Future<void> updateInvestor(MainUser mainUser);
  Future<void> updateEntrepreneur(MainUser mainUser);

  Future<void> deleteAdmin(String userId);
  Future<void> deleteInvestor(String userId);
  Future<void> deleteEntrepreneur(String userId);
}