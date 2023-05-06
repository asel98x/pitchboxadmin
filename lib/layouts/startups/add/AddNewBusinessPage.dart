import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/IndustryController.dart';
import 'package:pitchboxadmin/backend/controller/businessController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/services/businessService.dart';
import 'package:pitchboxadmin/layouts/dashboard.dart';


class AddBusinessPage extends StatefulWidget {
  const AddBusinessPage({Key? key}) : super(key: key);

  @override
  _AddBusinessPageState createState() =>
      _AddBusinessPageState();
}

class _AddBusinessPageState extends State<AddBusinessPage> {
  final _formKey = GlobalKey<FormState>();
  List<bool> _stepCompleted = [true, true, true, true,true];
  int _activeStepIndex = 0;
  bool isSubmitting = false;
  File? _imageFile;
  File? _bimageFile;

  //List<BusinessTeam> _teamMembersList = [];
  BusinessService _businessService = BusinessService();
  BusinessController _businessController = BusinessController();

  //====================================================================================//
  //----------------------Personal Information------------------------------------------//
  //====================================================================================//
  final _userIdController = TextEditingController();
  final _fullNameController = TextEditingController(text: 'Asel Algama');
  final _phoneController = TextEditingController(text: '+94765432014');
  final _cityController = TextEditingController(text: 'Los Angeles');
  final _countryController = TextEditingController(text: 'America');
  final _industryController = IndustryController();
  final _professionalExperienceController = <TextEditingController>[
    TextEditingController(text: 'Worked as a Senior Manager at ABC Corporation for 5 years'),
    TextEditingController(text: 'Managed a team of 10 employees at XYZ Company for 3 years'),
  ];
  final _entrepreneurshipExperienceController = <TextEditingController>[
    TextEditingController(text: 'Co-founded a tech startup that was acquired by a larger company'),
    TextEditingController(text: 'Started a successful consulting business that generated six-figure revenue in the first year'),
  ];
  final _educationController = <TextEditingController>[
    TextEditingController(text: 'Bachelors degree in Business Administration from XYZ University'),
    TextEditingController(text: 'Masters degree in Finance from ABC University'),
  ];
  final _industryCertificationsController = <TextEditingController>[
    TextEditingController(text: 'Certified Public Accountant (CPA)'),
    TextEditingController(text: 'Chartered Financial Analyst (CFA)'),
  ];
  final _awardsAchievementsController = <TextEditingController>[
    TextEditingController(text: 'Named "Top 40 under 40" by Forbes Magazine'),
    TextEditingController(text: 'Received "Entrepreneur of the Year" award from the Chamber of Commerce'),
  ];
  final _trackRecordController = <TextEditingController>[
    TextEditingController(text: 'Successfully invested in multiple startups that have gone public'),
    TextEditingController(text: 'Has a portfolio of real estate properties that generate passive income'),
  ];
  final _emailController = TextEditingController(text: 'vinjith98@gmail.com');
  final _facebookController = TextEditingController(text: 'www.facebook.com');
  final _twitterController = TextEditingController(text: 'www.twitter.com');
  final _instagramController = TextEditingController(text: 'www.instagram.com');
  final _linkedinController = TextEditingController(text: 'www.linkedin.com');
  final _websiteController = TextEditingController(text: 'www.pitchbox.com');

  //====================================================================================//
  //----------------------Business Information------------------------------------------//
  //====================================================================================//
  final _businessName = TextEditingController(text: 'Pitchbox');
  final _businessIndustry = TextEditingController(text: 'Investment');
  final _businessLocation = TextEditingController(text: 'America');
  final _companyDescription = TextEditingController(text: 'Our company is a mobile app development company that specializes in creating investment apps.');
  final _website2 = TextEditingController(text: 'www.pitchbox.com');
  final _executiveSummary = TextEditingController(text: 'Connecting entrepreneurs and investors for a better future.');
  final _businessModel = TextEditingController(text: 'Our company will generate revenue by taking a percentage of the funding that is raised through our platform.');
  final _valueProposition = TextEditingController(text: 'Our platform uses machine learning algorithms to match entrepreneurs and investors based on their needs and preferences. This ensures that entrepreneurs are connected with investors who are interested in their ideas, and investors are connected with entrepreneurs whose plans match with their own investment goals.');
  final _productOrServiceOffering = TextEditingController(text: 'Our mobile app will allow entrepreneurs to create listings for their business ideas and seek funding from investors. Investors will be able to browse through these listings and get in touch with entrepreneurs whose plans match with their own investment goals.');
  final _fundingNeeds = TextEditingController(text: 'We need \$500,000 in funding to develop our mobile app and launch it in the market.');

