import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/services/businessService.dart';

class BusinessController {
  final _BusinessService = BusinessService();
  List<Map<String, dynamic>> _newBusinesses = [];
  List<Map<String, dynamic>> get newBusinesses => _newBusinesses;

  Future<void> addNewBusiness({
    required String businessId,
    required String userId,
    required String name,
    required String email,
    required String mobile,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    required String industry,
    required String linkedin,
    required String twitter,
    required String facebook,
    required String instagram,
    required String Userwebsite,
    required String provider,
    required String imgUrl,
    required String pass,
    required List<String> professionalExperience,
    required List<String> entrepreneurshipExperience,
    required List<String> education,
    required List<String> industryCertifications,
    required List<String> awardsAchievements,
    required List<String> trackRecord,
    required String businessIndustry,
    required String businessName,
    required String businessLocation,
    required String companyDescription,
    required String website,
    required String executiveSummary,
    required String businessModel,
    required String valueProposition,
    required String productOrServiceOffering,
    required String fundingNeeds,
    required String fundAmount,
    required String fundPurpose,
    required String timeline,
    required String fundingSources,
    required String investmentTerms,
    required String investorBenefits,
    required String riskFactors,
    required String minimumInvestmentAmount,
    required String maximumInvestmentAmount,
    required String investmentStage,
    required List<String> industryFocus,
    required String investorLocation,
    required String investmentGoal,
    required String investmentCriteria,
  }) async {
    final business = Business(
      id: '',
      userId: userId ,
      name: name,
      email: email,
      mobile: mobile,
      city: city,
      country: country,
      linkedin: linkedin,
      twitter: twitter,
      facebook: facebook,
      instagram: instagram,
      Userwebsite: Userwebsite,
      professionalExperience: professionalExperience,
      entrepreneurshipExperience: entrepreneurshipExperience,
      education: education,
      industryCertifications: industryCertifications,
      awardsAchievements: awardsAchievements,
      trackRecord: trackRecord,

      businessId: '',
      businessIndustry: businessIndustry,
      businessName: businessName,
      businessLocation: businessLocation,
      companyDescription: companyDescription,
      website: website,
      executiveSummary: executiveSummary,
      businessModel: businessModel,
      valueProposition: valueProposition,
      productOrServiceOffering: productOrServiceOffering,
      fundingNeeds: fundingNeeds,

      fundAmount: fundAmount,
      fundPurpose: fundPurpose,
      timeline: timeline,
      fundingSources: fundingSources,
      investmentTerms: investmentTerms,
      investorBenefits: investorBenefits,
      riskFactors: riskFactors,

      minimumInvestmentAmount: minimumInvestmentAmount,
      maximumInvestmentAmount: maximumInvestmentAmount,
      investmentStage: investmentStage,
      industryFocus: industryFocus,
      investorLocation: investorLocation,
    );



    await _BusinessService.addNewBusiness(business);
  }

  Future<List<Business>> getNewBusinesses() async {
    List<Business> newBusinesses =
    await _BusinessService.getNewBusinessesList();
    return newBusinesses;
  }
}