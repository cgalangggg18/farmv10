/// Centralized file for all API endpoints and third-party service keys.
class ApiConstants {
  // --- Backend Base URL ---
  static const String baseUrl = 'https://fth-backend-f4y4.onrender.com';

  // --- Auth Endpoints ---
  static const String loginEndpoint = '/auth/login';
  static const String sendOtpEndpoint = '/auth/send-otp';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String sendEmailOtpEndpoint = '/auth/send-email-otp';

  // --- Registration Endpoints ---
  // Note: Using /api/ prefix as defined in the Django backend URL patterns.
  static const String registerEndpoint = '/api/register/';
  static const String registerFarmerEndpoint = '/api/register/';
  static const String registerLogisticsEndpoint = '/api/register/';
  static const String registerBulkBuyerEndpoint = '/api/register/';

  // --- Verification Endpoints ---
  static const String verifyMailboxEndpoint = '/api/verify-code/';

  // --- TextBee SMS Configuration ---
  static const String textBeeApiKey = 'txb_oFLHg2I0r0dcGobsKiTneRaTXIKqek6T';
  static const String textBeeDeviceId = '6a7385fff83fbea629b9edd7';
}