  //====================================================================================//
  //----------------------Business Team Information-------------------------------------//
  //====================================================================================//
  final _teamMember = TextEditingController();
  final _teamMemberRole = TextEditingController();
  final _teamMemberExperience = TextEditingController();
  final _teamMemberAchievements = TextEditingController();
  final _teamMemberLinkedInProfiles = TextEditingController();
  final _teamMemberResponsibilities = TextEditingController();
  final _teamCulture = TextEditingController();

  //====================================================================================//
  //----------------------Funding Requirments------------------------------------------//
  //====================================================================================//
  final _fundAmount = TextEditingController(text: '500000');
  final _fundPurpose = TextEditingController(text: 'Develop app prototype - 3 months; Launch beta version - 6 months; Launch full version - 9 months.');
  final _timeline = TextEditingController(text: 'Develop app prototype - 3 months; Launch beta version - 6 months; Launch full version - 9 months.');
  final _fundingSources = TextEditingController(text: 'We plan to get funding from angel investors and venture capitalists.');
  final _investmentTerms = TextEditingController(text: 'We are offering equity in our company in exchange for funding.');
  final _investorBenefits = TextEditingController(text: 'Investors will receive equity in our company based on the amount of funding they provide.');
  final _riskFactors = TextEditingController(text: 'Our success depends on our ability to attract both entrepreneurs and investors to our platform. If we are unable to do so, our business may fail.');

  //====================================================================================//
  //----------------------Funding Requirments------------------------------------------//
  //====================================================================================//
  final _minimumInvestmentAmount = TextEditingController(text: '1000');
  final _maximumInvestmentAmount = TextEditingController(text: '10000');
  final List<String> _selectedInvestmentStage = ['seed', 'early-stage', 'growth-stage'];
  String? _selectedInvestmentExperience;
  List<String> _industryFocus = [];
  final _geographicLocation = TextEditingController(text: 'America');
  final List<String> _status = ['Pending', 'Accepted', 'Rejected'];
  String? _selectedstatus;



  @override
  void initState() {
    super.initState();
  }

  void _addProfessionalExperienceField() {
    setState(() {
      _professionalExperienceController.add(TextEditingController());
    });
  }

  void _addEntrepreneurshipExperienceField() {
    setState(() {
      _entrepreneurshipExperienceController.add(TextEditingController());
    });
  }

  void _addEducationExperienceField() {
    setState(() {
      _educationController.add(TextEditingController());
    });
  }

  void _addindustryCertificationsField() {
    setState(() {
      _industryCertificationsController.add(TextEditingController());
    });
  }

  void _addawardsAchievementsField() {
    setState(() {
      _awardsAchievementsController.add(TextEditingController());
    });
  }

  void _addtrackRecordField() {
    setState(() {
      _trackRecordController.add(TextEditingController());
    });
  }


