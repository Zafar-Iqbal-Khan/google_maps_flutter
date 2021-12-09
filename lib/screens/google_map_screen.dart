import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // final List<LatLng> _lats = [
  //   const LatLng(28.7041, 77.1025),
  //   const LatLng(28.6304, 77.2177),
  //   const LatLng(28.5355, 77.3910),
  //   const LatLng(28.4089, 77.3178),
  // ];

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(
            title: 'Connaught place',
            snippet: '28.6304, 77.2177',
          ),
          markerId: MarkerId('id-1'),
          position: const LatLng(28.6304, 77.2177),
        ),
      );
      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow:
              const InfoWindow(title: 'Noida', snippet: '28.5355, 77.3910'),
          markerId: MarkerId('id-2'),
          position: const LatLng(28.5355, 77.3910),
        ),
      );

      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow:
              const InfoWindow(title: 'Farid Abad', snippet: '28.4089,77.3178'),
          markerId: MarkerId('id-3'),
          position: const LatLng(28.4089, 77.3178),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: const CameraPosition(
          target: LatLng(28.7041, 77.1025),
          zoom: 10,
        ),
        // mapType: MapType.hybrid,
        onTap: _handleTap,
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    String lat = tappedPoint.latitude.toString();
    String lon = tappedPoint.longitude.toString();
    setState(() {
      _markers = {};

      _markers.add(
        Marker(
          infoWindow: InfoWindow(
            title: 'Lat: ${lat.substring(0, 6)} - Lon: ${lon.substring(0, 6)}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta),
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
        ),
      );
    });
  }
}
