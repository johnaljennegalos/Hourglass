import 'package:flutter/material.dart';
import 'package:hourglass/services/instructor_service.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

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
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null
                    ? const Icon(Icons.person, size: 40, color: Color(0xFF2563EB))
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 3,
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: Add image picker logic here
                    },
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
