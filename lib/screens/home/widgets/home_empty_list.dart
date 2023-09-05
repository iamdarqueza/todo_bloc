import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          Lottie.asset(
              'assets/lottie/loading_cat.json'), // Replace with your Lottie animation file
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Text(
              'Make something happen from planning the day ahead',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Text(
              'Have a great one',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
