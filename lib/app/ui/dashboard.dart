import 'package:covid_data_tracker/app/repositories/data_repository.dart';
import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/ui/endpointData_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

int _cases;

class _DashBoardState extends State<DashBoard> {
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    setState(() {
      _cases = cases;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Data Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            EndpointDataCard(
              value: _cases,
              endpoint: Endpoint.cases,
            ),
          ],
        ),
      ),
    );
  }
}