  void _addValue() async {
    //----------------------Personal Information------------------------------------------//
    late String userId= _userIdController.text;
    late String fullName= _fullNameController.text;
    late String mobile= _phoneController.text;
    late String city= _cityController.text;
    late String country= _countryController.text;
    late List<String> professionalExperience= _professionalExperienceController.map((e) => e.text).toList();
    late List<String> entrepreneurshipExperience= _entrepreneurshipExperienceController.map((e) => e.text).toList();
    late List<String> education= _educationController.map((e) => e.text).toList();
    late List<String> industryCertifications= _industryCertificationsController.map((e) => e.text).toList();
    late List<String> awardsAchievements= _awardsAchievementsController.map((e) => e.text).toList();
    late List<String> trackRecord= _trackRecordController.map((e) => e.text).toList();
    late String email= _emailController.text;
    late String linkedin= _linkedinController.text;
    late String twitter= _twitterController.text;
    late String facebook= _facebookController.text;
    late String instagram= _instagramController.text;
    late String Userwebsite= _websiteController.text;
    File? Uimage = _imageFile;


    //----------------------Business Information------------------------------------------//
    late String businessName= _businessName.text;
    late String businessIndustry= _businessIndustry.text;
    late String businessLocation= _businessLocation.text;
    late String executiveSummary= _executiveSummary.text;
    late String companyDescription= _companyDescription.text;
    late String businessModel= _businessModel.text;
    late String valueProposition= _valueProposition.text;
    late String productOrServiceOffering= _productOrServiceOffering.text;
    late String fundingNeeds= _fundingNeeds.text;
    late String website2 = _website2.text;
    File? Bimage = _bimageFile;

    //----------------------Funding Requirments------------------------------------------//

    late String fundAmount = _fundAmount.text;
    late String fundPurpose = _fundPurpose.text;
    late String timeline = _timeline.text;
    late String fundingSources = _fundingSources.text;
    late String investmentTerms = _investmentTerms.text;
    late String investorBenefits = _investorBenefits.text;
    late String riskFactors = _riskFactors.text;

    //late List<BusinessTeam> teamMembersList = _teamMembersList;


    //----------------------Funding Requirments------------------------------------------//
    late String minimumInvestmentAmount = _minimumInvestmentAmount.text;
    late String maximumInvestmentAmount = _maximumInvestmentAmount.text;
    late String investorLocation = _geographicLocation.text;
    String? selectedInvestmentExperience=  _selectedInvestmentExperience;
    late List<String> industryFocus =  _industryFocus;
    String? selectedstatus=  _selectedstatus;



    try{
      await _businessController.addNewBusiness(

            id: userId,
            businessId: 'businessId',
            userId: userId,
            name: fullName,
            mobile: mobile,
            city: city,
            country: country,
            professionalExperience: professionalExperience,
            entrepreneurshipExperience: entrepreneurshipExperience,
            education: education,
            industryCertifications: industryCertifications,
            awardsAchievements: awardsAchievements,
            trackRecord: trackRecord,
            email: email,
            linkedin: linkedin,
            twitter: twitter,
            facebook: facebook,
            instagram: instagram,
            Userwebsite: Userwebsite,
            UserImgUrl: Uimage!,


            businessIndustry: businessIndustry,
            businessName: businessName,
            businessLocation: businessLocation,
            companyDescription: companyDescription,
            website: website2,
            executiveSummary: executiveSummary,
            businessModel: businessModel,
            valueProposition: valueProposition,
            productOrServiceOffering: productOrServiceOffering,
            fundingNeeds: fundingNeeds,
            businessImgUrl: Bimage!,

            fundAmount: fundAmount,
            avaiableFundAmount: '0',
            fundPurpose: fundPurpose,
            timeline: timeline,
            fundingSources: fundingSources,
            investmentTerms: investmentTerms,
            investorBenefits: investorBenefits,
            riskFactors: riskFactors,
            minimumInvestmentAmount: minimumInvestmentAmount,
            maximumInvestmentAmount: maximumInvestmentAmount,
            investmentStage: selectedInvestmentExperience!,
            industryFocus: industryFocus,
            investorLocation: investorLocation,
            status: selectedstatus!,
            street: '',
            state: '',
            zipCode: '',
            industry: '',
            investmentCriteria: '',
            investmentGoal: '',
            pass: '',
            provider: '',

      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Business idea added successfully!'),
        )
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Dashboard()),
      );

    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add Business idea'),
        ),
      );
      print(e.toString());
    }

  }

  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Personal Information'),
      content: Container(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            TextFormField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter User ID';
                }
                return null;
              },
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Business Name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Mobile number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter City';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Country';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Professional Experience",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Professional Experience",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _professionalExperienceController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                            _professionalExperienceController[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _professionalExperienceController
                                  .removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addProfessionalExperienceField();
              },
            ),
            SizedBox(height: 20),

            //--------------------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Entrepreneurship Exp.",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Entrepreneurship Experience",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _entrepreneurshipExperienceController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                            _entrepreneurshipExperienceController[
                            index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _entrepreneurshipExperienceController
                                  .removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addEntrepreneurshipExperienceField();
              },
            ),

            //--------------------------------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Education",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Education",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _educationController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _educationController[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _educationController.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addEducationExperienceField();
              },
            ),

            //--------------------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Industry Certifications",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Industry Certifications",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _industryCertificationsController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                            _industryCertificationsController[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _industryCertificationsController
                                  .removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addindustryCertificationsField();
              },
            ),

            //--------------------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Awards Achievements",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Awards Achievements",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _awardsAchievementsController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                            _awardsAchievementsController[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _awardsAchievementsController.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addawardsAchievementsField();
              },
            ),

            //--------------------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Track Record",
                  style: ralewayStyle.copyWith(
                    fontSize: 18.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  tooltip: "Track Record",
                  onPressed: () {},
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _trackRecordController.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _trackRecordController[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: AppColors.redColor,
                          onPressed: () {
                            setState(() {
                              _trackRecordController.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add'),
              onPressed: () {
                _addtrackRecordField();
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                suffixIcon: Tooltip(
                  message: 'enter Email',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _linkedinController,
              decoration: InputDecoration(
                labelText: 'Linkedin profile',
                suffixIcon: Tooltip(
                  message: 'enter Linkedin profile link',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _facebookController,
              decoration: InputDecoration(
                labelText: 'Facebook profile',
                suffixIcon: Tooltip(
                  message: 'enter Facebook profile link',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _twitterController,
              decoration: InputDecoration(
                labelText: 'Twitter profile',
                suffixIcon: Tooltip(
                  message: 'enter Twitter profile link',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _instagramController,
              decoration: InputDecoration(
                labelText: 'Instagram profile',
                suffixIcon: Tooltip(
                  message: 'enter Instagram profile link',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: 'Website',
                suffixIcon: Tooltip(
                  message: 'enter Website link',
                  child: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _imageFile != null
                ? Image.file(
              _imageFile!,
              height: 100.0,
              width: 100.0,
            )
                : Container(),
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    _imageFile = File(pickedFile.path);
                  }
                });
              },
              child: Text('Add Image'),
            ),
          ],
        ),
      ),
    ),

    //====================================================================================//
    //----------------------Business Information------------------------------------------//
    //====================================================================================//

    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Business Information'),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _businessName,
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  suffixIcon: Tooltip(
                    message: 'Business Name',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Business Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _businessIndustry,
                decoration: InputDecoration(
                  labelText: 'Business Industry',
                  suffixIcon: Tooltip(
                    message: 'Business Industry',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Business Industry';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _businessLocation,
                decoration: InputDecoration(
                  labelText: 'Business Location',
                  suffixIcon: Tooltip(
                    message: 'Business Location',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Business Location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _executiveSummary,
                decoration: InputDecoration(
                  labelText: 'Executive Summary',
                  suffixIcon: Tooltip(
                    message: 'Executive Summary',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Executive Summary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _companyDescription,
                decoration: InputDecoration(
                  labelText: 'Company Description',
                  suffixIcon: Tooltip(
                    message: 'Company Description',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Company Description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _businessModel,
                decoration: InputDecoration(
                  labelText: 'Business Model',
                  suffixIcon: Tooltip(
                    message: 'Business Model',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Business Model';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _valueProposition,
                decoration: InputDecoration(
                  labelText: ' Value Proposition',
                  suffixIcon: Tooltip(
                    message: 'Value Proposition',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Value Proposition';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _productOrServiceOffering,
                decoration: InputDecoration(
                  labelText: ' Product Or Service Offering',
                  suffixIcon: Tooltip(
                    message: 'Product Or Service Offering',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Or Service Offering';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _fundingNeeds,
                decoration: InputDecoration(
                  labelText: 'Funding Needs',
                  suffixIcon: Tooltip(
                    message: 'Funding Needs',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Funding Needs';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _website2,
                decoration: InputDecoration(
                  labelText: 'Website',
                  suffixIcon: Tooltip(
                    message: 'Website',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Website';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _bimageFile != null
                  ? Image.file(
                _bimageFile!,
                height: 100.0,
                width: 100.0,
              )
                  : Container(),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedFile != null) {
                      _bimageFile = File(pickedFile.path);
                    }
                  });
                },
                child: Text('Add Image'),
              ),
            ],
          ),
        )),
    //====================================================================================//
    //----------------------Business Team Information-------------------------------------//
    //====================================================================================//
    // Step(
    //   state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
    //   isActive: _activeStepIndex >= 2,
    //   title: const Text('Business Team Information'),
    //   content: SingleChildScrollView(
    //     child: Container(
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "Team members",
    //                 style: ralewayStyle.copyWith(
    //                   fontSize: 18.0,
    //                   color: AppColors.blueDarkColor,
    //                   fontWeight: FontWeight.w100,
    //                 ),
    //               ),
    //               IconButton(
    //                 icon: Icon(Icons.info_outline),
    //                 tooltip: "Team members",
    //                 onPressed: () {},
    //               ),
    //             ],
    //           ),
    //           Divider(
    //             height: 15,
    //             thickness: 2,
    //           ),
    //           // ListView.builder(
    //           //   shrinkWrap: true,
    //           //   physics: const NeverScrollableScrollPhysics(),
    //           //   itemCount: _teamMembersList.length + 1,
    //           //   itemBuilder: (BuildContext context, int index) {
    //           //     if (index == _teamMembersList.length) {
    //           //       return Padding(
    //           //         padding: EdgeInsets.symmetric(horizontal: 16.0),
    //           //         child: ElevatedButton(
    //           //           child: Text('Add Team Member'),
    //           //           onPressed: () {
    //           //             setState(() {
    //           //               _teamMembersList.add(BusinessTeam(
    //           //                 teamMemberId: '',
    //           //                 teamMember: _teamMember.text,
    //           //                 teamMemberRole: _teamMemberRole.text,
    //           //                 teamMemberExperience: _teamMemberExperience.text,
    //           //                 teamMemberAchievements: _teamMemberAchievements.text,
    //           //                 teamMemberLinkedIn_Profiles: _teamMemberLinkedInProfiles.text,
    //           //                 teamMemberResponsibilities: _teamMemberResponsibilities.text,
    //           //                 teamCulture: _teamCulture.text,
    //           //               ));
    //           //             });
    //           //           },
    //           //         ),
    //           //       );
    //           //     } else {
    //           //       return Padding(
    //           //         padding: EdgeInsets.symmetric(horizontal: 16.0),
    //           //         child: Stack(
    //           //           children: [
    //           //             Column(
    //           //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //           //               children: [
    //           //                 Row(
    //           //                   mainAxisAlignment:
    //           //                   MainAxisAlignment.spaceBetween,
    //           //                   children: [
    //           //                     Text(
    //           //                       'Team Member ${index + 1}',
    //           //                       style: TextStyle(
    //           //                         fontWeight: FontWeight.normal,
    //           //                         fontSize: 18.0,
    //           //                       ),
    //           //                     ),
    //           //                     IconButton(
    //           //                       icon: Icon(Icons.remove_circle),
    //           //                       color: AppColors.redColor,
    //           //                       onPressed: () {
    //           //                         setState(() {
    //           //                           _teamMembersList.removeAt(index);
    //           //                         });
    //           //                       },
    //           //                     ),
    //           //                   ],
    //           //                 ),
    //           //                 TextFormField(
    //           //                   initialValue:
    //           //                   _teamMembersList[index].teamMember,
    //           //                   decoration:InputDecoration(
    //           //                     labelText: 'Name',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index].teamMember =
    //           //                           value;
    //           //                     });
    //           //                   },
    //           //
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue:
    //           //                   _teamMembersList[index].teamMemberRole,
    //           //                   decoration:
    //           //                   InputDecoration(labelText: 'Role',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index].teamMemberRole =
    //           //                           value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue: _teamMembersList[index]
    //           //                       .teamMemberExperience,
    //           //                   decoration: InputDecoration(
    //           //                     labelText: 'Experience',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index]
    //           //                           .teamMemberExperience = value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue: _teamMembersList[index]
    //           //                       .teamMemberAchievements,
    //           //                   decoration: InputDecoration(
    //           //                     labelText: 'Achievements',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index]
    //           //                           .teamMemberAchievements = value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue: _teamMembersList[index]
    //           //                       .teamMemberLinkedIn_Profiles,
    //           //                   decoration: InputDecoration(
    //           //                     labelText: 'LinkedIn Profiles',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index]
    //           //                           .teamMemberLinkedIn_Profiles =
    //           //                           value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue: _teamMembersList[index]
    //           //                       .teamMemberResponsibilities,
    //           //                   decoration: InputDecoration(
    //           //                     labelText: 'Responsibilities',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index]
    //           //                           .teamMemberResponsibilities = value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 08,),
    //           //                 TextFormField(
    //           //                   initialValue:
    //           //                   _teamMembersList[index].teamCulture,
    //           //                   decoration: InputDecoration(
    //           //                     labelText: 'Team Culture',
    //           //                     border: OutlineInputBorder(),
    //           //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    //           //                   ),
    //           //                   onChanged: (value) {
    //           //                     setState(() {
    //           //                       _teamMembersList[index].teamCulture =
    //           //                           value;
    //           //                     });
    //           //                   },
    //           //                 ),
    //           //                 SizedBox(height: 20,),
    //           //               ],
    //           //             ),
    //           //           ],
    //           //         ),
    //           //       );
    //           //     }
    //           //   },
    //           // ),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),

    //====================================================================================//
    //----------------------Funding Requirments------------------------------------------//
    //====================================================================================//

    Step(
        state:
        _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text('Funding Requirments'),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _fundAmount,
                decoration: InputDecoration(
                  labelText: 'Fund Amount',
                  suffixIcon: Tooltip(
                    message: 'Fund Amount',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Fund Amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _fundPurpose,
                decoration: InputDecoration(
                  labelText: 'Fund Purpose',
                  suffixIcon: Tooltip(
                    message: 'Fund Purpose',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Fund Purpose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _timeline,
                decoration: InputDecoration(
                  labelText: 'Timeline',
                  suffixIcon: Tooltip(
                    message: 'Timeline',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Timeline';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _fundingSources,
                decoration: InputDecoration(
                  labelText: 'Funding Sources',
                  suffixIcon: Tooltip(
                    message: 'Funding Sources',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Funding Sources';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _investmentTerms,
                decoration: InputDecoration(
                  labelText: 'Investment Terms',
                  suffixIcon: Tooltip(
                    message: 'Investment Terms',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Investment Terms';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _investorBenefits,
                decoration: InputDecoration(
                  labelText: ' Investor Benefits',
                  suffixIcon: Tooltip(
                    message: 'Investor Benefits',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Investor Benefits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _riskFactors,
                decoration: InputDecoration(
                  labelText: 'Risk Factors',
                  suffixIcon: Tooltip(
                    message: 'Risk Factors',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                maxLines: 3,
                // Set the maximum number of lines for the input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Risk Factors';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )),


    //====================================================================================//
    //----------------------Investor Criteria------------------------------------------//
    //====================================================================================//
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 4,
        title: const Text('Investor Criteria'),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _minimumInvestmentAmount,
                decoration: InputDecoration(
                  labelText: 'Minimum Investment Amount',
                  suffixIcon: Tooltip(
                    message: 'Minimum Investment Amount',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Minimum Investment Amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _maximumInvestmentAmount,
                decoration: InputDecoration(
                  labelText: 'Maximum Investment Amount',
                  suffixIcon: Tooltip(
                    message: 'Maximum Investment Amount',
                    child: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Maximum Investment Amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _geographicLocation,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Geographic Location',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedInvestmentExperience,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Investment Stage',
                ),
                items: _selectedInvestmentStage.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedInvestmentExperience = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              FutureBuilder<List<String>>(
                future: _industryController.getIndustryNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  final industryNames = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Select your industries of interest'),
                        const SizedBox(height: 8),
                        MultiSelectDialogField<String>(
                          title: const Text('Industries'),
                          items: industryNames
                              .map((industry) => MultiSelectItem(industry, industry))
                              .toList(),
                          initialValue: _industryFocus,
                          buttonText : const Text('Select Industries'),
                          onConfirm: (value) {
                            setState(() {
                              _industryFocus = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                value: _selectedstatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Status',
                ),
                items: _status.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedstatus = newValue;
                  });
                },
              ),
            ],
          ),
        )),



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Business Idea'),
        backgroundColor: AppColors.mainBlueColor,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              // Mark the current step as completed
              _stepCompleted[_activeStepIndex] = true;
              // Move to the next step
              _activeStepIndex += 1;
            });
          } else {
            print('Submitted');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          if (_stepCompleted[index]) {
            setState(() {
              _activeStepIndex = index;
            });
          }
        },
        controlsBuilder:
            (BuildContext context, ControlsDetails controlsDetails) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          final isCompleted = _stepCompleted[_activeStepIndex];
          return Row(
            children: [
              if (_activeStepIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: controlsDetails.onStepCancel,
                    child: const Text('Back'),
                  ),
                ),
              const SizedBox(width: 8.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : isLastStep
                      ? () async {
                    setState(() {
                      isSubmitting = true;
                    });
                    _addValue();
                    setState(() {
                      isSubmitting = false;
                    });
                  }
                      : controlsDetails.onStepContinue,
                  child: isSubmitting
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                      : isLastStep
                      ? const Text('Submit')
                      : const Text('Next'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
