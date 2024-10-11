import 'package:bandoan/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Dark Mode Switch
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context).isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleThemeData();
                    },
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //         onPressed: () {
            //           final restaurant = Restaurant();
            //           restaurant
            //               .addMenuToFirebase(); // Gọi hàm thêm dữ liệu vào Firestore
            //         },
            //         child: const Text('Add Menu to Firestore'),
            //       ),
            const SizedBox(height: 20),

            // Other settings options can be added here
            // Container(
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.secondary,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   padding: const EdgeInsets.all(25),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Notifications',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Theme.of(context).colorScheme.inversePrimary,
            //         ),
            //       ),
            //       Icon(
            //         Icons.arrow_forward_ios,
            //         color: Theme.of(context).colorScheme.inversePrimary,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
