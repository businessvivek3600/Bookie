import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_global_tools/screens/BottomNav/dash_setting_page.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/utils/text.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _alternateMobileController =
      TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _addressTypeController = TextEditingController();

  String? _selectedState;
  final List<String> _states = [
    'Select State',
    'State 1',
    'State 2',
    'State 3'
  ];

  final List<String> _selectedChips = [];

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform actions like saving the form data to a database
      logD('Full Name: ${_fullNameController.text}');
      logD('Phone Number: ${_phoneNumberController.text}');
      logD('Alternate Mobile: ${_alternateMobileController.text}');
      logD('Pincode: ${_pincodeController.text}');
      logD('House No.: ${_houseNoController.text}');
      logD('Building Name: ${_buildingNameController.text}');
      logD('Landmark: ${_landmarkController.text}');
      logD('Selected State: $_selectedState');
      logD('Selected Chips: $_selectedChips');
    }
  }

  String? _customValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleLargeText('Add Address', context),
          actions: const [ToggleBrightnessButton()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NoDoubleDecimalFormatter()
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _alternateMobileController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NoDoubleDecimalFormatter()
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Alternate Mobile',
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pincodeController,
                    inputFormatters: [NoDoubleDecimalFormatter()],
                    decoration: const InputDecoration(
                      labelText: 'Pincode *',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedState,
                    items: _states.map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: bodyMedText(state, context),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedState = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'State *',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) {
                      if (value == null || value == 'Select State') {
                        return 'Please select a state';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _houseNoController,
                    decoration: const InputDecoration(
                      labelText: 'House No. *',
                      prefixIcon: Icon(Icons.home),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _buildingNameController,
                    decoration: const InputDecoration(
                      labelText: 'Building Name *',
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _landmarkController,
                    decoration: const InputDecoration(
                      labelText: 'Landmark *',
                      prefixIcon: Icon(Icons.map),
                    ),
                    validator: _customValidator,
                  ),
                  height20(),
                  const SizedBox(height: 16),
                  bodyMedText('Type of Address', context),
                  height5(),
                  Wrap(
                    spacing: 8,
                    children: [
                      ActionChip(
                        label: bodyMedText('Home', context),
                        onPressed: () {
                          setState(() {
                            _selectedChips.contains('Home')
                                ? _selectedChips.remove('Home')
                                : _selectedChips.add('Home');
                          });
                        },
                        backgroundColor: _selectedChips.contains('Home')
                            ? getTheme.colorScheme.primary.withOpacity(0.1)
                            : null,
                      ),
                      ActionChip(
                        label: bodyMedText('Work', context),
                        onPressed: () {
                          setState(() {
                            _selectedChips.contains('Work')
                                ? _selectedChips.remove('Work')
                                : _selectedChips.add('Work');
                          });
                        },
                        backgroundColor: _selectedChips.contains('Work')
                            ? getTheme.colorScheme.primary.withOpacity(0.1)
                            : null,
                      ),
                      // Add more chips here...
                    ],
                  ),
                  TextFormField(
                    controller: _addressTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Address Type *',
                      prefixIcon: Icon(Icons.label),
                    ),
                    validator: _customValidator,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Save Address'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
