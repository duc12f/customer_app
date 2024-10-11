import 'package:bandoan/components/my_drawer_title.dart';
import 'package:bandoan/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        //app logo
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Icon(
              Icons.lock,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),  
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyDrawerTitle(icon: Icons.home, onTap: (){
            Navigator.pushNamed(context, '/home');
          }, text: 'Home'),
          MyDrawerTitle(icon: Icons.settings, onTap: (){
            Navigator.pushNamed(context, '/settings');
          }, text: 'Settings'),
          const Spacer(),
          MyDrawerTitle(icon: Icons.logout, onTap: (){logout();}, text: 'Log Out'),

          const SizedBox(height: 30,),

        ],
      ),
    );
  }
}