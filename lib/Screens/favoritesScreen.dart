import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/myMarkers.dart';
import '../Services/marketApi.dart';
import '../Widgets/myAppBar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ChargePoint> _favoriteChargePoints = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteChargePoints();
  }

  void _loadFavoriteChargePoints() async {
    List<ChargePoint> chargePoints = await fetchChargePoints();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];

    setState(() {
      _favoriteChargePoints = chargePoints.where((cp) => favoriteIds.contains(cp.id)).toList();
    });
  }

  void _removeFromFavorites(ChargePoint chargePoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    favoriteIds.remove(chargePoint.id);
    await prefs.setStringList('favoriteIds', favoriteIds);

    setState(() {
      _favoriteChargePoints.remove(chargePoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: myAppBar(myTitleText: const Text("Избранное"),arrow_back: false,)),
      body: ListView.builder(
        itemCount: _favoriteChargePoints.length,
        itemBuilder: (BuildContext context, int index) {
          ChargePoint chargePoint = _favoriteChargePoints[index];
          return ListTile(
            title: Text(chargePoint.charge_box_id),
            subtitle: Text(chargePoint.description),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeFromFavorites(chargePoint),
            ),
          );
        },
      ),
    );
  }
}
