import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTherapist extends StatefulWidget {
  const AddTherapist({super.key});

  @override
  State<AddTherapist> createState() => _AddTherapistState();
}

class _AddTherapistState extends State<AddTherapist> {
  bool isActive = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Center Member',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
            ),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 65, 184, 119),
            ),
            child: Center(
              child: Text(
                "Save",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Add%20Therapist-0Urh6ZvhocAtiyw83JP6MNAPpHw6Lx.png'),
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

                // Basic Profile Section
                const Text(
                  'Basic Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Your Name',
                  hint: 'Enter your name',
                ),
                _buildTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                ),
                _buildTextField(
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  required: true,
                ),
                _buildDropdown(
                  label: 'User Role',
                  value: 'Therapist',
                  required: true,
                ),
                _buildDropdown(
                  label: 'center name',
                  value: 'jk vihar',
                  required: true,
                ),
                _buildDropdown(
                  label: 'Gender',
                  value: 'Male',
                ),

                // Active Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: isActive,
                      onChanged: (value) => setState(() => isActive = value),
                      activeColor: const Color(0xFF4CD080),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // KYC Documents Section
                const Text(
                  'KYC Documents',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Uploaded Document
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.picture_as_pdf,
                          color: Colors.red, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Fund.pdf',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '53.9 kb',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View',
                          style: TextStyle(
                            color: Color(0xFF4CD080),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Upload Button
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Color(0xFF4CD080)),
                      SizedBox(width: 8),
                      Text(
                        'Upload',
                        style: TextStyle(
                          color: Color(0xFF4CD080),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
    String? initialValue,
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
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
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

  Widget _buildDropdown({
    required String label,
    required String value,
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
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
              ),
              items: [value].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
              validator: required
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
