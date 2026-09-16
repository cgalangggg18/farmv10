import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../providers/bulk_buyer_registration_provider.dart';
import '../../services/registration_service.dart';
import '../../services/auth_service.dart';
import '../../services/api_constants.dart';
import '../farmer_signup/mailbox_verification_screen.dart';

class ReviewSubmitScreen extends StatefulWidget {
  const ReviewSubmitScreen({super.key});

  @override
  State<ReviewSubmitScreen> createState() => _ReviewSubmitScreenState();
}

class _ReviewSubmitScreenState extends State<ReviewSubmitScreen> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit(BulkBuyerRegistrationProvider provider) async {
    final model = provider.model;
    if (!model.areDocumentsUploaded || !model.isPersonalDetailsValid || !model.isBusinessDetailsValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields and upload all documents.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final authService = AuthService();
    final otpSent = await authService.sendOTP(model.mobileNumber ?? '');

    if (!otpSent && mounted) {
      setState(() => _isSubmitting = false);
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.translate('sms_failed')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success = await RegistrationService.submitRegistration(
      role: 'Bulk Buyer',
      data: model.toJson(),
    );
    setState(() => _isSubmitting = false);

    if (success) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MailboxVerificationScreen(
              phoneNumber: model.mobileNumber ?? '',
            ),
          ),
        );
      }
    } else {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        // In development mode with placeholder URL, we still proceed
        if (ApiConstants.baseUrl.contains('example.com')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MailboxVerificationScreen(
                phoneNumber: model.mobileNumber ?? '',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.translate('registration_failed'))),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<BulkBuyerRegistrationProvider>(context);
    final model = provider.model;
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${l10n.translate('step_x_of_y').replaceAll('{current}', '5').replaceAll('{total}', '5')} . ${l10n.translate('review_submit')}',
          style: const TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 4 ? 0 : 4),
                        child: Divider(
                          color: primaryColor,
                          thickness: 4,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                Text(l10n.translate('review_submit'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(l10n.translate('review_submit_sub'), style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 24),
                
                // ROLE Section
                _buildSectionHeader(l10n.translate('role')),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Text(l10n.translate('step_bulk_buyers'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // PERSONAL INFO Section
                _buildSectionHeader(l10n.translate('personal_info')),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _buildReviewRow(l10n.translate('name'), '${model.firstName} ${model.lastName}'),
                      _buildReviewRow(l10n.translate('mobile_number'), model.mobileNumber ?? ''),
                      _buildReviewRow(l10n.translate('email'), model.email ?? ''),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // BUSINESS Section
                _buildSectionHeader(l10n.translate('business_details')),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _buildReviewRow(l10n.translate('business_name'), model.businessName ?? ''),
                      _buildReviewRow(l10n.translate('business_address'), '${model.streetAddress ?? ''}, ${model.barangay?.name ?? ''}, ${model.municipality?.name ?? ''}, ${model.province?.name ?? ''}, ${model.region?.name ?? ''}'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // DOCUMENTS Section
                _buildSectionHeader(l10n.translate('documents')),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _buildDocumentRow(l10n.translate('biz_permit'), model.businessPermitPath != null, l10n),
                      _buildDocumentRow(l10n.translate('bir_cert'), model.birCertificatePath != null, l10n),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _handleSubmit(provider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(l10n.translate('submit_application'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.translate('cancel'), style: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(String label, bool isUploaded, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54))),
          Text(
            isUploaded ? l10n.translate('uploaded') : l10n.translate('not_uploaded'),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isUploaded ? const Color(0xFF4CAF50) : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
