import 'package:admin_vendor/controller/get_user_data_model.dart';
import 'package:admin_vendor/main_screen.dart';
import 'package:admin_vendor/model/get_user_data_model.dart';
import 'package:admin_vendor/services/session_data.dart';
import 'package:admin_vendor/view/auth/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await SessionData.getSessionData();
        Get.put(GetUserDataController());
        final GetUserDataController find = Get.find();
        final FirebaseFirestore fireStore = FirebaseFirestore.instance;

        if (SessionData.isLogin!) {
          await SessionData.getUid();

          DocumentSnapshot<Map<String, dynamic>> data =
              await fireStore.collection('Vendor').doc(SessionData.uid).get();

          find.userData = GetUserDataModel(data.data()!);

          Get.offAll(() => const MainScreen());
        } else {
          // ignore: use_build_context_synchronously
          Get.offAll(() => SignInScreen());
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/animation/vendor1.json',
              controller: _controller,
              fit: BoxFit.cover,
              onLoaded: (composition) {
                _controller.forward();
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome \nto the\nSaloon Vendor App',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Powered by',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Prakrut Systems',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
