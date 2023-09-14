import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:time_picker_widget/time_picker_widget.dart';
//import 'package:time_picker_widget/main.dart';

void main() {
  runApp(MathClassBookingApp());
}

class MathClassBookingApp extends StatelessWidget {
  //const MathClassBookingApp({super.key});
  //bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Class Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
       // useMaterial3: true,
      ),
      home: LoginOrRegisterScreen(),
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

class LoginOrRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login or Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Przejdź do ekranu logowania
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Przejdź do ekranu rejestracji
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic for user login here
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Formularz rejestracji
              TextFormField(
                decoration: InputDecoration(labelText: 'Create Username'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Create Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              // Przycisk do rejestracji
              ElevatedButton(
                onPressed: () {
                  // Implementuj logikę rejestracji
                  // ...
                },
                child: Text('Register'),
              ),

              SizedBox(height: 20),

              // Przycisk do powrotu do ekranu logowania
              TextButton(
                onPressed: () {
                  // Przejdź do ekranu logowania
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    Navigator.pop(context);
                },
                child: Text('Already have an account? Log in here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}