import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/custom_header.dart';
import 'login_screen.dart';
import 'order_new.dart';
import 'order_other.dart'; // لاستدعاء شاشة تسجيل الدخول عند انتهاء الجلسة

class OrderEmpty extends StatefulWidget {
  const OrderEmpty({super.key});

  @override
  State<OrderEmpty> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrderEmpty> with WidgetsBindingObserver {
  String selected = "New"; // الحالة الافتراضية
  Timer? _sessionTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startSessionTimer();
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(const Duration(minutes: 2), () {
      // إذا انتهت الجلسة ارجع لشاشة Login
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    });
  }

  void _resetSessionTimer() {
    _startSessionTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sessionTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // المستخدم خرج من التطبيق، شغل المؤقت مباشرة
      _startSessionTimer();
    } else if (state == AppLifecycleState.resumed) {
      // المستخدم رجع للتطبيق، رجع المؤقت
      _resetSessionTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetSessionTimer, // كل مرة المستخدم يتفاعل، رجع المؤقت
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Column(
          children: [
            const CustomHeader(),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = "New";
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrderNews()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selected == "New" ? Color(0xff004F62) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "New",
                          style: TextStyle(
                            color: selected == "New" ? Colors.white : Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = "Others";
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrderOther()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selected == "Others" ? Color(0xff004F62): Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Others",
                          style: TextStyle(
                            color: selected == "Others" ? Colors.white : Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Column(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/ic_image.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  "No Orders yet",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "You don’t have any orders in your history.",
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
