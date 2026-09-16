import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../providers/bulk_buyer_registration_provider.dart';
import 'buyer_business_details_screen.dart';

class BuyerPersonalDetailsScreen extends StatefulWidget {
  const BuyerPersonalDetailsScreen({super.key});

  @override
  State<BuyerPersonalDetailsScreen> createState() => _BuyerPersonalDetailsScreenState();
}

class _BuyerPersonalDetailsScreenState extends State<BuyerPersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final Color _primaryColor = const Color(0xFF2196F3);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<BulkBuyerRegistrationProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${l10n.translate('step_x_of_y').replaceAll('{current}', '2').replaceAll('{total}', '4')} . ${l10n.translate('personal_details')}',
          style: TextStyle(color: _primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 3 ? 0 : 4),
                      child: Divider(
                        color: index <= 1 ? _primaryColor : const Color(0xFFE0E0E0),
                        thickness: 4,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Text(l10n.translate('personal_info'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(l10n.translate('enter_personal_sub'), style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _buildTextField(
                label: l10n.translate('first_name'),
                hint: 'Juan',
                controller: _firstNameController,
                validator: (value) => value == null || value.isEmpty ? l10n.translate('required_field') : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('last_name'),
                hint: 'Dela Cruz',
                controller: _lastNameController,
                validator: (value) => value == null || value.isEmpty ? l10n.translate('required_field') : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('mobile_number'),
                hint: '09123456789',
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                prefixText: '+63 ',
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.translate('required_field');
                  if (value.length != 11) return l10n.translate('invalid_mobile');
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.updatePersonalDetails(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      mobileNumber: _mobileController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyerBusinessDetailsScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l10n.translate('continue'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? prefixText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
