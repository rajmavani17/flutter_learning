import 'dart:async';

class EventBus {
  static final EventBus _instance = EventBus._internal();

  factory EventBus() {
    return _instance;
  }

  EventBus._internal();

  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  void emit(String event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}

// Global instance
final eventBus = EventBus();
