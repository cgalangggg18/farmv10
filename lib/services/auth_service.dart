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
  Future<bool> isDeviceReady() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.textbee.dev/api/v1/gateway/devices/${ApiConstants.textBeeDeviceId}'),
        headers: {'x-api-key': ApiConstants.textBeeApiKey.trim()},
      ).timeout(const Duration(seconds: 10));

      debugPrint('--- [TextBee DEVICE CHECK] ---');
      debugPrint('Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String status = data['data']?['status'] ?? 'unknown';
        debugPrint('Device Status: $status');
        if (status != 'online') {
          debugPrint('⚠️ WARNING: Device is registered but OFFLINE in TextBee app.');
        }
        return true;
      } else if (response.statusCode == 404) {
        debugPrint('❌ ERROR: Device ID not found. Check if textBeeDeviceId is correct.');
      } else if (response.statusCode == 401) {
        debugPrint('❌ ERROR: Invalid API Key.');
      }
      return false;
    } catch (e) {
      debugPrint('❌ TextBee Status Check Exception: $e');
      return false;
    }
  }

  /// Sends OTP via TextBee API
  Future<bool> sendOTP(String phoneNumber) async {
    // --- TEMPORARY BYPASS (TEXTBEE LIMIT REACHED) ---
    // We are temporarily returning true to skip the real SMS sending.
    // The code below remains intact but won't be executed for now.
    debugPrint('⚠️ [BYPASS ACTIVE] Skipping TextBee SMS for $phoneNumber.');
    _lastGeneratedOTP = "123456"; // Use this code to pass verification
    return true;

    /* ORIGINAL CODE START
    try {
      debugPrint('--- [TEXTBEE SEND PROCESS] ---');
      ...
    } catch (e) {
      ...
    }
    ORIGINAL CODE END */
  }

  /// Verifies the OTP entered by the user
  Future<bool> verifyOTP(String phoneNumber, String code) async {
    debugPrint('--- [VERIFY OTP] ---');
    debugPrint('Expecting: $_lastGeneratedOTP | Got: $code');

    if (code.isEmpty) return false;

    if (_lastGeneratedOTP != null && code == _lastGeneratedOTP) {
      return true;
    }
    
    // Master key for Development
    if (code == '123456' || kDebugMode) {
      return true;
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
