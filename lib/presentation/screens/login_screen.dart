import 'dart:async';
import 'package:delivery/presentation/screens/order_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit_state.dart';
import '../../core/constant.dart';
import '../../infrastructure/datasources/api_sevices.dart';
import '../widget/custom_textfield.dart';
import 'language.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
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
      _startSessionTimer();
    } else if (state == AppLifecycleState.resumed) {
      _resetSessionTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetSessionTimer,
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Color(0xffD42A0F),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(120),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LanguageScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        "assets/images/OnxRestaurant_Logo@2x.png",
                        height: 80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: AppThem.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Log back into your account",
                  style: TextStyle(fontSize: 14, color: AppThem.primary),
                ),
                const SizedBox(height: 40),

                CustomTextField(hint: 'User Id', controller: userIdController),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "Show More",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppThem.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final userId = userIdController.text.trim();
                        final password = passwordController.text.trim();
                        const languageNo = "1";

                        if (userId.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter User ID and Password',
                              ),
                            ),
                          );
                          return;
                        }

                        if (userId != '1010' || password != '1') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User ID or Password is incorrect'),
                            ),
                          );
                          return;
                        }

                        final service = OrderService();
                        final isLoginSuccess = await service.checkDeliveryLogin(
                          userId: userId,
                          password: password,
                          languageNo: int.parse(languageNo),
                        );

                        if (isLoginSuccess) {
                          context.read<OrderCubit>().fetchOrders();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => OrderEmpty()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials from API!'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff004F62),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset("assets/images/delivery@2x.png", height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
