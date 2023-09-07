import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:location/location.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// import '../models/driver_model.dart';

class WebSocketService {
  //final
  WebSocketChannel? _channel;

  // WebSocketService(this.token);

  // Initialize the WebSocket connection
  void initWebSocket(String token) {
    try {
      log('$token');
      _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://216.250.9.245:81/ws/location/?token=$token'),
        pingInterval: Duration(seconds: 5),
      );
      _channel!.stream.listen((js) {
        log('$js');
        final Map map = jsonDecode(js);

        if (map['type'] == 'order') {
          //!TO DO implement logic
        }
      });

      log('${_channel!.ready} ready');
    } catch (e) {
      log('$e');
    }

    //IOWebSocketChannel.connect('ws://216.250.9.245:81/ws/location/?Token=$token');
  }

  // Send a message over the WebSocket
  void sendMessage(LocationData message) {
    if (_channel != null) {
      print('send');
      log('{$message}');
      _channel!.sink.add(json.encode({
        'type': 'update',
        'data': {
          'location': {
            'latitude': '${message.latitude}',
            'longitude': '${message.longitude}'
          }
        }
      }));
    } else {
      log('nullasd');
    }
  }

  // Listen for incoming messages
  Stream<dynamic> get messages {
    if (_channel != null) {
      return _channel!.stream;
    } else {
      throw Exception('WebSocket channel not initialized.');
    }
  }

  // Close the WebSocket connection
  void closeWebSocket() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }
}
