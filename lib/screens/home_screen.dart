import 'package:flutter/material.dart';
import 'package:z2rc_app/screens/activity_log_screen.dart';
import 'package:z2rc_app/screens/profile_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) {
    // Placeholder for logout logic
    print('Sair clicado');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('A funcionalidade de logout ainda não foi implementada.')),
    );
    // TODO: Implement actual logout and navigation back to LoginScreen
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => const LoginScreen()),
     );
  }

  void _navigateToActivityLog(BuildContext context) {
    print('Navegue até a tela de registro de atividades na tela inicial');
    Navigator.push(
      context, // Use the passed context
      MaterialPageRoute(builder: (context) => const ActivityLogScreen()), // Navigate to ActivityLogScreen
    );
  }
  void _navigateToProfile(BuildContext context) {
    print('Navegue até a tela de perfil na tela inicial');
    Navigator.push(
      context, // Use the passed context
      MaterialPageRoute(builder: (context) => const ProfileScreen()), // Navigate to ActivityLogScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z2RC Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column( // Use a Column to add more widgets
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo ao Z2RC! (Home Screen Placeholder)'),
            const SizedBox(height: 20),
            // Add a button that calls _navigateToActivityLog, passing the context
            ElevatedButton(
              onPressed: () => _navigateToActivityLog(context),
              child: const Text('Ir para a tela de registro de atividades'),
            ),
            const SizedBox(height: 10), // Add some space
            // Button to navigate to Profile
            ElevatedButton(
              onPressed: () => _navigateToProfile(context),
              child: const Text('Vá para a tela de perfil'),
            ),
            // TODO: Build out the actual home screen dashboard UI
          ],
        ),

      ),
      // TODO: Add BottomNavigationBar for main sections (Home, Plans, Log, Profile?)
      // bottomNavigationBar: BottomNavigationBar(...),
    );
  }
}

