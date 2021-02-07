import 'package:covid_data_tracker/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:covid_data_tracker/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;

  DataRepository({@required this.apiService});

  String _accessToken;
  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAcessToken();
      }
      return await apiService.getEndpointData(
          accessToken: _accessToken, endpoint: endpoint);
    } on Response catch (response) {
      //if unauthorized , gets access Token again
      if (response.statusCode == 401) {
        final _accessToken = await apiService.getAcessToken();
        return await apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
  }
}
