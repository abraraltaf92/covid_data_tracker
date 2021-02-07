import 'package:covid_data_tracker/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  Map<Endpoint, int> values;
  EndpointsData({@required this.values});
  // getter makes Endpoints Data easier to query
  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get casesConfirmed => values[Endpoint.casesConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  // toString method to print debugging info

  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
