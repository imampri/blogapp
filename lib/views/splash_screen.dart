import 'package:blogapp/views/article_list_screen.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.text_fields_outlined,
                color: Constants.whiteColor,
                size: Constants.sizeXL * 8,
              ),
              const Text(
                Constants.appName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Constants.sizeXL * 2,
                  fontWeight: Constants.bold,
                ),
              ),
              const SizedBox(
                height: Constants.sizeXXXL,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleListScreen()),
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                ),
                child: const Text(
                  "Mulai >",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: Constants.sizeXL * 2,
                    fontWeight: Constants.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
