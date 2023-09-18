import 'package:booking_app/firebase_options.dart';
import 'package:booking_app/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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

  MathClassBookingApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context)=> context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
        title: 'Math Class Booking',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
         // useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    //final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Book Math Class'),
        automaticallyImplyLeading: false,
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                  icon: Icon(Icons.home)
                ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: Icon(Icons.person)),
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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Confirmed Date and Time: ${DateFormat('dd/MM/yyyy').format(selectedDate)} ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: Icon(Icons.home)
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

}


class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({super.key});

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailPasswordSignIn()));
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

class EmailPasswordSignIn extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignIn({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignInState createState() => _EmailPasswordSignInState();
}

class _EmailPasswordSignInState extends State<EmailPasswordSignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> loginUser(BuildContext context) async {

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
    final User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      return true;
    } else {
      return false;
    }

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
              // Formularz logowania
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Enter your email'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Enter your password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Przycisk do rejestracji
              ElevatedButton(
                  onPressed: () async {
        bool loginSuccess = await loginUser(context);
        if (loginSuccess) {
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen())
            );
          }
        } else {
        // Tutaj możesz obsłużyć przypadki niepowodzenia logowania
        }
        },
                child: const Text('Login'),
              ),

              const SizedBox(height: 20),

              // Przycisk do powrotu do ekranu logowania
              TextButton(
                onPressed: () {
                  // Przejdź do ekranu logowania
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  Navigator.pop(context);
                },
                child: const Text("Don't have an account? Register here."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




