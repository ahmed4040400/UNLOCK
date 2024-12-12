import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:get/get.dart';
import 'package:unlock/esp_utils.dart';
import 'dart:async';
import 'hover_controller.dart';

class HoverButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onHover;
  final bool timerEnabled;

  HoverButton({
    required this.icon,
    required this.onHover,
    this.timerEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> with AnimationMixin {
  Timer? _timer;
  double _progress = 0.0;
  bool _isHovered = false;

  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  final HoverController hoverController = Get.put(HoverController());

  @override
  void initState() {
    super.initState();
    _controller = createController()
      ..duration = const Duration(milliseconds: 300);
    _sizeAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(_controller);
  }

  void _startHoverTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _progress += 1.0;
        if (_progress >= 100.0 && widget.timerEnabled) {
          _progress = 100.0;
          _timer?.cancel();
          widget.onHover();
          hoverController.addHovered();
        } else if (hoverController.hoveredButtons.length > 1) {
          _progress = 100.0;
          _timer?.cancel();
          widget.onHover();
        }
      });
    });
  }

  void _cancelHoverTimer() {
    _timer?.cancel();
    setState(() {
      _progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        if (hoverController.hoveredButtons.length > 0) {
          hoverController.addHovered();
        }
        hoverController.setHoverState(true);
        _controller.play();
        if (_progress >= 100.0) {
          widget.onHover();
        } else {
          _startHoverTimer();
        }
      },
      onExit: (_) {
        Future.delayed(Duration(milliseconds: 100), () {
          if (!hoverController.isAnyButtonHovered.value) {
            sendDataToESP("stop");
          }
          if (hoverController.hoveredButtons.length > 0) {
            hoverController.removeHovered();
          }
        });
        setState(() {
          _isHovered = false;
        });
        hoverController.setHoverState(false);
        _controller.reverse();
        _cancelHoverTimer();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Your onPressed code here
            },
            child: Container(
              padding: EdgeInsets.all(
                  70.0), // Increase the padding to enlarge the hover area
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _sizeAnimation.value, // Scale value from animation
                    child: Icon(
                      widget.icon,
                      color: _isHovered
                          ? Colors.blue
                          : Colors.white, // Change color on hover
                      size: 50.0, // Base size of the icon
                    ),
                  );
                },
              ),
            ),
          ),
          if (_progress > 0)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(
                  value: _progress / 100.0,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cancelHoverTimer();
    _controller.dispose();
    super.dispose();
  }
}
