import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/page/screen/forgetPass_screen.dart';
import 'package:flutter_frontend/page/screen/home_screen.dart';
import 'package:flutter_frontend/page/screen/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helper/host_api.dart';
import '../../helper/http_helper.dart';
import '../model/login.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _http = HttpHelper();
  final _formKey = GlobalKey<FormState>();

  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser() async {
    String userId = _userIdController.value.text;
    String password = _passwordController.value.text;
    var model = Login(userId: userId, password: password);
    String _body = jsonEncode(model.toMap());
    try {
      final response = await _http.postData(host + '/login', _body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Login"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromRGBO(49, 87, 110, 1.0),
                          fontWeight: FontWeight.w900,
                          fontSize: 40),
                    )),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid userId';
                      }
                      return null;
                    },
                    controller: _userIdController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User ID',
                        hintText: "Type your User ID"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Password';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: "Type your password"),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassPage()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 87, 110, 1.0)),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser();
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
      ),
    );
  }
}
