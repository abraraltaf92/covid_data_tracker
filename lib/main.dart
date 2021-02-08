import 'package:covid_data_tracker/app/repositories/data_repository.dart';
import 'package:covid_data_tracker/app/services/api.dart';
import 'package:covid_data_tracker/app/services/api_service.dart';
import 'package:covid_data_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  Intl.defaultLocale = 'en_IN';
  runApp(MyApp());
  await initializeDateFormatting();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(api: API.sandbox()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'covid_data_tracker',
        theme: ThemeData.dark().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            cardColor: Color(0xFF222222)),
        home: DashBoard(),
      ),
    );
  }
}
