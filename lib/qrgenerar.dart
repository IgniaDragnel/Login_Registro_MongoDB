import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratePage extends StatelessWidget {
  final String qrData;

  // Constructor
  QRGeneratePage({required this.qrData});

  // Function to handle logout
  void handleLogout(BuildContext context) {
    // Perform any logout actions here (e.g., clearing tokens, shared preferences)
    Navigator.pop(context); // Navigate back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
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
            Text("Scannear QR.0"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleLogout(context),
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
