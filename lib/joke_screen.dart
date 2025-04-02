import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String _joke = 'Press the button to get a joke';
  final DioClient _dioClient = GetIt.instance<DioClient>();

  void _fetchJoke() async {
    final result = await _dioClient.getJoke();
    setState(() {
      _joke = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Joke Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_joke),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchJoke,
              child: Text('Get Joke'),
            ),
          ],
        ),
      ),
    );
  }
}