import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:unlock/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                  child: Center(
                child: MirrorAnimationBuilder<double>(
                  tween: Tween(begin: 0.84, end: 0.8), // Scaling factor range
                  duration: const Duration(seconds: 3), // Animation duration
                  curve: Curves.easeInOut, // Smooth scaling effect
                  builder: (context, scaleValue, _) {
                    return MirrorAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 15.0), // Floating range
                      duration:
                          const Duration(seconds: 3), // Animation duration
                      curve: Curves.easeInOut, // Smooth floating effect
                      builder: (context, floatValue, _) {
                        return Transform.translate(
                          offset: Offset(0, floatValue), // Float up and down
                          child: Transform.scale(
                            scale: scaleValue, // Scale up and down
                            child: Hero(
                              child: Image.asset('assets/logo.png'),
                              tag: 'logo',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )));
        });
  }
}
