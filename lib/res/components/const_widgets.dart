import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:loading_animation_widget/src/build_loading_animation.dart';

class ConstWidgets {
  ConstWidgets._();

  static Widget waitingScreen() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.black,
            size: 80,
          ),
        ],
      ),
    );
  }

  static Widget errorScreen(String errorMessage) {
    return Material(
      color: Colors.red[300],
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
