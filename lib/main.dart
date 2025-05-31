import 'package:flutter/material.dart';
import 'package:new_flutter_project/screens/splash/splash_screen.dart';
import 'screens/auth/doctor_login.dart';
import 'screens/auth/doctor_signup.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/appointments/appointments_screen.dart';
import 'screens/doctor/doctor_dashboard.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/auth/doctor_login_screen.dart';
import 'screens/auth/doctor_signup_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/appointments/book_appointment_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'screens/admin/admin_dashboard.dart' show AdminDashboard;
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/appointments/book_appointment.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/doctor/doctor_dashboard.dart';
import 'screens/onboarding/onboarding_screen.dart' show OnboardingScreen;
import 'screens/welcome/welcome_screen.dart';
import 'screens/home/home_screen.dart';
import 'widgets/action_card.dart';
import 'widgets/app_logo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        '/book-appointment': (context) => BookAppointmentScreen(),
        '/doctor-dashboard': (context) => DoctorDashboard(),
        '/chat': (context) => ChatScreen(),
        '/admin': (context) => AdminDashboard(),
        '/doctor_login': (context) => DoctorLoginScreen(),
        '/doctor_signup': (context) => DoctorSignupScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(8.0), child: AppLogo()),
        title: Text('Mental Health Care'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ActionCard(
                  title: 'Book Appointment',
                  icon: Icons.calendar_today,
                  onTap:
                      () => Navigator.pushNamed(context, '/book-appointment'),
                ),
                ActionCard(
                  title: 'Chat with Doctor',
                  icon: Icons.chat,
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                ),
                // In HomeScreen class, update the ActionCard onTap handlers
                // to navigate to the respective screens.
                ActionCard(
                  title: 'My Appointments',
                  icon: Icons.schedule,
                  onTap: () => Navigator.pushNamed(context, '/appointments'),
                ),
                ActionCard(
                  title: 'Profile',
                  icon: Icons.person_outline,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
