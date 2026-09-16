import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'firebase_sql_service.dart';

class RegistrationService {
  // Real registration integration with multipart support for files
  static Future<bool> submitRegistration({required String role, required Map<String, dynamic> data}) async {
    try {
      // Transitioned to Firebase Data Connect (Cloud Persistence)
      String? userId;
      
      if (role == 'Farmer') {
        userId = await FirebaseSqlService.instance.createUser(
          username: data['username'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone_number'] ?? '',
          role: 'farmer',
          passwordHash: data['password'] ?? '',
        );
        if (userId != null) await FirebaseSqlService.instance.saveFarmerRegistration(userId, data);
      } else if (role == 'Logistics') {
        userId = await FirebaseSqlService.instance.createUser(
          username: data['account']?['username'] ?? '',
          email: data['account']?['email'] ?? '',
          phone: data['account']?['phone'] ?? '',
          role: 'logistics',
          passwordHash: data['account']?['password'] ?? '',
        );
        if (userId != null) await FirebaseSqlService.instance.saveLogisticsRegistration(userId, data);
      } else if (role == 'Bulk Buyer') {
        userId = await FirebaseSqlService.instance.createUser(
          username: data['email'] ?? '',
          email: data['email'] ?? '',
          phone: data['mobile_number'] ?? '',
          role: 'bulk_buyer',
          passwordHash: data['password'] ?? '',
        );
        if (userId != null) await FirebaseSqlService.instance.saveBulkBuyerRegistration(userId, data);
      }
      
      debugPrint('Cloud Registration Result: UserID = $userId');
      
      // For development/demo: return true if the URL is just a placeholder
      if (ApiConstants.baseUrl.contains('example.com')) {
        debugPrint('Bypassing registration for $role (Development Mode)');
        // Simulate network delay for better UX during development
        await Future.delayed(const Duration(seconds: 2));
        return true;
      }

      final String endpoint = role == 'Farmer' 
          ? ApiConstants.registerFarmerEndpoint 
          : role == 'Logistics'
              ? ApiConstants.registerLogisticsEndpoint
              : ApiConstants.registerBulkBuyerEndpoint;

      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final request = http.MultipartRequest('POST', uri);

      // Recursive function to populate the multipart request
      Future<void> addDataToRequest(Map<String, dynamic> map, [String prefix = '']) async {
        for (var entry in map.entries) {
          final key = entry.key;
          final value = entry.value;
          final fieldName = prefix.isEmpty ? key : '$prefix[$key]';

          if (value is Map<String, dynamic>) {
            await addDataToRequest(value, fieldName);
          } else if (value != null) {
            bool isFileField = false;
            // List of keys that are expected to be file paths
            const fileKeys = {
              'utility_bill', 'or_cr', 'valid_id', 'owners_address', 'ownership_docs',
              'farmer_photo', 'farm_photo', 'barangay_clearance', 'gcash',
              'license', 'or', 'cr', 'gov_id', 'nbi', 'photo', 'utility',
              'permit', 'bir', 'dti_sec', 'bir_certificate', 'business_permit',
              'bir_cert', 'biz_permit'
            };

            if (fileKeys.contains(key) && value is String && value.isNotEmpty) {
              final file = File(value);
              if (await file.exists()) {
                request.files.add(await http.MultipartFile.fromPath(fieldName, value));
                isFileField = true;
                debugPrint('Adding file to request: $fieldName -> $value');
              }
            }

            if (!isFileField) {
              request.fields[fieldName] = value.toString();
            }
          }
        }
      }

      await addDataToRequest(data);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Registration failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Registration exception: $e');
      if (ApiConstants.baseUrl.contains('example.com')) return true;
      return false;
    }
  }
  
  // Real mailbox code verification integration
  static Future<bool> verifyMailboxCode(String code) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.verifyMailboxEndpoint}'),
        body: jsonEncode({'code': code}),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return true;
      } else {
        // For development/demo: return true if the URL is just a placeholder
        if (ApiConstants.baseUrl.contains('example.com')) {
          debugPrint('Bypassing mailbox verification failure for placeholder URL');
          return true;
        }
        return false;
      }
    } catch (e) {
      debugPrint('Mailbox verification error: $e');
      // For development/demo: return true if the URL is just a placeholder
      if (ApiConstants.baseUrl.contains('example.com')) {
        debugPrint('Bypassing mailbox verification exception for placeholder URL');
        return true;
      }
      return false;
    }
  }
}
