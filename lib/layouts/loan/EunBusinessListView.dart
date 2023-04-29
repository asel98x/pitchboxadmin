import 'package:flutter/material.dart';
import 'package:pitchboxadmin/appIcons.dart';
import 'package:pitchboxadmin/appcolors.dart';
import 'package:pitchboxadmin/appstyles.dart';
import 'package:pitchboxadmin/backend/controller/businessController.dart';
import 'package:pitchboxadmin/backend/controller/loanController.dart';
import 'package:pitchboxadmin/backend/model/business.dart';
import 'package:pitchboxadmin/backend/model/loan.dart';
import 'package:url_launcher/url_launcher.dart';


class EunBusinessListView extends StatefulWidget {
  final String businessId;
  const EunBusinessListView({Key? key, required this.businessId}) : super(key: key);

  @override
  _EunBusinessListViewState createState() => _EunBusinessListViewState();
}

class _EunBusinessListViewState extends State<EunBusinessListView> {
  final _formKey = GlobalKey<FormState>();
  String? paymentStatus;
  List<Business> _businessList = [];
  LoanController _loanController = LoanController();
  final BusinessController _Bcontroller = BusinessController();
  late Business business;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _investAmountController = TextEditingController();

  var _loanAmountController = TextEditingController();
  final _loanDescriptionController = TextEditingController();
  int _number = 0;

  String _userId = '';
  String _name = '';
  String _mobile = '';
  String _city = '';
  String _country = '';
  List<String> _professionalExperience = [];
  List<String> _entrepreneurshipExperience = [];
  List<String> _education = [];
  List<String> _industryCertifications = [];
  List<String> _awardsAchievements = [];
  List<String> _trackRecord = [];
  String _email = '';
  String _linkedin = '';
  String _twitter = '';
  String _facebook = '';
  String _instagram = '';
  String _Userwebsite = '';

  String _businessId = '';
  String _businessName = '';
  String _businessLocation = '';
  String _executiveSummary = '';
  String _companyDescription = '';
  String _businessModel = '';
  String _valueProposition = '';
  String _productOrServiceOffering = '';
  String _fundingNeeds = '';

  String _minimumInvestmentAmount = '';
  String _maximumInvestmentAmount = '';
  String _fundAmount = '';
  String _fundPurpose = '';
  String _timeline = '';
  String _fundingSources = '';
  String _investmentTerms = '';
  String _investorBenefits = '';
  String _riskFactors = '';

  String _status = 'pending';

  Future<void> getData(String businessId) async {
    business = await _Bcontroller.getBusiness(businessId);
    print(business.fundAmount);
  }

  @override
  void initState() {
    super.initState();
    _loanAmountController = TextEditingController(text: _number.toString());
    paymentStatus = "Not Paid";


  }

  void _increment() {
    setState(() {
      _number++;
      _loanAmountController.text = _number.toString();
    });
  }

  void _decrement() {
    setState(() {
      if (_number > 0) {
        _number--;
        _loanAmountController.text = _number.toString();
      }
    });
  }

  void _addLoanValues() async {
    try {
      await _loanController.addLoan(
          businessId:_businessId,
          businessName:_businessName,
          loanAmount: _loanAmountController.text,
          loanDescription: _loanDescriptionController.text,
          loanId: '',
          status: _status,
          userId: _userId
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your loan is successfully submited. Please wait until get approval from the administrator!'),
          )
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get a Loan'),
        ),
      );
      print(e.toString());
    }
  }


  Future<void> _showEunDetailsDialog(BuildContext context, Loan loan) async {
    GlobalKey _imageKey = GlobalKey();
    await getData(loan.businessId);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = business.name;
        String mobile = business.mobile;
        String city = business.city;
        String country = business.country;
        List<String> professionalExperience = business.professionalExperience;
        List<String> entrepreneurshipExperience = business.entrepreneurshipExperience;
        List<String> education = business.education;
        List<String> industryCertifications = business.industryCertifications;
        List<String> awardsAchievements = business.awardsAchievements;
        List<String> trackRecord = business.trackRecord;
        String email = business.email;
        String facebook = business.facebook;
        String twitter = business.twitter;
        String instagram = business.instagram;
        String linkedin = business.linkedin;
        String Userwebsite = business.Userwebsite;
        String userImageDownloadUrl =business.UserImgUrl;
        return AlertDialog(
          title: Text('Entrepreneur Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            (userImageDownloadUrl),
                          ))),
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: ralewayStyle.copyWith(
                    fontSize: 16.0,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile : ' + mobile,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'City : ' + city,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Country  : ' + country,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email  : ' + email,
                        textAlign: TextAlign.justify,
                        style: ralewayStyle.copyWith(
                          fontSize: 16.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Professional Experience',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: professionalExperience
                            .map(
                              (experience) => Column(
                                children: [
                                  Text(
                                    '• ' + experience,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Entrepreneurship Experience',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: entrepreneurshipExperience
                            .map(
                              (entrepreneurshipExperience) => Column(
                                children: [
                                  Text(
                                    '• ' + entrepreneurshipExperience,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'education',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: education
                            .map(
                              (education) => Column(
                                children: [
                                  Text(
                                    '• ' + education,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Industry Certifications',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: industryCertifications
                            .map(
                              (industryCertifications) => Column(
                                children: [
                                  Text(
                                    '• ' + industryCertifications,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Awards Achievements',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: awardsAchievements
                            .map(
                              (awardsAchievements) => Column(
                                children: [
                                  Text(
                                    '• ' + awardsAchievements,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Track Record',
                        textAlign: TextAlign.start,
                        style: ralewayStyle.copyWith(
                          fontSize: 18.0,
                          color: AppColors.blueDarkColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Divider(thickness: 2),
                      SizedBox(height: 8),
                      Column(
                        children: trackRecord
                            .map(
                              (trackRecord) => Column(
                                children: [
                                  Text(
                                    '• ' + trackRecord,
                                    textAlign: TextAlign.justify,
                                    style: ralewayStyle.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBlueColor,
        title: Text('Business Information'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(
                'INVEST IN ' + _businessName,
                style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              Text(
                _businessLocation,
                style: ralewayStyle.copyWith(
                  fontSize: 16.0,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            _executiveSummary,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              // Image.network(
              //   (widget.business.businessImgUrl),
              //   height: 175,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        //_showEunDetailsDialog(context,loan);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: NetworkImage(widget.business.UserImgUrl),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          launch(_facebook);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.facebookIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_twitter);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.twitterIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_linkedin);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.linkedinIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_instagram);
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          child: Image.asset(AppIcons.instagramIcon),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(_Userwebsite);
                        },
                        child: Icon(Icons.language),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'text',
                      textAlign: TextAlign.right,
                      style: ralewayStyle.copyWith(
                        fontSize: 16.0,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            _companyDescription,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Business Model',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 6),
          Text(
            _businessModel,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Value Proposition',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _valueProposition,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Product or Service',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _productOrServiceOffering,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Funding Needs',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _fundingNeeds,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Timeline',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _timeline,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Funding Sources',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _fundingSources,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Investment Benefits',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _investorBenefits,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Investment Terms',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _investmentTerms,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Risk Factors',
            textAlign: TextAlign.start,
            style: ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 8),
          Text(
            _riskFactors,
            textAlign: TextAlign.justify,
            style: ralewayStyle.copyWith(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          SizedBox(width: 16.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                //_showGetLoanDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.mainBlueColor,
                              ),
                              child: Text(
                                'Get a Loan',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
