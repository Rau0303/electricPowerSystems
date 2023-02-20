import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mymap extends StatefulWidget {
  const Mymap({
    Key? key,
  }) : super(key: key);

  @override
  State<Mymap> createState() => _MymapState();
}

class _MymapState extends State<Mymap> {
  double currentZoom = 10;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(43.2567, 76.9286),
            zoom: currentZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(onPressed: (){
                      setState(() {
                        currentZoom++;
                      });
                    },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 10,),
                    FloatingActionButton(onPressed: (){
                      setState(() {
                        currentZoom--;
                      });
                    },
                    child: Icon(Icons.remove),
                    )
                  ],
                ),
              ],
            )
          ],
          
        ),
        
      ),
      
    );
  }
}