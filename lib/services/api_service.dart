import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid_data_tracker/services/api.dart';

class APIService {
  final API api;
  APIService({this.api});

  Future<String> getAcessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        "Request ${api.tokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}");
    throw response;
  }
}
