import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.text_fields_outlined,
                color: Constants.whiteColor,
                size: Constants.sizeXL * 8,
              ),
              Text(Constants.appName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Constants.sizeXL * 2,
                  fontWeight: Constants.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
