import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/components/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _dependentsController = TextEditingController();

  String _healthCondition = 'Healthy';
  String _education = 'diploma';
  String _riskTolerance = '';
  File? _imageFile;
  String _imageUrl = '';
  bool isReadOnly = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _usernameController.text = prefs.getString('username') ?? 'johndoe';
      _emailController.text =
          prefs.getString('email') ?? 'john.doe@example.com';
      _ageController.text = prefs.getInt('age')?.toString() ?? '22';
      _incomeController.text = prefs.getInt('annualIncome')?.toString() ?? '0';
      _dependentsController.text =
          prefs.getInt('numberOfDependents')?.toString() ?? '0';
      _healthCondition = prefs.getString('healthCondition') ?? 'Healthy';
      _education = prefs.getString('highestEdu') ?? 'diploma';
      _imageUrl = prefs.getString('profileImage') ??
          'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png';
    });
  }

  Future<void> _saveProfile() async {
    try {
      String apiUrl = 'http://192.168.137.124:3000/users/editProfile';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FormData formData = FormData.fromMap({
        "username": _usernameController.text,
        "email": _emailController.text,
        "age": _ageController.text,
        "annualIncome": _incomeController.text,
        "numberOfDependents": _dependentsController.text,
        "healthCondition": _healthCondition,
        "highestEdu": _education,
        "riskTolerance": _riskTolerance,
        if (_imageFile != null)
          "profileImage": await MultipartFile.fromFile(_imageFile!.path),
      });

      Dio dio = Dio();
      var response = await dio.patch(apiUrl,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer ${prefs.getString('authToken')}'
          }));

      if (response.statusCode == 200) {
        print("Profile updated successfully");
         showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Success!'),
          content: Text('Your Profile has been updated successfully'),
        );
      },
    );
      } else {
        print("Error updating profile: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to update profile: $e");
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.ourBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.arrow_back, size: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.notifications_active,
                    size: 30,
                    color: MyColors.ourPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Profile",
                    style: GoogleFonts.agdasima(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _imageFile != null
                            ? Image.file(_imageFile!,
                                width: 140, height: 140, fit: BoxFit.cover)
                            : Image.network(_imageUrl,
                                width: 140, height: 140, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Change Profile Photo",
                        style: TextStyle(color: Colors.blue)),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isReadOnly = !isReadOnly;
                          if (isReadOnly) {
                            _saveProfile();
                          }
                        });
                      },
                      child: Text(
                        isReadOnly ? "Edit" : "Save",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildEditableField('Username', _usernameController),
                    _buildEditableField('Email', _emailController),
                    _buildEditableField('Age', _ageController),
                    _buildEditableField('Annual Income', _incomeController),
                    _buildEditableField(
                        'Number of Dependents', _dependentsController),
                    SizedBox(height: 16),
                    _buildDropdownField('Health Condition',
                        ['Healthy', 'Other'], _healthCondition, (value) {
                      setState(() {
                        _healthCondition = value!;
                      });
                    }),
                    _buildDropdownField(
                        'Highest Education',
                        [
                          'ssc',
                          'hsc',
                          'diploma',
                          'Undergraduate',
                        'Postgraduate'],
                        _education, (value) {
                      setState(() {
                        _education = value!;
                      });
                    }),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2))
            ],
          ),
          child: TextField(
            readOnly: isReadOnly,
            controller: controller,
            maxLines: maxLines,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String currentValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2))
            ],
          ),
          child: DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            underline: SizedBox(),
            items: items
                .map((item) => DropdownMenuItem(child: Text(item), value: item))
                .toList(),
            onChanged: isReadOnly ? null : onChanged,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
