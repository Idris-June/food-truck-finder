import 'dart:async';

class Debouncer {
  final int delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delay), action);
  }
}