import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';

//import 'package:flutter_audio_streamer/flutter_audio_streamer.dart';

void main() {
// final shout = Shout();
// // Configure connection
// shout.host = '167.71.141.252';
// shout.port = 8000;
// shout.user = 'source';
// shout.password = 'moses@do';
// shout.mount = '/koinonia-global';
// shout.protocol = ShoutProtocol.HTTP;
// shout.format = ShoutFormat.MP3;
// Connect
try {
  //shout.connect();
  print('Connected!');
} catch (e) {
  print('Error: $e');
}
print('Connected!');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late int sumResult;
  // late Future<int> sumAsyncResult;
  
  @override
  void initState() {
    print("hello");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  'sum(1, 2)',
                  style: textStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
