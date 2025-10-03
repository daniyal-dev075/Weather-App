import 'package:flutter/material.dart';

class ScrollEffectViewModel extends ChangeNotifier {
  double _blurAmount = 0.0;
  double _overlayOpacity = 0.05;

  double get blurAmount => _blurAmount;
  double get overlayOpacity => _overlayOpacity;

  void updateOffset(double offset) {
    // Calculate new blur and opacity
    final newBlur = (offset / 200).clamp(0, 15).toDouble();
    final newOpacity = (0.05 + offset / 800).clamp(0.05, 0.3).toDouble();

    // Only notify if values actually changed
    if (newBlur != _blurAmount || newOpacity != _overlayOpacity) {
      _blurAmount = newBlur;
      _overlayOpacity = newOpacity;
      notifyListeners();
    }
  }
}
