import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Placeholder data - replace with actual user data fetching later
  String _name = "Jane Doe";
  int? _age = 30;
  double? _weight = 65.0;
  double? _height = 170.0;
  String _sex = "Female"; // Options: Male, Female, Prefer not to answer
  String _goal = "Performance"; // Options: Performance, Quality of Life

  bool _isEditing = false;

  // Controllers for editing mode
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  void _updateControllers() {
    _nameController.text = _name;
    _ageController.text = _age?.toString() ?? '';
    _weightController.text = _weight?.toString() ?? '';
    _heightController.text = _height?.toString() ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        _updateControllers(); // Load current data into controllers when starting edit
      } else {
        // Optionally reset controllers or handle cancellation
      }
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Placeholder for saving logic (e.g., update Firebase Firestore/RTDB)
        _name = _nameController.text;
        _age = int.tryParse(_ageController.text);
        _weight = double.tryParse(_weightController.text);
        _height = double.tryParse(_heightController.text);
        // _sex and _goal are handled by dropdowns

        print('Perfil salvo (Placeholder):');
        print('Nome: $_name, Idade: $_age, Peso: $_weight, Altura: $_height, Sexo: $_sex, Objetivo: $_goal');

        _isEditing = false; // Exit editing mode after saving
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil salvo (Placeholder).')),
      );
    }
  }

  Widget _buildDisplayField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'Não definido'),
        ],
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, TextInputType keyboardType, {bool isRequired = false, bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Por favor insira $label';
          }
          if (isNumeric && value != null && value.isNotEmpty && double.tryParse(value) == null) {
             return 'Por favor, insira um número válido';
          }
          // Add more specific validation if needed (e.g., age range)
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String label, String currentValue, List<String> options, ValueChanged<String?> onChanged) {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
         validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Selecione $label';
            }
            return null;
          },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.cancel : Icons.edit),
            tooltip: _isEditing ? 'Cancelar' : 'Editar perfil',
            onPressed: _toggleEdit,
          ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Salvar perfil',
              onPressed: _saveProfile,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEditField('Nome', _nameController, TextInputType.name, isRequired: true),
                    _buildEditField('Idade', _ageController, TextInputType.number, isRequired: true, isNumeric: true),
                    _buildEditField('Peso (kg)', _weightController, TextInputType.numberWithOptions(decimal: true), isNumeric: true),
                    _buildEditField('Altura (cm)', _heightController, TextInputType.numberWithOptions(decimal: true), isNumeric: true),
                    _buildDropdownField('Sexo', _sex, ['Masculino', 'Feminino', 'Prefiro não responder'], (newValue) {
                       if (newValue != null) {
                          setState(() {
                            _sex = newValue;
                          });
                        }
                    }),
                    _buildDropdownField('Objetivo principal', _goal, ['Performance', 'Qualidade de Vida'], (newValue) {
                       if (newValue != null) {
                          setState(() {
                            _goal = newValue;
                          });
                        }
                    }),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Salvar perfil'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDisplayField('Nome', _name),
                  _buildDisplayField('Idade', _age?.toString()),
                  _buildDisplayField('Peso', _weight != null ? '${_weight} kg' : null),
                  _buildDisplayField('Altura', _height != null ? '${_height} cm' : null),
                  _buildDisplayField('Sexo', _sex),
                  _buildDisplayField('Objetivo principal', _goal),
                  // TODO: Add other profile info display if needed
                ],
              ),
      ),
    );
  }
}

