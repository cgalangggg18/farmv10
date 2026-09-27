import 'package:flutter/material.dart';
import '../models/address/philippine_address_models.dart';

class BulkBuyerRegistrationModel {
  // Account Details
  String? email;
  String? password;

  // Personal Details
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobileNumber;
  Region? personalRegion;
  Province? personalProvince;
  Municipality? personalMunicipality;
  Barangay? personalBarangay;
  String? personalStreetAddress;

  // Business Details
  String? businessName;
  Region? businessRegion;
  Province? businessProvince;
  Municipality? businessMunicipality;
  Barangay? businessBarangay;
  String? businessStreetAddress;

  // Documents
  String? utilityBillPath;
  String? businessPermitPath;
  String? birCertificatePath;
  String? nationalIdPath;

  int? languageId;
  String? preferredLanguage;

  bool isVerified = false;

  bool get areAccountDetailsValid =>
      email != null && email!.contains('@') && password != null && password!.length >= 8;

  bool get arePersonalDetailsValid =>
      firstName != null && firstName!.isNotEmpty &&
      lastName != null && lastName!.isNotEmpty &&
      mobileNumber != null && mobileNumber!.length == 11 &&
      personalProvince != null && personalMunicipality != null &&
      personalBarangay != null;

  bool get areBusinessDetailsValid =>
      businessName != null && businessName!.isNotEmpty &&
      businessProvince != null && businessMunicipality != null &&
      businessBarangay != null;

  bool get areDocumentsUploaded =>
      utilityBillPath != null && businessPermitPath != null && 
      birCertificatePath != null && nationalIdPath != null;

  Map<String, dynamic> toJson() {
    return {
      'role_details': {
        'id': 3,
        'name': 'Bulk Buyer',
      },
      'language_details': {
        'id': languageId,
        'language': preferredLanguage,
      },
      'email': email,
      'password': password,
      'personal_details': {
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'mobile_number': mobileNumber,
        'address': {
          'region': personalRegion?.name,
          'province': personalProvince?.name,
          'municipality': personalMunicipality?.name,
          'barangay': personalBarangay?.name,
          'street': personalStreetAddress,
        }
      },
      'business_details': {
        'name': businessName,
        'address': {
          'region': businessRegion?.name,
          'province': businessProvince?.name,
          'municipality': businessMunicipality?.name,
          'barangay': businessBarangay?.name,
          'street': businessStreetAddress,
        }
      },
      'documents': {
        'utility_bill': {
          'id': 1,
          'name': 'Utility Bill',
          'url': utilityBillPath,
        },
        'business_permit': {
          'id': 2,
          'name': 'Business Permit',
          'url': businessPermitPath,
        },
        'bir_certificate': {
          'id': 3,
          'name': 'BIR Certificate',
          'url': birCertificatePath,
        },
        'national_id': {
          'id': 4,
          'name': 'National ID',
          'url': nationalIdPath,
        },
      }
    };
  }
}

class BulkBuyerRegistrationProvider with ChangeNotifier {
  final BulkBuyerRegistrationModel _model = BulkBuyerRegistrationModel();

  BulkBuyerRegistrationModel get model => _model;

  void updateAccountDetails({String? email, String? password}) {
    if (email != null) _model.email = email;
    if (password != null) _model.password = password;
    notifyListeners();
  }

  void updatePersonalDetails({
    String? firstName,
    String? middleName,
    String? lastName,
    String? mobileNumber,
    Region? region,
    Province? province,
    Municipality? municipality,
    Barangay? barangay,
    String? streetAddress,
  }) {
    if (firstName != null) _model.firstName = firstName;
    if (middleName != null) _model.middleName = middleName;
    if (lastName != null) _model.lastName = lastName;
    if (mobileNumber != null) _model.mobileNumber = mobileNumber;
    if (region != null) _model.personalRegion = region;
    if (province != null) _model.personalProvince = province;
    if (municipality != null) _model.personalMunicipality = municipality;
    if (barangay != null) _model.personalBarangay = barangay;
    if (streetAddress != null) _model.personalStreetAddress = streetAddress;
    notifyListeners();
  }

  void updateBusinessDetails({
    String? businessName,
    Region? region,
    Province? province,
    Municipality? municipality,
    Barangay? barangay,
    String? streetAddress,
  }) {
    if (businessName != null) _model.businessName = businessName;
    if (region != null) _model.businessRegion = region;
    if (province != null) _model.businessProvince = province;
    if (municipality != null) _model.businessMunicipality = municipality;
    if (barangay != null) _model.businessBarangay = barangay;
    if (streetAddress != null) _model.businessStreetAddress = streetAddress;
    notifyListeners();
  }

  void updateDocuments({
    String? utilityBill,
    String? businessPermit,
    String? birCertificate,
    String? nationalId,
  }) {
    if (utilityBill != null) _model.utilityBillPath = utilityBill;
    if (businessPermit != null) _model.businessPermitPath = businessPermit;
    if (birCertificate != null) _model.birCertificatePath = birCertificate;
    if (nationalId != null) _model.nationalIdPath = nationalId;
    notifyListeners();
  }

  void setVerificationStatus(bool status) {
    _model.isVerified = status;
    notifyListeners();
  }

  void updateLanguagePreference({int? id, String? name}) {
    if (id != null) _model.languageId = id;
    if (name != null) _model.preferredLanguage = name;
    notifyListeners();
  }
}
