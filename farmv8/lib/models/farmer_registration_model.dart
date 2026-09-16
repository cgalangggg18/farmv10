class FarmerRegistrationModel {
  String phoneNumber = '';
  String email = '';
  String username = '';
  String password = '';

  String firstName = '';
  String middleName = '';
  String lastName = '';
  String userCountry = '';
  String userRegion = '';
  String userRegionCode = '';
  String userProvince = '';
  String userProvinceCode = '';
  String userMunicipality = '';
  String userMunicipalityCode = '';
  String userBarangay = '';
  String userBarangayCode = '';
  String userStreetAddress = '';
  String userHouseNumber = '';
  String userPostalCode = '';

  String farmSize = '';
  String farmCountry = '';
  String farmRegion = '';
  String farmRegionCode = '';
  String farmProvince = '';
  String farmProvinceCode = '';
  String farmMunicipality = '';
  String farmMunicipalityCode = '';
  String farmBarangay = '';
  String farmBarangayCode = '';
  String farmStreetAddress = '';
  String farmHouseNumber = '';
  String farmPostalCode = '';

  // File paths
  String? utilityBillPath;
  String? validIDPath;
  String? ownersAddressDocPath;
  String? ownershipDocsPath;

  bool isVerified = false; // Added to track verification status

  bool get utilityBillUploaded => utilityBillPath != null;
  bool get validIDUploaded => validIDPath != null;
  bool get ownersAddressDocUploaded => ownersAddressDocPath != null;
  bool get ownershipDocsUploaded => ownershipDocsPath != null;

  bool get isComplete {
    return phoneNumber.isNotEmpty &&
        email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        userBarangay.isNotEmpty &&
        userMunicipality.isNotEmpty &&
        farmSize.isNotEmpty &&
        farmBarangay.isNotEmpty &&
        farmMunicipality.isNotEmpty &&
        utilityBillUploaded &&
        validIDUploaded &&
        ownersAddressDocUploaded &&
        ownershipDocsUploaded;
  }


  String get fullName => '$firstName $middleName $lastName'.trim().replaceAll('  ', ' ');

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'email': email,
      'username': username,
      'password': password,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'address': {
        'country': userCountry,
        'region': userRegion,
        'region_code': userRegionCode,
        'province': userProvince,
        'province_code': userProvinceCode,
        'municipality': userMunicipality,
        'municipality_code': userMunicipalityCode,
        'barangay': userBarangay,
        'barangay_code': userBarangayCode,
        'street': userStreetAddress,
        'house_number': userHouseNumber,
        'postal_code': userPostalCode,
      },
      'farm': {
        'size': farmSize,
        'country': farmCountry,
        'region': farmRegion,
        'region_code': farmRegionCode,
        'province': farmProvince,
        'province_code': farmProvinceCode,
        'municipality': farmMunicipality,
        'municipality_code': farmMunicipalityCode,
        'barangay': farmBarangay,
        'barangay_code': farmBarangayCode,
        'street': farmStreetAddress,
        'house_number': farmHouseNumber,
        'postal_code': farmPostalCode,
      },
      'documents': {
        'utility_bill': utilityBillPath,
        'valid_id': validIDPath,
        'owners_address': ownersAddressDocPath,
        'ownership_docs': ownershipDocsPath,
      }
    };
  }
}
