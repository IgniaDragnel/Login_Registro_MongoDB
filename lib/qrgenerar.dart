import 'package:app_qr_users_view/homePage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratePage extends StatelessWidget {
  final String qrData;

  // Constructor
  QRGeneratePage({required this.qrData});

  // Function to handle logout
  void handleLogout(BuildContext context) {
    // Perform any logout actions here (e.g., clearing tokens, shared preferences)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage()), // Replace with your HomePage class
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => handleLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: qrData,
              version: QrVersions.auto,
              size: 200,
            ),
            SizedBox(height: 20),
            Text(
              "Escanear Código QR",
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleLogout(context),
              child: Text("Cerrar Sesión"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
