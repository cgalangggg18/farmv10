/// Data model representing a Farmer registration profile.
/// 
/// Contains methods to validate the profile and convert it to a 
/// Django-compatible JSON format.
class FarmerRegistrationModel {
  // --- Account Info ---
  String phoneNumber = '';
  String email = '';
  String username = '';
  String password = '';

  // --- Personal Info ---
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

  // --- Farm Info ---
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

  // --- Document File Paths ---
  String? utilityBillPath;
  String? validIDPath;
  String? ownersAddressDocPath;
  String? ownershipDocsPath;

  // --- Preferences & Status ---
  int? languageId;
  String? preferredLanguage;
  bool isVerified = false;

  // --- Helper Getters ---
  bool get utilityBillUploaded => utilityBillPath != null;
  bool get validIDUploaded => validIDPath != null;
  bool get ownersAddressDocUploaded => ownersAddressDocPath != null;
  bool get ownershipDocsUploaded => ownershipDocsPath != null;

  String get fullName => '$firstName $middleName $lastName'.trim().replaceAll('  ', ' ');

  /// Checks if the essential fields for registration are filled.
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

  /// Converts the model to a JSON Map aligned with the Django backend database structure.
  Map<String, dynamic> toJson() {
    return {
      // Basic Info (Required by Backend)
      'phonenumber': phoneNumber,
      'username': username,
      'password': password,
      'firstname': firstName,
      'lastname': lastName,
      'middle_name': middleName,
      'preferred_language': preferredLanguage ?? 'English',
      'role': 'Farmer',

      // Residence Address
      'region': userRegion,
      'province': userProvince,
      'municipality': userMunicipality,
      'baranggay': userBarangay, // Backend spelling: double 'g'
      'house_number': userHouseNumber,
      'street': userStreetAddress,
      'postal_code': userPostalCode,

      // Farm Info
      'farm_size': farmSize,
      'farm_region': farmRegion,
      'farm_province': farmProvince,
      'farm_municipality': farmMunicipality,
      'farm_barangay': farmBarangay,
      'farm_house_number': farmHouseNumber,
      'farm_street': farmStreetAddress,
      'farm_postal_code': farmPostalCode,

      // Documents (Backend expects a list of file URLs)
      'documents': [
        utilityBillPath ?? '',
        validIDPath ?? '',
        ownersAddressDocPath ?? '',
        ownershipDocsPath ?? '',
      ],
      'document_types': [
        'Utility Bills',
        'Valid_ID',
        'Owner_Address',
        'Farm_Ownership',
      ],

      // Custom Metadata for Frontend reference
      'role_details': {
        'id': 1,
        'name': 'Farmer',
      },
    };
  }
}
