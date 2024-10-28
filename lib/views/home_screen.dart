import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Attendance')),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: viewModel.isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => viewModel.checkIn(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          ),
                          child: Text('Check In', style: TextStyle(fontSize: 18)),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => viewModel.checkOut(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          ),
                          child: Text('Check Out', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
