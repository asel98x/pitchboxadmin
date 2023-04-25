import 'package:cloud_firestore/cloud_firestore.dart';

class Business {
  String id;
  String businessId;
  String userId;
  String name;
  String mobile;
  String city;
  String country;
  List<String> professionalExperience;
  List<String> entrepreneurshipExperience;
  List<String> education;
  List<String> industryCertifications;
  List<String> awardsAchievements;
  List<String> trackRecord;
  String email;
  String linkedin;
  String twitter;
  String facebook;
  String instagram;
  String Userwebsite;
  String UserImgUrl;

  String businessIndustry;
  String businessName;
  String businessLocation;
  String companyDescription;
  String website;
  String executiveSummary;
  String businessModel;
  String valueProposition;
  String productOrServiceOffering;
  String fundingNeeds;
  String businessImgUrl;

  String fundAmount;
  String avaiableFundAmount;
  String fundPurpose;
  String timeline;
  String fundingSources;
  String investmentTerms;
  String investorBenefits;
  String riskFactors;

  String minimumInvestmentAmount;
  String maximumInvestmentAmount;
  String investmentStage;
  List<String> industryFocus;
  String investorLocation;

  String status;

  Business({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.name,
    required this.mobile,
    required this.city,
    required this.country,
    required this.professionalExperience,
    required this.entrepreneurshipExperience,
    required this.education,
    required this.industryCertifications,
    required this.awardsAchievements,
    required this.trackRecord,
    required this.email,
    required this.linkedin,
    required this.twitter,
    required this.facebook,
    required this.instagram,
    required this.Userwebsite,
    required this.UserImgUrl,
    required this.businessIndustry,
    required this.businessName,
    required this.businessLocation,
    required this.companyDescription,
    required this.website,
    required this.executiveSummary,
    required this.businessModel,
    required this.valueProposition,
    required this.productOrServiceOffering,
    required this.fundingNeeds,
    required this.businessImgUrl,
    required this.fundAmount,
    required this.avaiableFundAmount,
    required this.fundPurpose,
    required this.timeline,
    required this.fundingSources,
    required this.investmentTerms,
    required this.investorBenefits,
    required this.riskFactors,
    required this.minimumInvestmentAmount,
    required this.maximumInvestmentAmount,
    required this.investmentStage,
    required this.industryFocus,
    required this.investorLocation,
    required this.status,
  });

  factory Business.fromSnapshot(DocumentSnapshot snapshot) {
    return Business(
        id: snapshot.id,
        businessId: snapshot['businessId'],
        userId: snapshot['userId'],
        name: snapshot['name'],
        mobile: snapshot['mobile'],
        city: snapshot['city'],
        country: snapshot['country'],
        professionalExperience:
        List<String>.from(snapshot['professionalExperience']),
        entrepreneurshipExperience:
        List<String>.from(snapshot['entrepreneurshipExperience']),
        education: List<String>.from(snapshot['education']),
        industryCertifications:
        List<String>.from(snapshot['industryCertifications']),
        awardsAchievements: List<String>.from(snapshot['awardsAchievements']),
        trackRecord: List<String>.from(snapshot['trackRecord']),
        email: snapshot['email'],
        linkedin: snapshot['linkedin'],
        twitter: snapshot['twitter'],
        facebook: snapshot['facebook'],
        instagram: snapshot['instagram'],
        Userwebsite: snapshot['Userwebsite'],
        UserImgUrl: snapshot['UserImgUrl'],
        businessIndustry: snapshot['businessIndustry'],
        businessName: snapshot['businessName'],
        businessLocation: snapshot['businessLocation'],
        companyDescription: snapshot['companyDescription'],
        website: snapshot['website'],
        executiveSummary: snapshot['executiveSummary'],
        businessModel: snapshot['businessModel'],
        valueProposition: snapshot['valueProposition'],
        productOrServiceOffering: snapshot['productOrServiceOffering'],
        fundingNeeds: snapshot['fundingNeeds'],
        businessImgUrl: snapshot['businessImgUrl'],
        fundAmount: snapshot['fundAmount'],
        avaiableFundAmount:snapshot ['avaiableFundAmount'],
        fundPurpose: snapshot['fundPurpose'],
        timeline: snapshot['timeline'],
        fundingSources: snapshot['fundingSources'],
        investmentTerms: snapshot['investmentTerms'],
        investorBenefits: snapshot['investorBenefits'],
        riskFactors: snapshot['riskFactors'],
        minimumInvestmentAmount: snapshot['minimumInvestmentAmount'],
        maximumInvestmentAmount: snapshot['maximumInvestmentAmount'],
        investmentStage: snapshot['investmentStage'],
        industryFocus: snapshot['industryFocus'].cast<String>(),
        investorLocation: snapshot['investorLocation'],
        status: snapshot['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'userId': userId,
      'name': name,
      'mobile': mobile,
      'city': city,
      'country': country,
      'professionalExperience': professionalExperience,
      'entrepreneurshipExperience': entrepreneurshipExperience,
      'education': education,
      'industryCertifications': industryCertifications,
      'awardsAchievements': awardsAchievements,
      'trackRecord': trackRecord,
      'email': email,
      'linkedin': linkedin,
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'Userwebsite': Userwebsite,
      'UserImgUrl': UserImgUrl,
      'businessIndustry': businessIndustry,
      'businessName': businessName,
      'businessLocation': businessLocation,
      'companyDescription': companyDescription,
      'website': website,
      'executiveSummary': executiveSummary,
      'businessModel': businessModel,
      'valueProposition': valueProposition,
      'productOrServiceOffering': productOrServiceOffering,
      'fundingNeeds': fundingNeeds,
      'businessImgUrl': businessImgUrl,
      'fundAmount': fundAmount,
      'avaiableFundAmount': avaiableFundAmount,
      'fundPurpose': fundPurpose,
      'timeline': timeline,
      'fundingSources': fundingSources,
      'investmentTerms': investmentTerms,
      'investorBenefits': investorBenefits,
      'riskFactors': riskFactors,
      'minimumInvestmentAmount': minimumInvestmentAmount,
      'maximumInvestmentAmount': maximumInvestmentAmount,
      'investmentStage': investmentStage,
      'industryFocus': industryFocus,
      'investorLocation': investorLocation,
      'status': status,
    };
  }
}