import 'package:flutter/material.dart';
import 'package:z2rc_app/screens/home_screen.dart';
import 'package:z2rc_app/screens/login_screen.dart';
import 'package:z2rc_app/screens/registration_screen.dart'; // Import the login screen

void main() {
  // TODO: Add Firebase initialization here later
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform, // Needs firebase_options.dart
  // );
  runApp(const Z2RCApp());
}

class Z2RCApp extends StatelessWidget {
  const Z2RCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z2RC App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue, // Changed placeholder color
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), // Adjusted size
          bodyMedium: TextStyle(fontSize: 14.0),
          labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), // For button text
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue, // Text color
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, // Title text color
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      // Start the app with the LoginScreen
      // TODO: Implement proper auth state checking later to decide initial route
      home: const LoginScreen(),
      // TODO: Define routes for navigation later
       routes: {
         '/login': (context) => const LoginScreen(),
         '/register': (context) => const RegistrationScreen(),
         '/home': (context) => const HomeScreen(), // Placeholder
       },
    );
  }
}

