import 'package:covid_data_tracker/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCardData {
  EndpointCardData({this.title, this.assetName, this.color});
  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;
  static Map<Endpoint, EndpointCardData> _cardTitles = {
    Endpoint.cases: EndpointCardData(
        title: 'Cases',
        assetName: 'assets/count.png',
        color: Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData(
        title: 'Suspected Cases',
        assetName: 'assets/suspect.png',
        color: Color(0xFFEEDA28)),
    Endpoint.casesConfirmed: EndpointCardData(
        title: 'Confirmed Cases',
        assetName: 'assets/fever.png',
        color: Color(0xFFE99600)),
    Endpoint.deaths: EndpointCardData(
        title: 'Deaths',
        assetName: 'assets/death.png',
        color: Color(0xFFE40000)),
    Endpoint.recovered: EndpointCardData(
        title: 'Recovered',
        assetName: 'assets/patient.png',
        color: Color(0xFF70A901)),
  };

  const EndpointCard({Key key, @required this.endpoint, @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cardData = _cardTitles[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      value != null ? value.toString() : '',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
