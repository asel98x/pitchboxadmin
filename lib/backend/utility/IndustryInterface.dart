
import '../model/industry.dart';

abstract class IndustryInterface {
  void addIndustry(Industry industry);
  Future<List<Industry>> getIndustries();
  Future<List<Industry>> getIndustry(String industryName);
  Future<void> updateIndustry(Industry industry);
  Future<void> deleteIndustry(String industryId);
}
