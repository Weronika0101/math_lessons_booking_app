import 'package:booking_app/firebase_options.dart';
import 'package:booking_app/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:time_picker_widget/time_picker_widget.dart';
//import 'package:time_picker_widget/main.dart';

void main() async {
  //Logger.level = Level.verbose;
  WidgetsFlutterBinding.ensureInitialized();
  print('starting app');
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {}
  print('firebase inited');


  //await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
 // );
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
  const BookingScreen({super.key});

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
        title: const Text('Book Math Class'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _selectedDate == null
                  ? 'Select a date and time for your math class:'
                  : 'Selected Date and Time:  ${DateFormat('dd/MM/yyyy').format(_selectedDate!)} ${_selectedTime?.format(context)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () => _selectDateAndTime(context),
                child: const Text('Pick a Date and Time'),
            ),
            const SizedBox(height: 20,),
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
                }, child: const Text('Confirm Booking'),
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

  ConfirmationScreen({super.key,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have booked a math class on:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Time: ${selectedTime.format(context)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
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
        title: const Text('Login or Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Przejdź do ekranu logowania
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text('Log In'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Przejdź do ekranu rejestracji
                Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPasswordSignup()));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic for user login here
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Enter your email'),
              ),
              TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Create Password'),
                  obscureText: true,
              ),
              const SizedBox(height: 20),
              // Przycisk do rejestracji
              ElevatedButton(
                onPressed: signUpUser,
                child: const Text('Register'),
              ),

              const SizedBox(height: 20),

              // Przycisk do powrotu do ekranu logowania
              TextButton(
                onPressed: () {
                  // Przejdź do ekranu logowania
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    Navigator.pop(context);
                },
                child: const Text('Already have an account? Log in here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}