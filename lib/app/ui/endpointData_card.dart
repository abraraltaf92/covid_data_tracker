import 'package:covid_data_tracker/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointDataCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  const EndpointDataCard(
      {Key key, @required this.endpoint, @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cases',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
