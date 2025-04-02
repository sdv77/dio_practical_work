import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';

class FactScreen extends StatefulWidget {
  @override
  _FactScreenState createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
  String _fact = 'Press the button to get a fact';
  final DioClient _dioClient = GetIt.instance<DioClient>();

  void _fetchFact() async {
    final result = await _dioClient.getFact();
    setState(() {
      _fact = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fact Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_fact),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchFact,
              child: Text('Get Fact'),
            ),
          ],
        ),
      ),
    );
  }
}