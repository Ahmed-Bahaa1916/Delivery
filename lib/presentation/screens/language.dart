import 'package:flutter/material.dart';

import '../../core/constant.dart';
import 'login_screen.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLang = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose Language",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppThem.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLang = "ar";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedLang == "ar"
                                ? Colors.green
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: selectedLang == "ar"
                              ? Colors.green.withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/images/arbaic.png", height: 20),
                            const SizedBox(height: 8),
                            Text(
                              "العربية",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Arabic"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLang = "en";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedLang == "en"
                                ? Colors.green
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: selectedLang == "en"
                              ? Colors.green.withOpacity(0.1)
                              : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/english.png",
                              height: 20,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "English",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("English"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff004F62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
