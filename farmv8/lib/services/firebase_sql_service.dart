import 'package:flutter/foundation.dart';
import '../dataconnect_generated/generated.dart';

class FirebaseSqlService {
  FirebaseSqlService._();
  static final FirebaseSqlService instance = FirebaseSqlService._();

  final _connector = ExampleConnector.instance;

  Future<String?> createUser({
    required String username,
    required String email,
    required String phone,
    required String role,
    required String passwordHash,
  }) async {
    try {
      final result = await _connector.createUser(
        username: username,
        email: email,
        phone: phone,
        role: role,
        passwordHash: passwordHash,
      ).execute();
      
      return result.data.user_insert.id;
    } catch (e) {
      debugPrint('❌ Error creating user in cloud: $e');
      return null;
    }
  }

  Future<void> saveFarmerRegistration(String userId, Map<String, dynamic> data) async {
    try {
      await _connector.registerFarmer(
        userId: userId,
        firstName: data['first_name'] ?? '',
        lastName: data['last_name'] ?? '',
      ).farmSize(data['farm']?['size'] != null ? double.tryParse(data['farm']['size'].toString()) : null)
       .utilityBillPath(data['documents']?['utility_bill'])
       .validIdPath(data['documents']?['valid_id'])
       .ownersAddressDocPath(data['documents']?['owners_address'])
       .ownershipDocsPath(data['documents']?['ownership_docs'])
       .execute();
      debugPrint('✅ Farmer profile saved to cloud');
    } catch (e) {
      debugPrint('❌ Error saving Farmer profile: $e');
    }
  }

  Future<void> saveLogisticsRegistration(String userId, Map<String, dynamic> data) async {
    try {
      await _connector.registerLogistics(
        userId: userId,
        isCompany: data['is_company'] ?? false,
      ).firstName(data['first_name'])
       .lastName(data['last_name'])
       .vehicleType(data['vehicle']?['type'])
       .plateNumber(data['vehicle']?['plate_number'])
       .execute();
      debugPrint('✅ Logistics profile saved to cloud');
    } catch (e) {
      debugPrint('❌ Error saving Logistics profile: $e');
    }
  }

  Future<void> saveBulkBuyerRegistration(String userId, Map<String, dynamic> data) async {
    try {
      await _connector.registerBulkBuyer(
        userId: userId,
        firstName: data['first_name'] ?? '',
        lastName: data['last_name'] ?? '',
      ).businessName(data['business']?['name'])
       .execute();
      debugPrint('✅ Bulk Buyer profile saved to cloud');
    } catch (e) {
      debugPrint('❌ Error saving Bulk Buyer profile: $e');
    }
  }
}

