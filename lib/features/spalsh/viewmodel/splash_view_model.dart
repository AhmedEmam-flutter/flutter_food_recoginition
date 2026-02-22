import 'dart:async';
import 'package:flutter/foundation.dart';

class SplashViewModel extends ChangeNotifier {
  bool _goNext = false;
  bool get goNext => _goNext;

  Timer? _timer;

  void init() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      _goNext = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
