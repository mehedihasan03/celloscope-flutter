import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/page/model/signup.dart';
import 'package:flutter_frontend/page/screen/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helper/host_api.dart';
import '../../helper/http_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _http = HttpHelper();

  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  Future<void> signUp() async {
    String userId = _userIdController.value.text;
    String password = _passwordController.value.text;
    String mobile = _mobileController.value.text;
    var model = User(userId: userId, password: password, mobile: mobile);
    String _body = jsonEncode(model.toMap());
    try {
      final response = await _http.postData(host + '/user/save', _body);
      print(response.toString());
      Fluttertoast.showToast(
          msg: response.toString(),
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
        title: const Text("Registration"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'Registration',
                    style: TextStyle(
                        color: Color.fromRGBO(49, 87, 110, 1.0),
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User ID',
                      hintText: "Type your User ID"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: "Type your password"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile No',
                      hintText: "Type your Mobile no"),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(49, 87, 110, 1.0)),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      print(_userIdController.text);
                      print(_passwordController.text);
                      print(_mobileController.text);
                      signUp();
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('already have an account?'),
                  TextButton(
                    child: const Text(
                      'Login here',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
