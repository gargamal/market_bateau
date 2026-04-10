import 'package:flutter/material.dart';
import 'package:select_bateau/core/data/formatter/currency_formatter.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class DetailShip {
  void show(BuildContext context, Ship ship, String powerFormatted) {
    final controller = MapController(
      initPosition: GeoPoint(
        latitude: ship.lat,
        longitude: ship.lng,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          title: Center(
            child: Text(
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 22),
              ship.name,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price : ${ship.price.toCurrency()}"),
                      Text("Power : $powerFormatted"),
                      Text("Autonomy : ${ship.nbHourOfAutonomy} hours"),
                      Text("Max capacity : ${ship.nbPeopleMax} people"),
                      const SizedBox(height: 10),
                      Text("Market place : ${ship.marketPlace}"),
                    ]
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: OSMFlutter(
                      controller: controller,
                      osmOption: OSMOption(
                          zoomOption: const ZoomOption(
                            initZoom: 12,
                          ),
                          staticPoints: [
                            StaticPositionGeoPoint(
                              ship.name, // ID unique
                              const MarkerIcon(
                                icon: Icon(Icons.location_on, color: Colors.red, size: 48),
                              ),
                              [GeoPoint(latitude: ship.lat, longitude: ship.lng)],
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    const Text("close", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18))
                  ]
              ),
              onPressed: () => Navigator.of(context).pop()
            )
          ],
        );
      },
    );
  }
}