import 'package:covid_data_tracker/app/repositories/endpoints_data.dart';
import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:covid_data_tracker/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;

  DataRepository({@required this.apiService});

  String _accessToken;
  Future<EndpointData> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
          onGetData: () => getEndpointData(endpoint));

  Future<EndpointsData> getAllEndpointsData() async =>
      await _getDataRefreshingToken<EndpointsData>(
          onGetData: _getAllEndPointsData);

  //Generic function used
  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAcessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      //if unauthorized , gets access Token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAcessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndPointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
