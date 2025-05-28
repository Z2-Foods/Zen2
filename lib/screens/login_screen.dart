import 'package:flutter/material.dart';
import 'package:z2rc_app/screens/registration_screen.dart'; // Import registration screen
import 'package:z2rc_app/screens/home_screen.dart'; // Import home screen placeholder

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Placeholder for login logic (Firebase Auth)
      print('Tentativa de login com:');
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
      // Show a snackbar or navigate - for now, navigate to Home
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login bem-sucedido (Placeholder). Navegando para casa.')),
      );
      Navigator.pushReplacement( // Use pushReplacement to prevent going back to login
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _navigateToRegister() {
    print('Navegar para a tela de registro');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  void _forgotPassword() {
    // Placeholder for password recovery
    print('Esqueceu a senha? Clicou');
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recuperação de senha ainda não implementada.')),
      );
    // TODO: Implement password recovery flow (e.g., show dialog or new screen)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z2RC Login'),
      ),
      body: Center( // Center the form vertically
        child: SingleChildScrollView( // Allow scrolling on smaller screens
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Optional: Add an App Logo here
                // Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira seu e-mail';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),
                    // TODO: Add suffix icon for visibility toggle
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor digite sua senha';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: const Text('Esqueceu sua senha?'),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16.0),
                // TODO: Add Social Login Buttons (Google, Facebook) later
                // Row( ... )
                const SizedBox(height: 24.0),
                TextButton(
                  onPressed: _navigateToRegister,
                  child: const Text('Não tem uma conta? Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

