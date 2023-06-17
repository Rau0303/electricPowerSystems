import 'dart:convert';

import '../Models/myMarkers.dart';
import 'package:http/http.dart' as http;

Future<List<ChargePoint>> fetchChargePoints() async {
  final response = await http.get(Uri.parse('https://qazcharge.kz/api/v1/chargepointslist/?format=json'));

  if (response.statusCode == 200) {
    List<ChargePoint> chargePoints = [];
    List<dynamic> jsonList = jsonDecode(response.body);

    jsonList.forEach((json) {
      chargePoints.add(ChargePoint.fromJson(json));
    });

    return chargePoints;
  } else {
    throw Exception('Failed to load charge points');
    print('Failed to load charge points');
  }
}
