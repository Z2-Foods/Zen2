import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Placeholder for registration logic (Firebase Auth)
      print('Tentativa de registro com:');
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
      // Show a snackbar or navigate - for now, just print
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A funcionalidade de registro ainda não foi implementada.')),
      );
      // Potentially navigate back to login or to a home screen after successful registration
      // Navigator.pop(context); // Example: Go back to login
    }
  }

  void _navigateToLogin() {
     // Placeholder for navigation
    print('Navegar para a tela de login');
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Navegação para Login ainda não implementada.')),
      );
    // Navigator.pop(context); // Go back to the previous screen (Login)
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se'),
        // Optionally add a back button if pushed onto the stack
         leading: IconButton(
           icon: const Icon(Icons.arrow_back),
           onPressed: _navigateToLogin,
         ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um endereço de e-mail válido';
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
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira uma senha';
                  }
                  if (value.length < 8) { // Example: Enforce minimum length
                    return 'A senha deve ter pelo menos 8 caracteres';
                  }
                  // TODO: Add more password strength validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirme sua senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não correspondem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Cadastre-se'),
              ),
               const SizedBox(height: 16.0),
              TextButton(
                onPressed: _navigateToLogin, // Use the navigation function
                child: const Text('Já tem uma conta? Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

