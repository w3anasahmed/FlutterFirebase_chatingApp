import 'package:chating_app/screeens/home_page.dart';
import 'package:chating_app/screeens/settings_page.dart';
import 'package:chating_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 80),
              Icon(
                Icons.message,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('H O M E'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ); // Close the drawer
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('S E T T I N G S'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
              onTap: () {
                Navigator.pop(context);
                _authService.signOut();
                // Handle logout logic here
              },
            ),
          ),
          //
        ],
      ),
    );
  }
}
