class LogisticsRegistrationModel {
  bool isCompany = true;
  bool isVerified = false; // Added to track verification status

  // Step 0: Account Details
  String accountPhoneNumber = '';
  String accountEmail = '';
  String username = '';
  String password = '';

  // Step 1: Driver's Details
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String dob = '';
  String gender = '';
  String country = '';
  String region = '';
  String regionCode = '';
  String province = '';
  String provinceCode = '';
  String municipality = '';
  String municipalityCode = '';
  String barangay = '';
  String barangayCode = '';
  String streetAddress = '';
  String houseNumber = '';
  String postalCode = '';

  // Step 2: Vehicle Details
  String vehicleType = '';
  String vehicleModel = '';
  String vehicleBrand = '';
  String yearModel = '';
  String plateNumber = '';
  String vin = '';
  String maxLoadCapacity = '';

  // Step 3: Company Details
  String companyName = '';
  String businessRegNumber = '';
  String companyAddress = '';
  String email = '';
  String contactNumber = '';

  // Step 4: Driver Documents (File Paths)
  String? driverLicensePath;
  String? governmentIDPath;
  String? nbiClearancePath;
  String? driverPhotoPath;
  String? driverUtilityBillPath;

  bool get driverLicenseUploaded => driverLicensePath != null;
  bool get governmentIDUploaded => governmentIDPath != null;
  bool get nbiClearanceUploaded => nbiClearancePath != null;
  bool get driverPhotoUploaded => driverPhotoPath != null;
  bool get driverUtilityBillUploaded => driverUtilityBillPath != null;

  // Step 5: Vehicle Documents (File Paths)
  String? vehicleORPath;
  String? vehicleCRPath;
  String? vehiclePhotoPath;

  bool get vehicleORUploaded => vehicleORPath != null;
  bool get vehicleCRUploaded => vehicleCRPath != null;
  bool get vehiclePhotoUploaded => vehiclePhotoPath != null;

  // Step 6: Company Documents (File Paths)
  String? businessPermitPath;
  String? birCertificatePath;
  String? dtiSecCertificatePath;
  String? companyUtilityBillPath;

  bool get businessPermitUploaded => businessPermitPath != null;
  bool get birCertificateUploaded => birCertificatePath != null;
  bool get dtiSecCertificateUploaded => dtiSecCertificatePath != null;
  bool get companyUtilityBillUploaded => companyUtilityBillPath != null;

  bool get areDriverDocumentsUploaded =>
      isCompany 
          ? driverLicenseUploaded
          : (driverLicenseUploaded &&
             areVehicleDocumentsUploaded &&
             arePersonalDocumentsUploaded);

  bool get arePersonalDocumentsUploaded =>
      governmentIDUploaded &&
      nbiClearanceUploaded &&
      driverPhotoUploaded &&
      driverUtilityBillUploaded;

  bool get areVehicleDocumentsUploaded =>
      vehicleORUploaded && vehicleCRUploaded && vehiclePhotoUploaded;

  bool get areCompanyDocumentsUploaded =>
      businessPermitUploaded &&
      birCertificateUploaded &&
      dtiSecCertificateUploaded &&
      companyUtilityBillUploaded;

  String get fullName => '$firstName $middleName $lastName'.trim().replaceAll('  ', ' ');

  Map<String, dynamic> toJson() {
    return {
      'account': {
        'phone': accountPhoneNumber,
        'email': accountEmail,
        'username': username,
        'password': password,
      },
      'driver': {
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'dob': dob,
        'gender': gender,
        'address': {
          'country': country,
          'region': region,
          'region_code': regionCode,
          'province': province,
          'province_code': provinceCode,
          'municipality': municipality,
          'municipality_code': municipalityCode,
          'barangay': barangay,
          'barangay_code': barangayCode,
          'street': streetAddress,
          'house_number': houseNumber,
          'postal_code': postalCode,
        },
      },
      'vehicle': {
        'type': vehicleType,
        'model': vehicleModel,
        'brand': vehicleBrand,
        'year': yearModel,
        'plate_number': plateNumber,
        'vin': vin,
        'capacity': maxLoadCapacity,
      },
      'company': {
        'name': companyName,
        'reg_number': businessRegNumber,
        'address': companyAddress,
        'email': email,
        'contact': contactNumber,
      },
      'documents': {
        'driver': {
          'license': driverLicensePath,
          'gov_id': governmentIDPath,
          'nbi': nbiClearancePath,
          'photo': driverPhotoPath,
          'utility': driverUtilityBillPath,
        },
        'vehicle': {
          'or': vehicleORPath,
          'cr': vehicleCRPath,
          'photo': vehiclePhotoPath,
        },
        'company': {
          'permit': businessPermitPath,
          'bir': birCertificatePath,
          'dti_sec': dtiSecCertificatePath,
          'utility': companyUtilityBillPath,
        }
      }
    };
  }
}
