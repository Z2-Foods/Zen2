import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _dateController = TextEditingController();
  final _durationHoursController = TextEditingController(text: '0');
  final _durationMinutesController = TextEditingController(text: '0');
  final _durationSecondsController = TextEditingController(text: '0');
  final _distanceController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _activityType = 'Correr'; // Default activity type

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _durationHoursController.dispose();
    _durationMinutesController.dispose();
    _durationSecondsController.dispose();
    _distanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000), // Allow logging past activities
      lastDate: DateTime.now(), // Don't allow logging future activities
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _logActivity() {
    if (_formKey.currentState!.validate()) {
      // Combine duration fields
      int hours = int.tryParse(_durationHoursController.text) ?? 0;
      int minutes = int.tryParse(_durationMinutesController.text) ?? 0;
      int seconds = int.tryParse(_durationSecondsController.text) ?? 0;
      Duration duration = Duration(hours: hours, minutes: minutes, seconds: seconds);

      double distance = double.tryParse(_distanceController.text) ?? 0.0;
      String notes = _notesController.text;

      // Placeholder for saving logic (e.g., update Firebase Firestore/RTDB)
      print('Atividade registrada (Placeholder):');
      print('Tipo: $_activityType');
      print('Data: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}');
      print('Duração: ${duration.toString()}'); // Format as needed
      print('Distância: $distance km'); // Assuming km
      print('Notas: $notes');

      // Calculate Pace (example: minutes per km)
      if (distance > 0 && duration.inSeconds > 0) {
        double paceMinutesPerKm = (duration.inMinutes / distance);
        print('Pace: ${paceMinutesPerKm.toStringAsFixed(2)} min/km');
      }
       // Estimate Calories (very basic placeholder - needs a proper formula)
      if (distance > 0 && duration.inMinutes > 0) {
         double calories = distance * 70; // Extremely rough estimate
         print('Calorias estimadas: ${calories.toStringAsFixed(0)}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Atividade registrada (Placeholder).')),
      );
      // Optionally navigate away or clear the form
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar atividade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Activity Type Selector (Dropdown)
              DropdownButtonFormField<String>(
                value: _activityType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de atividade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_run), // Dynamic icon?
                ),
                items: <String>['Correr', 'Caminhar', 'Pedalar', 'Outro'] // Example types
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _activityType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Date Picker
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Data',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true, // Prevent manual editing
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16.0),

              // Duration Input (HH:MM:SS)
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.grey), // Icon for duration
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _durationHoursController,
                      decoration: const InputDecoration(labelText: 'HH', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Text(':')),
                  Expanded(
                    child: TextFormField(
                      controller: _durationMinutesController,
                      decoration: const InputDecoration(labelText: 'MM', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                       validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 59) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                   const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Text(':')),
                  Expanded(
                    child: TextFormField(
                      controller: _durationSecondsController,
                      decoration: const InputDecoration(labelText: 'SS', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                       validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0 || int.parse(value) > 59) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Distance Input
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(
                  labelText: 'Distância (km)', // Specify unit
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a distância';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Por favor, insira uma distância positiva válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Notes Input
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas (Opcional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24.0),

              // Submit Button
              ElevatedButton(
                onPressed: _logActivity,
                child: const Text('Registrar atividade'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

