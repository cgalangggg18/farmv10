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

  int? languageId;
  String? preferredLanguage;

  bool get areDriverDocumentsUploaded =>
      isCompany 
          ? (driverLicenseUploaded && areVehicleDocumentsUploaded)
          : driverLicenseUploaded;

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
      'role_details': {
        'id': 2,
        'name': 'Logistics',
      },
      'language_details': {
        'id': languageId,
        'language': preferredLanguage,
      },
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
          'license': {
            'id': 1,
            'name': 'Driver License',
            'url': driverLicensePath,
          },
          'gov_id': {
            'id': 2,
            'name': 'Government ID',
            'url': governmentIDPath,
          },
          'nbi': {
            'id': 3,
            'name': 'NBI Clearance',
            'url': nbiClearancePath,
          },
          'photo': {
            'id': 4,
            'name': 'Driver Photo',
            'url': driverPhotoPath,
          },
          'utility': {
            'id': 5,
            'name': 'Driver Utility Bill',
            'url': driverUtilityBillPath,
          },
        },
        'vehicle': {
          'or': {
            'id': 6,
            'name': 'Vehicle OR',
            'url': vehicleORPath,
          },
          'cr': {
            'id': 7,
            'name': 'Vehicle CR',
            'url': vehicleCRPath,
          },
          'photo': {
            'id': 8,
            'name': 'Vehicle Photo',
            'url': vehiclePhotoPath,
          },
        },
        'company': {
          'permit': {
            'id': 9,
            'name': 'Business Permit',
            'url': businessPermitPath,
          },
          'bir': {
            'id': 10,
            'name': 'BIR Certificate',
            'url': birCertificatePath,
          },
          'dti_sec': {
            'id': 11,
            'name': 'DTI/SEC Certificate',
            'url': dtiSecCertificatePath,
          },
          'utility': {
            'id': 12,
            'name': 'Company Utility Bill',
            'url': companyUtilityBillPath,
          },
        }
      }
    };
  }
}
