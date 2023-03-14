// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
import 'package:construction_flutter_application/utils/global.dart';
import 'package:construction_flutter_application/view/Dashboard/dashboard.dart';

import 'package:construction_flutter_application/view/Login/widgets/button.global.dart';
import 'package:construction_flutter_application/view/Login/widgets/text.form.global.dart';
import 'package:construction_flutter_application/view/Project/projects_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/User/user_model.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() => isAlertSet = true);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your intenet connectivity'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('OK'))
          ],
        ),
      );

  login(String name, password, BuildContext context) async {
    try {
      // var st = "http://192.168.100.111:9027/ISOService.svc/getUser/" +
      //     name +
      //     "/" +
      //     password;

      var response = await http.get(
        Uri.parse(getUser_url + "name=" + name + "&password=" + password),
      );

      if (response.statusCode == 200 && response.contentLength != 0) {
        var data = jsonDecode(response.body.toString());
        print('Login Successfully');

        var user = User.fromJson(jsonDecode(response.body));

        setUser(user.userId, user.userRole, user.personId, user.loginName,
            password, user.email, user.personName);

        if (user.userRole == "Junior Site Engineer" ||
            user.userRole == "Site Engineer") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProjectsList()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard()));
        }
      } else {
        showCupertinoDialog<String>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Login Error'),
            content: const Text('Please check your email and password.'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('OK'))
            ],
          ),
        );
      }
    } catch (e) {
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Login Error'),
          content: const Text('Please check your email and password.'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('OK'))
          ],
        ),
      );
    }
    // if (name == "admin") {
    // } else {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => ProjectsList()));
    // }
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.android,
                //   size: 100,
                // ),
                const SizedBox(height: 80),
                Image.asset('assets/images/asc.png'),
                const SizedBox(height: 80),

                // //Hello again!
                // Text(
                //   "Hello Again!",
                //   style: GoogleFonts.bebasNeue(
                //     fontSize: 52,
                //   ),
                // ),
                // const SizedBox(height: 10),
                const Text(
                  "Welcome back, you\'ve been missed!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Input
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 20),

                // Password Input
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obscure: true,
                  ),
                ),

                const SizedBox(height: 50),

                // Login Button
                FractionallySizedBox(
                    widthFactor:
                        0.9, // means 100%, you can change this to 0.8 (80%)
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: Size(150,
                            55), // takes postional arguments as width and height
                      ),
                      child: Text("Login"),
                      onPressed: () {
                        login(emailController.text.toString(),
                            passwordController.text.toString(), context);
                      },
                    )),

                // GestureDetector(
                //   onTap: () {
                //     login(emailController.text.toString(),
                //         passwordController.text.toString(), context);
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.only(left: 20, right: 20),
                //     child: const ButtonGlobal(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
