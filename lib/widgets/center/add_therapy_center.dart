import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state_controllers/super_center_controller.dart';
import 'add_working_hours.dart';

class AddTherapyCenter extends StatelessWidget {
  final bool isEditing;
  final SuperCenterController controller = Get.find();

  AddTherapyCenter({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Profile Details',
            style: GoogleFonts.inter(
              color: Color(0xFF171C22),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (isEditing) {
                // Save the data
                controller.updateData({
                  'isActive': controller.isActive.value,
                  'isLoginAllowed': controller.isLoginAllowed.value,
                  'email': controller.emailController.text,
                  'phone': controller.phoneController.text,
                  'about': controller.aboutController.text,
                  'location': controller.locationController.text,
                  'fee': controller.feeController.text,
                  'holidays': controller.holidays.value,
                  'openingTimes': controller.openingTimes.value,
                  'closingTimes': controller.closingTimes.value,
                });
                Get.back();
              } else {
                Get.to(() => WorkingHoursScreen());
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      isEditing ? "Save" : "Next",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Add%20Therapist-h3E5qVWdSlTI6hv9oR0JB0CaF49MO0.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Owner Details',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF171C22),
                ),
              ),
              SizedBox(height: 16),
              _buildFormField(
                label: 'Center Email Address',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildFormField(
                label: 'Center Phone Number',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              _buildFormField(
                label: 'About',
                maxLines: 3,
                controller: controller.aboutController,
                keyboardType: TextInputType.text,
              ),
              _buildDropdownField(
                label: 'Location',
                value: controller.locationController.text,
                onChanged: (value) {
                  controller.locationController.text = value!;
                },
              ),
              _buildFormField(
                label: 'Fees/Therapy',
                controller: controller.feeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              _buildToggleRow(
                'Active',
                controller.isActive.value,
                (value) => controller.isActive.value = value,
                isRequired: true,
              ),
              _buildToggleRow(
                'Login Allowed',
                controller.isLoginAllowed.value,
                (value) => controller.isLoginAllowed.value = value,
                isRequired: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    int maxLines = 1,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Color(0xFF878DBA),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 46, 44, 52),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Color(0xFF878DBA),
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isNotEmpty ? value : null,
          icon: Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(8),
          iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
          iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
          dropdownColor: const Color.fromARGB(255, 255, 255, 255),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 232, 233, 241),
              ),
            ),
            hintText: 'Select',
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(255, 102, 114, 128),
            ),
          ),
          items: ['Bhilwara', 'Jaipur']
              .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2c2e34),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildToggleRow(
    String label,
    bool value,
    Function(bool) onChanged, {
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF41B877),
            inactiveThumbColor: Colors.white,
            thumbColor: WidgetStatePropertyAll(Colors.white),
            activeTrackColor: Color(0xFF41B877),
          ),
        ],
      ),
    );
  }
}
