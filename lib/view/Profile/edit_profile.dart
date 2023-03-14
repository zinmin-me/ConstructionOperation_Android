import 'package:construction_flutter_application/models/User/user_model.dart';
import 'package:construction_flutter_application/view/Profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/global.dart';
import '../Login/login.view.dart';
import '../Side Menu/side_menu.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // bool showPassword = false;
  // late User user;

  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController pswController = TextEditingController();
  // final TextEditingController confirmPswController = TextEditingController();

  final _formfield = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool passToggle = true;
  bool passVisible = false;
  bool changePassTextVisible = true;
  bool changeInfoTextVisible = false;

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

      fullNameController.text = personName;
      emailController.text = email;
      passController.text = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text("Edit Profile"),
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
              key: _formfield,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "images/profile_pic.png",
                  //   height: 200,
                  //   width: 200,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: fullNameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Full Name";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter Email";
                      } else if (!emailValid) {
                        return "Enter Valid Email";
                      }
                    },
                  ),
                  Visibility(visible: passVisible, child: SizedBox(height: 20)),
                  Visibility(
                    visible: passVisible,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (passController.text.length < 6) {
                          return "Password Length Should be more than 6 characters";
                        }
                      },
                    ),
                  ),

                  Visibility(
                      visible: passVisible,
                      child: SizedBox(
                        height: 20,
                      )),
                  Visibility(
                    visible: passVisible,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Confirm Password";
                        } else if (passController.text !=
                            confirmPassController.text) {
                          confirmPassController.clear();
                          return "The Confirm Password confirmation does not match.";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: changePassTextVisible,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                passVisible = true;
                                changePassTextVisible = false;
                                changeInfoTextVisible = true;
                                passController.text = "";
                              });
                            },
                            child: Text("Change Password!")),
                      ),
                      Visibility(
                        visible: changeInfoTextVisible,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                passVisible = false;
                                changePassTextVisible = true;
                                changeInfoTextVisible = false;
                                passController.text = password;
                              });
                            },
                            child: Text("Change User Information!")),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfile(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formfield.currentState!.validate()) {
                            if (changeInfoTextVisible == false) {
                              updateUser(
                                  userID,
                                  personID,
                                  fullNameController.text.toString(),
                                  emailController.text.toString(),
                                  password);
                            } else {
                              updateUser(
                                  userID,
                                  personID,
                                  fullNameController.text.toString(),
                                  emailController.text.toString(),
                                  passController.text.toString());
                            }

                            showCupertinoDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text('Success'),
                                content: const Text(
                                    'Profile changes saved successfully.'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () async {
                                        if (changeInfoTextVisible == false) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfile()));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginView()));
                                        }
                                      },
                                      child: const Text('OK'))
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Future<void> updateUser(userID, personID, personName, email, password) async {
    var response = await http.get(
      Uri.parse(updateUser_url +
          "userID=" +
          userID.toString() +
          "&personID=" +
          personID.toString() +
          "&personName=" +
          personName.toString() +
          "&email=" +
          email.toString() +
          "&password=" +
          password.toString()),
    );
  }
}
