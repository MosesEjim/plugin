import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';
import 'package:flutter_audio_streamer/flutter_audio_streamer.dart';
// import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool streaming = false;

  @override
  void initState() {
    super.initState();
    debugPrint('App initialized');
  }

  Future<void> streamMp3FromUrl() async {
    //if (streaming) return;
     setState(() {
      streaming = true;
    });
    final shout = new Shout(); 
     setState(() {
      streaming = false;
    });
    shout.host = '167.71.141.252'; 
    shout.port = 8000; 
    shout.user = 'source'; 
    shout.password = 'moses@do'; 
    shout.mount = 'ec33c093-dca1-49be-a830-020ed715a071'; 
    shout.protocol = ShoutProtocol.HTTP; 
    shout.format = ShoutFormat.MP3;
    shout.connect();
    setState(() {
      streaming = true;
    });

    const url =
        'https://drive.google.com/file/d/1wbXzAPAxl5phQWeGIQbgwhQFhvnIEKxs/view?usp=sharing';

    debugPrint('Connecting to MP3 source...');

    // final request = http.Request('GET', Uri.parse(url));
    // final response = await request.send();

    // if (response.statusCode != 200) {
    //   debugPrint('HTTP error ${response.statusCode}');
    //   return;
    // }

    debugPrint('Streaming started');

    // await for (final List<int> chunk in response.stream) {
    //   // 👇 THIS is where you send data to libshout
    //   shout.send(chunk);

    //   debugPrint('Sent chunk: ${chunk.length} bytes');
    // }

    debugPrint('Streaming finished');
    streaming = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FFI MP3 Stream Test')),
        body: Center(
           child: Column(
            mainAxisSize: MainAxisSize.min, // shrink to fit contents
            children: [
              ElevatedButton(
                onPressed: streamMp3FromUrl,
                child: const Text('Stream MP3 to Server'),
              ),
              const SizedBox(height: 10), // small spacing
              Text(streaming ? 'Streaming...' : 'Not streaming'),
            ],
          ),
          
        ),
      ),
    );
  }
}
