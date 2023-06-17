import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/myMarkers.dart';
import '../Services/marketApi.dart';
import 'package:latlong2/latlong.dart';

import 'favoritesScreen.dart';
import 'package:geolocator/geolocator.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  Position? _position;
  List<ChargePoint> _chargePoints = [];
  @override
  void initState() {
    super.initState();
    _loadChargePoints();
    _getCurrentLocation();
  }
  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
      _mapController.move(
        LatLng(position.latitude, position.longitude),
        13.0,
      );
    });
  }

  void _loadChargePoints() async {
    List<ChargePoint> chargePoints = await fetchChargePoints();
    setState(() {
      _chargePoints = chargePoints;
    });
  }

  void _addToFavorites(ChargePoint chargePoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    favoriteIds.add(chargePoint.id);
    await prefs.setStringList('favoriteIds', favoriteIds);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${chargePoint.charge_box_id} added to favorites'),
      duration: Duration(seconds: 1),
    ));
  }

  void _showChargePointDetails(ChargePoint chargePoint) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chargePoint.charge_box_id, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text(chargePoint.address),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('description:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8.0),
                  Text(chargePoint.description),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _addToFavorites(chargePoint),
                    child: Text('Add to favorites'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          center: LatLng(43.2567, 76.9286),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _chargePoints.map((cp) => Marker(
              point: LatLng(cp.location_latitude, cp.location_longitude),
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => _showChargePointDetails(cp),
                  child: Icon(Icons.ev_station),
                );
              },
            )).toList(),
          ),
          if(_position != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_position!.latitude, _position!.longitude),
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_on),
                  ),

                ),
              ],
            )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Get Current Location',
        child: Icon(Icons.my_location),
      ),
    );
  }
}
