import 'package:covid_data_tracker/app/repositories/data_repository.dart';
import 'package:covid_data_tracker/app/repositories/endpoints_data.dart';
import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/ui/endpointData_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

EndpointsData _endpointsData;

class _DashBoardState extends State<DashBoard> {
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
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
        color: Colors.black,
        backgroundColor: Colors.white54,
        child: ListView(
          children: <Widget>[
            for (var endpoint in Endpoint.values)
              EndpointDataCard(
                // initally _endpointsData does not have any value
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]
                    : null,
                endpoint: endpoint,
              ),
          ],
        ),
      ),
    );
  }
}
