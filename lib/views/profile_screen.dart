import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    viewModel.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: viewModel.isSignedIn && viewModel.photoURL.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          viewModel.photoURL,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person, size: 50); 
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      )
                    : Icon(Icons.person, size: 50), 
              ),
              SizedBox(height: 20),
              Text(
                viewModel.userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                viewModel.userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (viewModel.isSignedIn) {
                    await viewModel.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signed out successfully!')),
                    );
                  } else {
                    await viewModel.signIn();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signed in successfully!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: viewModel.isSignedIn ? Colors.red : Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  viewModel.isSignedIn ? 'Sign Out' : 'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
