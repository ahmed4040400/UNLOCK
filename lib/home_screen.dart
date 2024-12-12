import 'package:flutter/material.dart';
import 'package:unlock/camera/CameraView.dart';
import 'package:unlock/components/hover_button.dart';
import 'esp_utils.dart' as esp_utils;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CameraView(),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 800,
              height: 800,
              child: Stack(
                children: [
                  buildHoverButton(
                    icon: Icons.arrow_upward,
                    onHover: () => esp_utils.sendDataToESP("forward"),
                    alignment: Alignment.topCenter,
                  ),
                  buildHoverButton(
                    icon: Icons.arrow_downward,
                    onHover: () => esp_utils.sendDataToESP("back"),
                    alignment: Alignment.bottomCenter,
                  ),
                  buildHoverButton(
                    icon: Icons.arrow_back,
                    onHover: () => esp_utils.sendDataToESP("left"),
                    alignment: Alignment.centerLeft,
                  ),
                  buildHoverButton(
                    icon: Icons.arrow_forward,
                    onHover: () {
                      esp_utils.sendDataToESP("right");
                    },
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Hero(
              tag: 'logo',
              child: Image.asset('assets/logo.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildHoverButton({
    required IconData icon,
    required VoidCallback onHover,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: HoverButton(
        icon: icon,
        onHover: onHover,
      ),
    );
  }
}
