import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/home_screen.dart';
import 'views/calendar_screen.dart';
import 'views/profile_screen.dart';
import 'package:provider/provider.dart';
import 'view_models/home_view_model.dart';
import 'view_models/calendar_view_model.dart';
import 'view_models/profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CalendarViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: AttendanceApp(),
    ),
  );
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = [HomeScreen(), CalendarScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Jump to the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        itemCount: _screens.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: _createFadeAnimation(index),
            child: _screens[index],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Animation<double> _createFadeAnimation(int index) {
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
    
    return animation;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
