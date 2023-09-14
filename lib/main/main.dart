import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:time_picker_widget/time_picker_widget.dart';
//import 'package:time_picker_widget/main.dart';

void main() {
  runApp(const MathClassBookingApp());
}

class MathClassBookingApp extends StatelessWidget {
  const MathClassBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Class Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
       // useMaterial3: true,
      ),
      home: BookingScreen(),
    );
  }
}
class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Book Math Class'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _selectedDate == null
                  ? 'Select a date and time for your math class:'
                  : 'Selected Date and Time:  ${DateFormat('dd/MM/yyyy').format(_selectedDate!)} ${_selectedTime?.format(context)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () => _selectDateAndTime(context),
                child: Text('Pick a Date and Time'),
            ),
            SizedBox(height: 20,),
            if (_selectedDate != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(
                          selectedDate: _selectedDate!,
                          selectedTime: _selectedTime!,
                  ),
                    ),
                  );
                }, child: Text('Confirm Booking'),
              )

          ],
        ),
      ),
      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class ConfirmationScreen extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  ConfirmationScreen({
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have booked a math class on:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Time: ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
            )
          ],
        ),
      ),
    );
  }



}
