import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../models/address/philippine_address_models.dart';
import '../../providers/bulk_buyer_registration_provider.dart';
import '../../services/address_service.dart';
import 'buyer_documents_screen.dart';

class BuyerBusinessDetailsScreen extends StatefulWidget {
  const BuyerBusinessDetailsScreen({super.key});

  @override
  State<BuyerBusinessDetailsScreen> createState() => _BuyerBusinessDetailsScreenState();
}

class _BuyerBusinessDetailsScreenState extends State<BuyerBusinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final AddressService _addressService = AddressService();
  final Color _primaryColor = const Color(0xFF2196F3);

  Region? _selectedRegion;
  Province? _selectedProvince;
  Municipality? _selectedMunicipality;
  Barangay? _selectedBarangay;

  List<Region> _regions = [];
  List<Province> _provinces = [];
  List<Municipality> _municipalities = [];
  List<Barangay> _barangays = [];

  bool _isLoadingRegions = true;

  @override
  void initState() {
    super.initState();
    _loadRegions();
  }

  Future<void> _loadRegions() async {
    final regions = await _addressService.getRegions();
    setState(() {
      _regions = regions;
      _isLoadingRegions = false;
      // Auto-select Region III if available
      try {
        _selectedRegion = _regions.firstWhere((r) => r.name.contains('Region III'));
        if (_selectedRegion != null) _loadProvinces(_selectedRegion!.code);
      } catch (_) {}
    });
  }

  Future<void> _loadProvinces(String regionCode) async {
    final provinces = await _addressService.getProvinces(regionCode);
    setState(() {
      _provinces = provinces;
      _selectedProvince = null;
      _selectedMunicipality = null;
      _selectedBarangay = null;
      _postalCodeController.clear();
      
      // Auto-select Pampanga
      try {
        _selectedProvince = _provinces.firstWhere((p) => p.name.contains('Pampanga'));
        if (_selectedProvince != null) _loadMunicipalities(_selectedProvince!.code);
      } catch (_) {}
    });
  }

  Future<void> _loadMunicipalities(String provinceCode) async {
    final municipalities = await _addressService.getMunicipalities(provinceCode);
    setState(() {
      _municipalities = municipalities;
      _selectedMunicipality = null;
      _selectedBarangay = null;
      _postalCodeController.clear();
      
      // Auto-select San Fernando
      try {
        _selectedMunicipality = _municipalities.firstWhere((m) => m.name.contains('San Fernando'));
        if (_selectedMunicipality != null) {
          _postalCodeController.text = _addressService.getPostalCode(_selectedMunicipality!.name);
          _loadBarangays(_selectedMunicipality!.code);
        }
      } catch (_) {}
    });
  }

  Future<void> _loadBarangays(String municipalityCode) async {
    final barangays = await _addressService.getBarangays(municipalityCode);
    setState(() {
      _barangays = barangays;
      _selectedBarangay = null;
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
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
          '${l10n.translate('step_x_of_y').replaceAll('{current}', '3').replaceAll('{total}', '4')} . ${l10n.translate('business_details')}',
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
                        color: index <= 2 ? _primaryColor : const Color(0xFFE0E0E0),
                        thickness: 4,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Text(l10n.translate('business_info'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(l10n.translate('enter_business_sub'), style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              _buildTextField(
                label: l10n.translate('business_name'),
                hint: 'Dela Cruz Enterprises',
                controller: _businessNameController,
                validator: (value) => value == null || value.isEmpty ? l10n.translate('required_field') : null,
              ),
              const SizedBox(height: 20),
              _buildDropdown<Region>(
                label: l10n.translate('region'),
                value: _selectedRegion,
                items: _regions,
                itemLabel: (r) => r.name,
                onChanged: (val) {
                  setState(() => _selectedRegion = val);
                  if (val != null) _loadProvinces(val.code);
                },
                isLoading: _isLoadingRegions,
              ),
              const SizedBox(height: 16),
              _buildDropdown<Province>(
                label: l10n.translate('province'),
                value: _selectedProvince,
                items: _provinces,
                itemLabel: (p) => p.name,
                onChanged: (val) {
                  setState(() => _selectedProvince = val);
                  if (val != null) _loadMunicipalities(val.code);
                },
                disabled: _selectedRegion == null,
              ),
              const SizedBox(height: 16),
              _buildDropdown<Municipality>(
                label: l10n.translate('municipality'),
                value: _selectedMunicipality,
                items: _municipalities,
                itemLabel: (m) => m.name,
                onChanged: (val) {
                  setState(() {
                    _selectedMunicipality = val;
                    if (val != null) {
                      _postalCodeController.text = _addressService.getPostalCode(val.name);
                      _loadBarangays(val.code);
                    } else {
                      _postalCodeController.clear();
                    }
                  });
                },
                disabled: _selectedProvince == null,
              ),
              const SizedBox(height: 16),
              _buildDropdown<Barangay>(
                label: l10n.translate('barangay'),
                value: _selectedBarangay,
                items: _barangays,
                itemLabel: (b) => b.name,
                onChanged: (val) {
                  setState(() {
                    _selectedBarangay = val;
                  });
                },
                disabled: _selectedMunicipality == null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('house_number_detailed'),
                hint: 'Unit 123, Building Name, Street',
                controller: _streetController,
                validator: (value) => value == null || value.isEmpty ? l10n.translate('required_field') : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: l10n.translate('postal_code'),
                hint: '2000',
                controller: _postalCodeController,
                readOnly: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedBarangay != null) {
                    provider.updateBusinessDetails(
                      businessName: _businessNameController.text,
                      region: _selectedRegion,
                      province: _selectedProvince,
                      municipality: _selectedMunicipality,
                      barangay: _selectedBarangay,
                      streetAddress: _streetController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuyerDocumentsScreen()),
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
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            filled: readOnly,
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required void Function(T?) onChanged,
    bool disabled = false,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12)),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item), style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: disabled ? null : onChanged,
          decoration: InputDecoration(
            hintText: isLoading ? 'Loading...' : 'Select ${label.toLowerCase()}',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: disabled,
            fillColor: disabled ? Colors.grey.shade100 : Colors.white,
          ),
          validator: (val) => val == null ? 'Please select a ${label.toLowerCase()}' : null,
        ),
      ],
    );
  }
}
