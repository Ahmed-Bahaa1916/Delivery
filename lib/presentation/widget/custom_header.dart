import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constant.dart';
import '../screens/language.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          // خلفية حمراء
          Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(45)),
            ),
          ),

          // الجزء الأزرق
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 160,
              width: 140,
              decoration: const BoxDecoration(
                color: Color(0xff004F62),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  topLeft: Radius.circular(8),
                ),
              ),
            ),
          ),

          // الاسم
          Positioned(
            top: 60,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Othman",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // الأيقونة بخلفية دائرية
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15))],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LanguageScreen()),
                  );
                },
                child: Icon(Icons.language, color: AppThem.primary),
              ),
            ),
          ),

          // صورة الدليفري
          Positioned(
            bottom: 0,
            right: 75,
            child: Image.asset(
              "assets/images/deliveryman@3x.png", // حط الصورة بتاعتك هنا
              height: 130,
            ),
          ),
        ],
      ),
    );
  }
}
