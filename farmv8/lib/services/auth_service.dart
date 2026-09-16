import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static String? _lastGeneratedOTP;

  /// Checks device status to verify API Key and Device ID
  Future<void> checkDeviceStatus() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.textbee.dev/api/v1/gateway/devices/${ApiConstants.textBeeDeviceId}'),
        headers: {'x-api-key': ApiConstants.textBeeApiKey.trim()},
      );
      debugPrint('--- [TextBee DEVICE CHECK] ---');
      debugPrint('Status: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
    } catch (e) {
      debugPrint('❌ TextBee Status Check Exception: $e');
    }
  }

  /// Sends OTP via TextBee API
  Future<bool> sendOTP(String phoneNumber) async {
    try {
      // First, check device status to ensure API key and Device ID work
      await checkDeviceStatus();

      final otp = (100000 + Random().nextInt(900000)).toString();
      _lastGeneratedOTP = otp;

      // Normalize digits for TextBee (prefers local 09... or international +63...)
      String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
      String phFull = digitsOnly;
      if (phFull.startsWith('09')) {
        phFull = '63${phFull.substring(1)}';
      } else if (phFull.length == 10 && phFull.startsWith('9')) {
        phFull = '63$phFull';
      }
      
      String localFormat = '0${phFull.substring(2)}'; // e.g., 0917...
      String internationalFormat = '+$phFull';

      // TextBee usually handles both, but we'll try international first then local
      final List<String> recipients = [internationalFormat];
      
      debugPrint('--- [TextBee SEND ATTEMPT] ---');
      debugPrint('DeviceID: ${ApiConstants.textBeeDeviceId}');
      debugPrint('OTP: $otp');
      debugPrint('Recipient: $internationalFormat');

      if (ApiConstants.textBeeApiKey.contains('YOUR_TEXTBEE_API_KEY')) {
        debugPrint('⚠️ SIMULATION MODE: Use $otp');
        return true; 
      }

      final url = Uri.parse('https://api.textbee.dev/api/v1/gateway/devices/${ApiConstants.textBeeDeviceId}/send-sms');
      
      final response = await http.post(
        url,
        headers: {
          'x-api-key': ApiConstants.textBeeApiKey.trim(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'recipients': recipients,
          'message': 'Your AgriGrow verification code is $otp.',
        }),
      ).timeout(const Duration(seconds: 15));

      debugPrint('Response (${response.statusCode}): ${response.body}');
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        // TextBee returns { "data": { "success": true, ... } }
        if (data['data']?['success'] == true) {
          debugPrint('✅ SMS Sent Successfully via TextBee');
          return true;
        }
      } else if (response.statusCode == 400 && response.body.contains('recipients')) {
        // Try fallback with local format if international fails with 400
        debugPrint('Trying fallback with local format...');
        final fallbackResponse = await http.post(
          url,
          headers: {
            'x-api-key': ApiConstants.textBeeApiKey.trim(),
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'recipients': [localFormat],
            'message': 'Your AgriGrow verification code is $otp.',
          }),
        ).timeout(const Duration(seconds: 15));
        
        if (fallbackResponse.statusCode >= 200 && fallbackResponse.statusCode < 300) {
           return true;
        }
      }

      return false;
    } catch (e) {
      debugPrint('❌ TextBee Exception: $e');
      return false;
    }
  }

  /// Verifies the OTP entered by the user
  Future<bool> verifyOTP(String phoneNumber, String code) async {
    debugPrint('--- [VERIFY OTP] ---');
    debugPrint('Expecting: $_lastGeneratedOTP | Got: $code');

    if (_lastGeneratedOTP != null && code == _lastGeneratedOTP) {
      return true;
    }
    
    // Master key for Development
    if (ApiConstants.baseUrl.contains('example.com')) {
      if (code == '123456' || code.isEmpty) {
        return true;
      }
    }
    return false;
  }

  /// Performs login with identifier (mobile/email) and password
  Future<bool> login(String identifier, String password) async {
    try {
      debugPrint('--- [LOGIN ATTEMPT] ---');
      debugPrint('Identifier: $identifier');

      if (ApiConstants.baseUrl.contains('example.com')) {
        debugPrint('Bypassing login for development (example.com)');
        await Future.delayed(const Duration(seconds: 1));
        return true;
      }

      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identifier': identifier,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        // In a real app, you would parse and save the token here
        return true;
      } else {
        debugPrint('Login failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Login exception: $e');
      // Bypassing for development
      return ApiConstants.baseUrl.contains('example.com');
    }
  }
}
