import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  Map<Endpoint, EndpointData> values;
  EndpointsData({@required this.values});
  // getter makes Endpoints Data easier to query
  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];

  // toString method to print debugging info

  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
