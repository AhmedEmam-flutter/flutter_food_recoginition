// lib/features/profile/screens/edit_profile_screen.dart
// ignore_for_file: unused_local_variable, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/function/animated_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedGoal = 'Lose Weight';
  bool _isVegetarian = false;

  // Map for allergies
  final Map<String, bool> _allergies = {
    'Lactose': false,
    'Gluten': true,
    'Nuts': false,
    'Seafood': false,
    'Eggs': true,
    'Soy': false,
  };

  @override
  void initState() {
    super.initState();
    // Set initial values
    _nameController.text = 'Ahmed Mohamed';
    _emailController.text = 'ahmed@example.com';
    _phoneController.text = '+201234567890';
    _ageController.text = '28';
    _weightController.text = '75';
    _heightController.text = '175';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FadeInAnimation(
          offsetX: -20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: FadeInAnimation(
          offsetX: -10,
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          ScaleAnimation(
            child: TextButton(
              onPressed: _saveProfile,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color(0xFF42E87F),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture Section
              AnimatedListItem(
                index: 0,
                child: _buildProfilePictureSection(),
              ),
              const SizedBox(height: 32),

              // Personal Information Section
              AnimatedListItem(
                index: 1,
                child: _buildPersonalInfoSection(),
              ),
              const SizedBox(height: 32),

              // Health Information Section
              AnimatedListItem(
                index: 2,
                child: _buildHealthInfoSection(),
              ),
              const SizedBox(height: 32),

              // Dietary Preferences Section
              AnimatedListItem(
                index: 3,
                child: _buildDietaryPreferencesSection(),
              ),
              const SizedBox(height: 40),

              // Save Button
              ScaleAnimation(
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                child: _buildSaveButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return ScaleAnimation(
      child: Column(
        children: [
          Stack(
            children: [
              ScaleAnimation(
                duration: const Duration(milliseconds: 700),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF42E87F),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF42E87F).withOpacity(0.1),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xFF42E87F),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: BounceAnimation(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF42E87F),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt,
                          size: 20, color: Colors.white),
                      onPressed: _changeProfilePicture,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FadeInAnimation(
            child: TextButton(
              onPressed: _changeProfilePicture,
              child: const Text(
                'Change Photo',
                style: TextStyle(
                  color: Color(0xFF42E87F),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInAnimation(
            child: const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Name Field
          AnimatedListItem(
            index: 0,
            child: _buildFormField(
              label: 'Full Name',
              hintText: 'Enter your full name',
              controller: _nameController,
              icon: Icons.person_outline,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),

          // Email Field
          AnimatedListItem(
            index: 1,
            child: _buildFormField(
              label: 'Email Address',
              hintText: 'Enter your email',
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),

          // Phone Field
          AnimatedListItem(
            index: 2,
            child: _buildFormField(
              label: 'Phone Number',
              hintText: 'Enter your phone number',
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),

          // Gender Selection
          AnimatedListItem(
            index: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderOption(
                        title: 'Male',
                        isSelected: _selectedGender == 'Male',
                        index: 0,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGenderOption(
                        title: 'Female',
                        isSelected: _selectedGender == 'Female',
                        index: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGenderOption(
                        title: 'Other',
                        isSelected: _selectedGender == 'Other',
                        index: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInAnimation(
            child: const Text(
              'Health Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),

          AnimatedListItem(
            index: 0,
            child: Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    label: 'Age',
                    hintText: 'Enter age',
                    controller: _ageController,
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.number,
                    suffixText: 'years',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    label: 'Weight',
                    hintText: 'Enter weight',
                    controller: _weightController,
                    icon: Icons.monitor_weight_outlined,
                    keyboardType: TextInputType.number,
                    suffixText: 'kg',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFormField(
                    label: 'Height',
                    hintText: 'Enter height',
                    controller: _heightController,
                    icon: Icons.straighten_outlined,
                    keyboardType: TextInputType.number,
                    suffixText: 'cm',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Fitness Goal Selection
          AnimatedListItem(
            index: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fitness Goal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildGoalChip(
                      title: 'Lose Weight',
                      isSelected: _selectedGoal == 'Lose Weight',
                      index: 0,
                    ),
                    _buildGoalChip(
                      title: 'Build Muscle',
                      isSelected: _selectedGoal == 'Build Muscle',
                      index: 1,
                    ),
                    _buildGoalChip(
                      title: 'Stay Healthy',
                      isSelected: _selectedGoal == 'Stay Healthy',
                      index: 2,
                    ),
                    _buildGoalChip(
                      title: 'Improve Diet',
                      isSelected: _selectedGoal == 'Improve Diet',
                      index: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietaryPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInAnimation(
            child: const Text(
              'Dietary Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Vegetarian Option
          AnimatedListItem(
            index: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vegetarian Diet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Follow a plant-based diet',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                ScaleAnimation(
                  child: Switch(
                    value: _isVegetarian,
                    onChanged: (value) => setState(() => _isVegetarian = value),
                    activeColor: const Color(0xFF42E87F),
                    activeTrackColor: const Color(0xFF42E87F).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Food Allergies/Preferences
          AnimatedListItem(
            index: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Food Allergies/Preferences',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _allergies.entries.map((entry) {
                    final index = _allergies.keys.toList().indexOf(entry.key);
                    return _buildAllergyChip(
                      title: entry.key,
                      isSelected: entry.value,
                      index: index,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    required TextInputType keyboardType,
    String? suffixText,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInAnimation(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ScaleAnimation(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF999999)),
              prefixIcon: Icon(icon, color: const Color(0xFF999999)),
              suffixText: suffixText,
              suffixStyle: const TextStyle(color: Color(0xFF666666)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF42E87F), width: 2),
              ),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String title,
    required bool isSelected,
    required int index,
  }) {
    return AnimatedListItem(
      index: index,
      child: InkWell(
        onTap: () => setState(() => _selectedGender = title),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF42E87F).withOpacity(0.1)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF42E87F) : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleAnimation(
                child: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color:
                      isSelected ? const Color(0xFF42E87F) : Colors.grey[400],
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              FadeInAnimation(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF42E87F)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalChip({
    required String title,
    required bool isSelected,
    required int index,
  }) {
    return AnimatedListItem(
      index: index,
      delay: Duration(milliseconds: index * 100),
      child: InkWell(
        onTap: () => setState(() => _selectedGoal = title),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF42E87F).withOpacity(0.1)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF42E87F) : Colors.grey[300]!,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF42E87F).withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: ScaleAnimation(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF42E87F)
                    : const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllergyChip({
    required String title,
    required bool isSelected,
    required int index,
  }) {
    return AnimatedListItem(
      index: index,
      delay: Duration(milliseconds: index * 50),
      child: InkWell(
        onTap: () => setState(() {
          _allergies[title] = !_allergies[title]!;
        }),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFF6B6B).withOpacity(0.1)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFFFF6B6B) : Colors.grey[300]!,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleAnimation(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFFFF6B6B)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.close,
                  size: 16,
                  color: Color(0xFFFF6B6B),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF42E87F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 0,
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => ScaleAnimation(
        child: AlertDialog(
          title: const Text('Change Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedListItem(
                index: 0,
                child: ListTile(
                  leading:
                      const Icon(Icons.camera_alt, color: Color(0xFF42E87F)),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement camera functionality
                  },
                ),
              ),
              AnimatedListItem(
                index: 1,
                child: ListTile(
                  leading:
                      const Icon(Icons.photo_library, color: Color(0xFF42E87F)),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement gallery picker
                  },
                ),
              ),
              AnimatedListItem(
                index: 2,
                child: ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Photo',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    // Implement remove photo
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save profile logic here
      final userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _selectedGender,
        'age': _ageController.text,
        'weight': _weightController.text,
        'height': _heightController.text,
        'goal': _selectedGoal,
        'isVegetarian': _isVegetarian,
        'allergies': _allergies,
      };

      // Show success message with animation
      _showSuccessSnackBar();
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            ScaleAnimation(
              child: const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Profile updated successfully!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF42E87F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate back after a delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);
    });
  }
}
