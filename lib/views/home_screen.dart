import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: Constants.sizeL * 2,
              fontWeight: Constants.bold,
            ),
          ),
          backgroundColor: Constants.scaffoldBgColor,
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Constants.secondaryColor),
        ),
        backgroundColor: Constants.primaryColor,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.text_fields_outlined,
                color: Constants.whiteColor,
                size: Constants.sizeXL * 8,
              ),
              Text(
                "Home",
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
