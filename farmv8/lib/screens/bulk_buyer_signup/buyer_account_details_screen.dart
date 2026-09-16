import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../providers/bulk_buyer_registration_provider.dart';
import 'buyer_personal_details_screen.dart';

class BuyerAccountDetailsScreen extends StatefulWidget {
  const BuyerAccountDetailsScreen({super.key});

  @override
  State<BuyerAccountDetailsScreen> createState() => _BuyerAccountDetailsScreenState();
}

class _BuyerAccountDetailsScreenState extends State<BuyerAccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final Color _primaryColor = const Color(0xFF2196F3);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          '${l10n.translate('step_x_of_y').replaceAll('{current}', '1').replaceAll('{total}', '4')} . ${l10n.translate('account_details')}',
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
                        color: index == 0 ? _primaryColor : const Color(0xFFE0E0E0),
                        thickness: 4,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Text(l10n.translate('create_account'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(l10n.translate('enter_details_sub'), style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _buildTextField(
                label: l10n.translate('email_address'),
                hint: 'example@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.translate('email_required');
                  if (!value.contains('@')) return l10n.translate('invalid_email');
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('password_caps'),
                hint: l10n.translate('enter_password_hint'),
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return l10n.translate('password_required');
                  if (value.length < 8) return l10n.translate('password_min_length');
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('confirm_password'),
                hint: l10n.translate('reenter_password'),
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                validator: (value) {
                  if (value != _passwordController.text) return l10n.translate('passwords_not_match');
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.updatePersonalDetails(email: _emailController.text);
                    provider.updateAccountDetails(password: _passwordController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyerPersonalDetailsScreen()),
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
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
