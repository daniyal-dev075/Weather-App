import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

Widget buildLoadingUI() {
  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "images/sunny_bg.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
        const Center(child: Loader()),
      ],
    ),
  );
}