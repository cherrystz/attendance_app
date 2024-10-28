
# Attendance App

This is an attendance tracking mobile application built with Flutter. It utilizes Firebase for backend services and Provider for state management. Users can check in, check out, and view their attendance history using a calendar interface.

## Features

- **User Authentication**: Secure sign-in and sign-out with Firebase.
- **Check-In / Check-Out**: Users can record attendance daily.
- **Calendar View**: Displays attendance records on a calendar interface.
- **Provider for State Management**: Manages application state efficiently across screens.
- **Firebase Integration**: Stores and retrieves attendance data with Firebase Firestore.

## Screenshots

<!-- Add your screenshots here if available -->
![Home Screen](https://github.com/cherrystz/attendance_app/blob/main/screenshots/attendance_screen.png)
![Calendar Screen](https://github.com/cherrystz/attendance_app/blob/main/screenshots/calendar_screen.png)
![Profile Screen](https://github.com/cherrystz/attendance_app/blob/main/screenshots/profile_screen.png)

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v2.0 or higher)
- [Firebase account](https://firebase.google.com/)
- [Cloud Firestore](https://firebase.google.com/docs/firestore) and [Firebase Authentication](https://firebase.google.com/docs/auth)

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/attendance-app.git
    cd attendance-app
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up Firebase with FlutterFire CLI:**
 - Install the FlutterFire CLI if you haven’t already:
	 ```bash
      dart pub global activate flutterfire_cli
	```
  - Log in to your Firebase account:
      ```bash
      flutterfire login
      ```
   - Initialize Firebase in your Flutter project:
      ```bash
      flutterfire configure
      ```
   - This will link your Firebase project to your Flutter app and generate a `firebase_options.dart` file. 
4. **Import the Firebase options in `main.dart` and initialize Firebase:**
   ```dart
   import 'firebase_options.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
     runApp(MyApp());
   }
   ```
   
5. **Add clientId for GoogleSignIn:**
- Add clientId to  `firebase_options.dart` file:
	```flutter
      get clientId => 'xxxxxxxxxxx';
6. **Run the App:**
    ```bash
    flutter run
    ```

## Project Structure

The project follows the MVVM architecture to separate business logic from the UI.

```plaintext
├── lib
│   ├── models
│   │   └── attendance_model.dart       # Model representing attendance data
│   ├── services
│   │   └── auth_service.dart           # Service for Firebase Authentication
│   ├── view_models
│   │   └── calendar_view_model.dart    # ViewModel for calendar logic
│   ├── views
│   │   ├── calendar_screen.dart        # Calendar view screen
│   │   └── home_screen.dart            # Home screen for check-in and check-out
│   └── main.dart                       # Main application entry point
```

## Usage

1.  **Sign In**: After launching the app, sign in using Firebase Authentication.
2.  **Check In**: On the home screen, tap "Check In" to record your check-in time.
3.  **Check Out**: Tap "Check Out" to record your check-out time.
4.  **View Attendance**: Go to the calendar screen to see your attendance records by date.

## Dependencies

-   [Flutter](https://flutter.dev/)
-   Provider - State management
-   Firebase Core - Firebase initialization
-   Firebase Auth - Authentication
-   Cloud Firestore - Data storage
-   Table Calendar - Calendar view

## Contributing

Contributions are welcome! Please fork the repository and create a pull request for review.

1.  Fork the repository
2.  Create a new branch (`git checkout -b feature-branch`)
3.  Commit your changes (`git commit -m 'Add some feature'`)
4.  Push to the branch (`git push origin feature-branch`)
5.  Create a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
```sql
Feel free to adjust any specific project details as needed!
```
