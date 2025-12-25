import 'dart:async';
import 'dart:isolate';
import 'audio_service.dart';

class AudioStreamer {
  late Isolate _isolate;
  late SendPort _sendPort;
  final StreamController<String> _statusController = StreamController.broadcast();

  Stream<String> get statusStream => _statusController.stream;

  Future<void> start(AudioService service) async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_entry, receivePort.sendPort);
    _sendPort = await receivePort.first as SendPort;
    _sendPort.send(service);
  }

  void sendPCM(List<int> left, List<int> right) {
    _sendPort.send({'left': left, 'right': right});
  }

  void stop() {
    _sendPort.send(null);
    _isolate.kill(priority: Isolate.immediate);
  }

  static void _entry(SendPort mainSendPort) {
    final receivePort = ReceivePort();
    mainSendPort.send(receivePort.sendPort);

    AudioService? service;

    receivePort.listen((message) {
      if (message == null) {
        receivePort.close();
        return;
      }
      if (message is AudioService) {
        service = message;
        return;
      }
      if (service != null && message is Map) {
        final left = message['left'] as List<int>;
        final right = message['right'] as List<int>;
        try {
          final sent = service!.encodeAndSend(left, right);
          mainSendPort.send('Sent $sent bytes');
        } catch (e) {
          mainSendPort.send('Error: $e');
        }
      }
    });
  }
}
