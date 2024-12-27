import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionDeniedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Denied'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location permission is required to use this app.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to app settings
                Geolocator.openAppSettings();
              },
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}