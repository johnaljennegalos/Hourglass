import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hourglass/services/instructor_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
   super.initState();
   _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final data = await InstructorService.getProfile();

      if (!mounted) return;

      setState(() {
        _profileData = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      setState(() => _isUploading = true);

      final File imageFile = File(pickedFile.path);
      final bool success = await InstructorService.updatInstructoreAvatar(imageFile);

      if (!mounted) return;

      if (success) {
        await _fetchProfile();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile picture.')),
        );
      }
    } catch (e) {
      print('Error picking/uploading image: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }


  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final String firstName = _profileData?['first_name'] ?? 'First';
    final String lastName = _profileData?['last_name'] ?? 'Last';
    final String fullName = '$firstName $lastName'.trim();
    final String displayName = fullName.isNotEmpty ? fullName : 'Instructor';


    final String rawRole = _profileData?['role'] ?? '';
    final String roleTitle = rawRole == 'IN' ? 'Instructor' : 'Student';

    final String department = _profileData?['department'] ?? 'Department Not Specified';
    final String? avatarUrl = _profileData?['avatar'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.blue,
        borderRadius: BorderRadiusGeometry.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFDBEAFE),
                backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                    ? NetworkImage(avatarUrl)
                    : null,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : (avatarUrl == null || avatarUrl.isEmpty)
                    ? const Icon(Icons.person, size: 45, color: Color(0xFF2563EB))
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _isUploading ? null : _pickAndUploadImage,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8,),
          Text(displayName, style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          const SizedBox(height: 2),
          Text('$roleTitle • $department', style: TextStyle(
            fontSize: 14,
            color: Color(0xFFDBEAFE),
          ),),
        ],
      ),
    );
  }
}
