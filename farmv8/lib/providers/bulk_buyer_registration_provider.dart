import 'package:flutter/material.dart';
import '../models/address/philippine_address_models.dart';

class BulkBuyerRegistrationModel {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? password;
  String? businessName;
  Region? region;
  Province? province;
  Municipality? municipality;
  Barangay? barangay;
  String? streetAddress;
  String? birCertificatePath;
  String? businessPermitPath;
  bool isVerified = false;

  bool get isPersonalDetailsValid =>
      firstName != null &&
      firstName!.isNotEmpty &&
      lastName != null &&
      lastName!.isNotEmpty &&
      mobileNumber != null &&
      mobileNumber!.length == 11 &&
      email != null &&
      email!.contains('@');

  bool get isAccountDetailsValid =>
      password != null && password!.length >= 8;

  bool get isBusinessDetailsValid =>
      businessName != null &&
      businessName!.isNotEmpty &&
      region != null &&
      province != null &&
      municipality != null &&
      barangay != null;

  bool get areDocumentsUploaded =>
      birCertificatePath != null && businessPermitPath != null;

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'password': password,
      'business': {
        'name': businessName,
        'region': region?.name,
        'region_code': region?.code,
        'province': province?.name,
        'province_code': province?.code,
        'municipality': municipality?.name,
        'municipality_code': municipality?.code,
        'barangay': barangay?.name,
        'barangay_code': barangay?.code,
        'street': streetAddress,
      },
      'documents': {
        'bir_certificate': birCertificatePath,
        'business_permit': businessPermitPath,
      }
    };
  }
}

class BulkBuyerRegistrationProvider with ChangeNotifier {
  final BulkBuyerRegistrationModel _model = BulkBuyerRegistrationModel();

  BulkBuyerRegistrationModel get model => _model;

  void updatePersonalDetails({
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? email,
  }) {
    if (firstName != null) _model.firstName = firstName;
    if (lastName != null) _model.lastName = lastName;
    if (mobileNumber != null) _model.mobileNumber = mobileNumber;
    if (email != null) _model.email = email;
    notifyListeners();
  }

  void updateAccountDetails({String? password}) {
    if (password != null) _model.password = password;
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
    if (region != null) _model.region = region;
    if (province != null) _model.province = province;
    if (municipality != null) _model.municipality = municipality;
    if (barangay != null) _model.barangay = barangay;
    if (streetAddress != null) _model.streetAddress = streetAddress;
    notifyListeners();
  }

  void updateDocuments({
    String? birCertificate,
    String? businessPermit,
  }) {
    if (birCertificate != null) _model.birCertificatePath = birCertificate;
    if (businessPermit != null) _model.businessPermitPath = businessPermit;
    notifyListeners();
  }

  void setVerificationStatus(bool status) {
    _model.isVerified = status;
    notifyListeners();
  }
}
