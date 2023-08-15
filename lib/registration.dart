import 'dart:convert';
import 'dart:math';
import 'package:app_qr_users_view/qrgenerar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  String selectedEnfermedad = "Enfermedad 1";
  String selectedAlergia = "Alergia 1";
  String selectedMedicamento = "Medicamento 1";

  List<String> enfermedades = ["Enfermedad 1", "Enfermedad 2", "Enfermedad 3"];
  List<String> alergias = ["Alergia 1", "Alergia 2", "Alergia 3"];
  List<String> medicamentos = [
    "Medicamento 1",
    "Medicamento 2",
    "Medicamento 3"
  ];

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
        "nombre": nombreController.text,
        "apellido": apellidoController.text,
        "edad": edadController.text,
        "cedula": cedulaController.text,
        "enfermedad": selectedEnfermedad,
        "alergia": selectedAlergia,
        "medicamento": selectedMedicamento,
      };

      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        // Generate QR code data without the password
        var qrDataList = [
          emailController.text,
          nombreController.text,
          apellidoController.text,
          edadController.text,
          cedulaController.text,
          selectedEnfermedad,
          selectedAlergia,
          selectedMedicamento,
        ];

        String qrData = qrDataList.join(',');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRGeneratePage(qrData: qrData),
          ),
        );
      } else {
        print("Something Went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
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
                tileMode: TileMode.mirror),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CommonLogo(),
                  HeightBox(10),
                  "Registrate".text.size(22).extraBlack.make(),
                  TextField(
                    controller: nombreController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Nombre",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: apellidoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Apellido",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: edadController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Edad",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: cedulaController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Cedula",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            final data =
                                ClipboardData(text: passwordController.text);
                            Clipboard.setData(data);
                          },
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.password),
                          onPressed: () {
                            String passGen = generatePassword();
                            passwordController.text = passGen;
                            setState(() {});
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  DropdownButton<String>(
                    value: selectedEnfermedad,
                    onChanged: (newValue) {
                      setState(() {
                        selectedEnfermedad = newValue!;
                      });
                    },
                    items: enfermedades.map((enfermedad) {
                      return DropdownMenuItem<String>(
                        value: enfermedad,
                        child: Text(enfermedad),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedAlergia,
                    onChanged: (newValue) {
                      setState(() {
                        selectedAlergia = newValue!;
                      });
                    },
                    items: alergias.map((alergia) {
                      return DropdownMenuItem<String>(
                        value: alergia,
                        child: Text(alergia),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedMedicamento,
                    onChanged: (newValue) {
                      setState(() {
                        selectedMedicamento = newValue!;
                      });
                    },
                    items: medicamentos.map((medicamento) {
                      return DropdownMenuItem<String>(
                        value: medicamento,
                        child: Text(medicamento),
                      );
                    }).toList(),
                  ),
                  HStack([
                    GestureDetector(
                      onTap: () => {registerUser()},
                      child: VxBox(
                              child:
                                  "Registrar".text.white.makeCentered().p16())
                          .blue600
                          .roundedLg
                          .make()
                          .px16()
                          .py16(),
                    ),
                  ]),
                  GestureDetector(
                    onTap: () {
                      print("Sign In");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: HStack([
                      "Ya te registrste?".text.make(),
                      " Inicio de sesion".text.blue100.make()
                    ]).centered(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';

  String password = '';

  int passLength = 20;

  String seed = upper + lower + numbers + symbols;

  List<String> list = seed.split('').toList();

  Random rand = Random();

  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}
