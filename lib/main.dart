import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NetworkPage(),
    );
  }
}

class NetworkPage extends StatefulWidget {
  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  String _fact = 'Press the button to get a fact';
  final DioClient _dioClient = GetIt.instance<DioClient>();

  void _fetchData() async {
    final result = await _dioClient.getFact();
    setState(() {
      _fact = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_fact),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: Text('Get Fact'),
            ),
          ],
        ),
      ),
    );
  }
}