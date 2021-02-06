import 'package:covid_data_tracker/services/api.dart';
import 'package:covid_data_tracker/services/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'covid_data_tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Covid Data Tracker',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';

  void _updateAccessToken() async {
    final apiService = APIService(api: API.sandbox());
    final accessToken = await apiService.getAcessToken();
    setState(() {
      _accessToken = accessToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'covid_data : $_accessToken',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.bold, fontSize: 45),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: TextButton.styleFrom(
            shadowColor: Colors.white54,
            backgroundColor: Colors.white,
            elevation: 10),
        onPressed: () => _updateAccessToken(),
        child: Icon(
          Icons.face,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
