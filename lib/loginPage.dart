import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_qr_users_view/qrgenerar.dart';
import 'package:app_qr_users_view/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        String qrData = jsonEncode({
          "email": emailController.text,
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRGeneratePage(qrData: qrData),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(Icons.error, color: Colors.red),
              content: Text('Los datos de inicio de sesión son incorrectos.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFF0FFC0), const Color(0xFFCCFFCC)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 0.8],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  Icon(Icons.email, size: 40, color: Colors.yellow[100]),
                  "Email Sign-In"
                      .text
                      .size(22)
                      .color(Colors.yellow[100]!)
                      .make(),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      errorText: _isNotValidate ? "Enter Proper Info" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ).p4().px24(),
                  GestureDetector(
                    onTap: () {
                      loginUser();
                    },
                    child: HStack([
                      VxBox(
                        child: Row(
                          children: [
                            Icon(Icons.login, color: Colors.black),
                            "Inicio de Sesion".text.black.makeCentered().p16(),
                          ],
                        ),
                      ).color(Colors.lightGreen[600]!).roundedLg.make(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Registration()),
            );
          },
          child: Container(
            height: 25,
            color: Colors.lightGreen[200],
            child: Center(
              child: "Create una nueva cuenta..! Sign Up"
                  .text
                  .black
                  .makeCentered(),
            ),
          ),
        ),
      ),
    );
  }
}
