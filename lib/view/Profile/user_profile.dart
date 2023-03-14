import 'dart:convert';
import 'dart:typed_data';

import 'package:construction_flutter_application/view/Profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/User/user_model.dart';
import '../../utils/global.dart';
import '../Side Menu/side_menu.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool showPassword = false;

  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";
  late var _imageBase64 = "";
  late Uint8List decodedImageData = Uint8List.fromList([]);

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userID = pref.getInt('userID');
      userRole = pref.getString('userRole');
      personID = pref.getInt('personID');
      loginName = pref.getString('loginName')!;
      password = pref.getString('password')!;
      email = pref.getString('email')!;
      personName = pref.getString('personName')!;
    });

    var response = await http.get(
      Uri.parse(getUser_url + "name=" + loginName + "&password=" + password),
    );
    if (response.statusCode == 200 && response.contentLength != 0) {
      var data = jsonDecode(response.body.toString());

      var user = User.fromJson(jsonDecode(response.body));

      setUser(user.userId, user.userRole, user.personId, user.loginName,
          password, user.email, user.personName);

      fullNameController.text = user.personName;
      emailController.text = user.email;
    }
    http.Response imageResponse = await http.get(
        Uri.parse(getUserImageByUserID_url + "userID=" + userID.toString()));
    setState(() {
      _imageBase64 = base64Encode(imageResponse.bodyBytes);
      decodedImageData = base64Decode(_imageBase64);
    });

    // print(decodedImageData);
  }

  Future<void> setUser(userID, userRole, personID, loginName, password, email,
      personName) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('userID', userID);
    pref.setString('userRole', userRole);
    pref.setInt('personID', personID);
    pref.setString('loginName', loginName);
    pref.setString('password', password);
    pref.setString('email', email);
    pref.setString('personName', personName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: bgColor,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                loginName,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _imageBase64 == null
              //     ? Container()
              //     : Image.memory(decodedImageData),
              // Image.asset(
              //   "images/profile_pic.png",
              //   height: 200,
              //   width: 200,
              // ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget buildTextField(
      String lblText, String placeHolder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35),
      child: TextField(
        readOnly: true,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: lblText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
