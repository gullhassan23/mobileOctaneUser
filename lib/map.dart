import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_octane/Controller/addfuelController.dart';

import '../../../constant/icons.dart';
import 'Widgets/Buttons.dart';
import 'Widgets/appBar_title.dart';
import 'Widgets/app_bar_leadingImage.dart';
import 'Widgets/custom_app_bar.dart';
import 'Widgets/custom_search_view.dart';
import 'views/Constrants/Colors.dart';
import 'views/Constrants/Font.dart';
import 'views/FillUpScreen/fill_up_screen.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String address = '';
  final Completer<GoogleMapController> _controller = Completer();
  // late LatLng _initialPosition = LatLng(0.0, 0.0);
  LatLng? currentLocation;
  // final TextEditingController _addFuelController.searchController = TextEditingController();
  // List<Map<String, dynamic>> _addFuelController.placesData = [];
  AddFuelController _addFuelController = Get.find<AddFuelController>();

  Future<void> searchPlaces(String input) async {
    String apiKey =
        'AIzaSyDmWpvoFV6kqRFA0UbI6qWnEncFO6E8HjM'; // Replace with your Google Places API key
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/textsearch/json';
    String query = Uri.encodeQueryComponent(input);
    String url = '$baseUrl?query=$query&key=$apiKey';
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> results = data['results'];
        List<Map<String, dynamic>> placesDataa = [];
        print("resultss ${results.toList()}");
        for (var result in results) {
          Map<String, dynamic> placeData = {
            'placeName': result['name'],
            'address': result['formatted_address'],
            'latitude': result['geometry']['location']['lat'],
            'longitude': result['geometry']['location']['lng'],
          };
          placesDataa.add(placeData);
          print(placeData);
        }
        setState(() {
          _addFuelController.placesData.value = placesDataa;
        });
      } else {
        print('Failed to fetch places: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  List<Marker> list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'some Info ')),
  ];
  bool onCameraIdlecheck = false;
  @override
  void initState() {
    getCurrentPosition();

    super.initState();
  }

  getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getUserCurrentLocation().then((value) async {
      final GoogleMapController controller = await _controller.future;
      currentLocation = LatLng(value.latitude, value.longitude);
      _markers.add(Marker(
        markerId: MarkerId("current location"),
        position: LatLng(value.latitude, value.longitude),
      ));
      CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

      List<Placemark> placemarks = await placemarkFromCoordinates(
        value.latitude,
        value.longitude,
      );

      Placemark place = placemarks.first;

      _addFuelController.searchController.text =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

        _addFuelController.locationdetail.address =
            _addFuelController.searchController.text;
        _addFuelController.locationdetail.lat = value.latitude;
        _addFuelController.locationdetail.lng = value.longitude;
        _addFuelController.locationdetail.city = place.locality.toString();
        _addFuelController.locationdetail.country = place.country.toString();

      setState(() {});
    });

    if (mounted) setState(() {});
  }

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  Uint8List? markerImage;
  final List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(color: AppColors.burColor),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(height: 15.h),
                CustomAppBar(
                    height: 20.h,
                    leadingWidth: 44.w,
                    leading: AppbarLeadingImage(
                        imagePath: "assets/img_mask_group_24x24.png",
                        margin:
                            EdgeInsets.only(left: 20.w, top: 2.h, bottom: 1.h),
                        onTap: () {
                          Navigator.pop(context);
                          // onTapImage();
                        }),
                    centerTitle: true,
                    title: AppbarTitle(text: "Add Location")),
                SizedBox(height: 18.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: CustomSearchView(
                        hintStyle: GoogleFonts.nunito(
                            fontSize: 13.sp, color: Colors.white),
                        autofocus: false,
                        textStyle: GoogleFonts.nunito(
                            fontSize: 13.sp, color: Colors.white),
                        onChanged: (val) {
                          if (val.length > 3) {
                            searchPlaces(val);
                          }
                        },
                        controller: _addFuelController.searchController,
                        hintText: "Search Location"))
              ])),
          Obx(
            () => _addFuelController.placesData.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _addFuelController.placesData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            print("${_addFuelController.placesData[index]}");
                            _addFuelController.searchController.text =
                                _addFuelController.placesData[index]
                                        ['address'] +
                                    _addFuelController.placesData[index]
                                        ['placeName'];
                            print(
                                "${_addFuelController.searchController.text}");

                            double latitude = _addFuelController
                                .placesData[index]['latitude'];
                            double longitude = _addFuelController
                                .placesData[index]['longitude'];

                            _addFuelController.placesData.clear();
                            setState(() {});
                            _markers.clear();
                            _markers.add(Marker(
                              markerId: MarkerId("selected location"),
                              position: LatLng(latitude, longitude),
                            ));
                            // // Move the camera to the selected location
                            final GoogleMapController controller =
                                await _controller.future;

                            controller.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(latitude, longitude),
                              ),
                            );
                            _addFuelController.locationdetail.address =
                                _addFuelController.searchController.text;
                            _addFuelController.locationdetail.lat = latitude;
                            _addFuelController.locationdetail.lng = longitude;
                            _addFuelController.locationdetail.city =
                                _addFuelController.placesData[index]['city'];
                            _addFuelController.locationdetail.country =
                                _addFuelController.placesData[index]['country'];

                            print(
                                "_addFuelController.locationdetail0  = ${_addFuelController.locationdetail.toMap()}");
                            // setState(() {});
                            // setState(() {});
                          },
                          title: Text(
                              "${_addFuelController.placesData[index]['address']}"),
                        );
                      },
                    ),
                  )
                : Container(),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng latLng) {},
              // onCameraMove: (CameraPosition position) {
              //   currentLocation = position.target;
              //   print("camera move");
              //   _markers.clear();
              //   _markers.add(Marker(
              //     markerId: MarkerId("current location"),
              //     position: LatLng(
              //         position.target.latitude, position.target.longitude),
              //   ));
              //   setState(() {});
              // },
              // onCameraIdle: () async {
              //   onCameraIdlecheck = true;
              //   await _getAddressFromLatLng(
              //     currentLocation!.latitude,
              //     currentLocation!.longitude,
              //   );
              //   onCameraIdlecheck = false;

              //   setState(() {});
              // },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomElevatedButton(
          text: "NEXT".toUpperCase(),
          margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 40.h),
          onPressed: () {
            // onTapNextButton();
            print("loaction  = ${_addFuelController.locationdetail}");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => fill_up_screen()));
          }),
    );
  }

  Future<void> _getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks.first;
      String formattedAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      setState(() {
        _addFuelController.searchController.text = formattedAddress;
        _addFuelController.locationdetail.address =
            _addFuelController.searchController.text;
        _addFuelController.locationdetail.lat = latitude;
        _addFuelController.locationdetail.lng = longitude;
        _addFuelController.locationdetail.city = place.locality.toString();
        _addFuelController.locationdetail.country = place.country.toString();

        print(
            "_addFuelController.locationdetail 1 = ${_addFuelController.locationdetail.toMap()}");
      });
    } catch (e) {
      print(e);
    }
  }
}
