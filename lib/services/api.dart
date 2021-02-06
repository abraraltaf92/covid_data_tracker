import 'package:covid_data_tracker/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  String apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKEYS.ncovSandboxKey);
  factory API.profuctionBox() => API(apiKey: APIKEYS.ncovProductionKey);

  static final host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(scheme: 'https', host: host, path: 'token');
}
