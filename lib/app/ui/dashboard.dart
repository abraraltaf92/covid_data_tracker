import 'dart:io';

import 'package:covid_data_tracker/app/repositories/data_repository.dart';
import 'package:covid_data_tracker/app/repositories/endpoints_data.dart';
import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/ui/endpointData_card.dart';
import 'package:covid_data_tracker/app/ui/last_updated_status_text.dart';
import 'package:covid_data_tracker/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

EndpointsData _endpointsData;

class _DashBoardState extends State<DashBoard> {
  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Could not retrieve data. Please try again later.',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unknown Error',
          content: 'Please contact support or try again later.',
          defaultActionText: 'OK');
    }
  }

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEnpointsCachedData();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );
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
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                // initally _endpointsData does not have any value
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
                endpoint: endpoint,
              ),
          ],
        ),
      ),
    );
  }
}
