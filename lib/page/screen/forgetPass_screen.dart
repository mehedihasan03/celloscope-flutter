import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/page/model/forgetPass.dart';
import 'package:flutter_frontend/page/screen/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helper/host_api.dart';
import '../../helper/http_helper.dart';
import '../model/signup.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key}) : super(key: key);

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _http = HttpHelper();
  final _formKey = GlobalKey<FormState>();
  bool userMatch = false;
  late User user;

  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> matchUser() async {
    String userId = _userIdController.value.text;
    var model = ForgetPass(userId: userId);
    String _body = jsonEncode(model.toMap());
    try {
      final response = await _http.postData(host + '/user/forgetPass', _body);
      Map<String, dynamic> map = jsonDecode(response.body);
      user = User.fromMap(map['data']);
      userMatch = true;
      setState(() {});
      Fluttertoast.showToast(
          msg: "User Found",
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

  Future<void> resetPass() async {
    String userId = _userIdController.value.text;
    String password = _passwordController.value.text;
    String mobile = user.mobile;
    var model = User(userId: userId, password: password, mobile: mobile);
    String _body = jsonEncode(model.toMap());
    try {
      final response = await _http.postData(host + '/user/reset', _body);
      Map<String, dynamic> map = jsonDecode(response.body);
      user = User.fromMap(map['data']);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loginpage(),
          ));
      Fluttertoast.showToast(
          msg: "Your password updated successful",
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
        title: const Text("Reset Password"),
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
                      'Reset Password',
                      style: TextStyle(
                          color: Color.fromRGBO(49, 87, 110, 1.0),
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 30, top: 0, right: 30, left: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid userId';
                      }
                      return null;
                    },
                    readOnly: userMatch,
                    controller: _userIdController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User ID',
                        hintText: "Type your User ID"),
                  ),
                ),
                if (userMatch)
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 30, top: 0, right: 30, left: 30),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter new Password',
                          hintText: "Password"),
                    ),
                  ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 87, 110, 1.0)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        if (!userMatch) {
                          if (_formKey.currentState!.validate()) {
                            matchUser();
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            resetPass();
                          }
                        }
                      },
                    )),
              ],
            )),
      ),
    );
  }
}
