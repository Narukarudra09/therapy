import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/widgets/custom_add_button.dart';

import '../../models/therapist.dart';
import '../../providers/super_center_provider.dart';

class AddTherapist extends StatelessWidget {
  const AddTherapist({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SuperCenterProvider>(context);

    void saveTherapist() {
      if (provider.formKey.currentState?.validate() ?? false) {
        final newTherapist = Therapist(
          name: provider.nameController.text,
          email: provider.emailController.text,
          phoneNumber: provider.phoneController.text,
          role: provider.selectedRole ?? '',
          centerName: provider.selectedCenter ?? '',
          gender: provider.selectedGender ?? '',
          isActive: provider.isActive,
          kycDocuments:
              provider.selectedFiles.map((file) => file.name).toList(),
        );
        provider.addTherapist(newTherapist);
        Navigator.pop(context);
      }
    }

    Future<void> pickFiles() async {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx']);
      if (result != null) {
        provider.selectedFiles = result.files;
        provider.notifyListeners();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Center Member',
          style: GoogleFonts.inter(
            color: const Color.fromARGB(255, 23, 28, 34),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: saveTherapist,
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      "Save",
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/profile.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: const Icon(Icons.camera_alt, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Basic Profile',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 23, 28, 34),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Your Name',
                  hint: 'Enter your name',
                  controller: provider.nameController,
                  required: true,
                ),
                _buildTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                  controller: provider.emailController,
                ),
                _buildTextField(
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  controller: provider.phoneController,
                  required: true,
                ),
                Row(
                  children: [
                    Text(
                      "User Role",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    Text(
                      "*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 43, 43),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: provider.selectedRole,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                  decoration: InputDecoration(
                    hintText: "Select Role",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 46, 44, 52),
                    ),
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
                  items: ['Center Owner', 'Therapist']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 46, 44, 52),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    provider.selectedRole = newValue;
                    provider.notifyListeners();
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Center Name",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 135, 141, 186),
                      ),
                    ),
                    Text(
                      "*",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 255, 43, 43),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: provider.selectedCenter,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                  decoration: InputDecoration(
                    hintText: "Select Center",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 46, 44, 52),
                    ),
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
                  items: ['jk vihar', 'tilak nagar']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 46, 44, 52),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    provider.selectedCenter = newValue;
                    provider.notifyListeners();
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Gender",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 135, 141, 186),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: provider.selectedGender,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(8),
                  iconEnabledColor: const Color.fromARGB(255, 23, 28, 34),
                  iconDisabledColor: const Color.fromARGB(255, 23, 28, 34),
                  dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                  decoration: InputDecoration(
                    hintText: "Select Gender",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 46, 44, 52),
                    ),
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
                  items: ['Female', 'Male', 'Others']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 46, 44, 52),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    provider.selectedGender = newValue;
                    provider.notifyListeners();
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Active',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "*",
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 255, 43, 43),
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: provider.isActive,
                      onChanged: (value) {
                        provider.isActive = value;
                        provider.notifyListeners();
                      },
                      activeColor: const Color.fromARGB(255, 65, 184, 119),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'KYC Documents',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 23, 28, 34),
                  ),
                ),
                const SizedBox(height: 16),
                ...provider.selectedFiles.map((file) => Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.picture_as_pdf,
                              color: Colors.red, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  file.name,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.87),
                                  ),
                                ),
                                Text(
                                  '${(file.size / 1024).toStringAsFixed(2)} kb',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 82, 103, 137),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'View',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 65, 184, 119),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CustomAddButton(
                      title: "Upload Documents",
                      onTap: pickFiles,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 135, 141, 186),
                ),
              ),
              if (required)
                Text(
                  '*',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 255, 43, 43),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 46, 44, 52),
            ),
            decoration: InputDecoration(
              hintText: hint,
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
            validator: required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
