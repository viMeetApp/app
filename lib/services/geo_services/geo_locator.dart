import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_app/services/geo_services/classes.dart';
import 'package:signup_app/services/geo_services/postal_place_repository.dart';
import 'package:signup_app/services/helpers/proximity_hash.dart';
import 'package:signup_app/util/presets/errors.dart';

/// Class to handle all Location Handling is instantiated as a Singelton
class GeoLocator {
  // Singeton Instantiation
  static final GeoLocator _geoService = GeoLocator._privateConstructor();

  factory GeoLocator() {
    return _geoService;
  }
  late final SharedPreferences _prefs;

  final Location _location = new Location();
  final PostalPlaceRepository _postalPlaceRepository =
      new PostalPlaceRepository();

  GeoLocator._privateConstructor();

  /// Needs to be called before using the GeoLocator. Instantiates class by connecting to SHaredPreferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    _useDeviceLocation = _prefs.getBool('useDeviceLocation') ?? false;
    String? lastLocation = _prefs.getString('lastLocation');
    // Starts with Last values for Location if no last values use defaul Location
    if (lastLocation != null) {
      _currentLocation = PostalPlace.fromRawJson(lastLocation);
    } else {
      _currentLocation = PostalPlace.outside();
    }
  }

  bool _useDeviceLocation =
      false; //Whether to use the Location of the device (true) or manually select Location
  PostalPlace? _currentLocation;
  final List<Function> _currentPlaceListeners = <Function>[];

  /// Returs currentLocation
  ///
  /// Internally checks for [_useDeviceLocation] depending on values returns lastLocation or "real" Location
  Future<PostalPlace> getCurrentLocation() async {
    if (_useDeviceLocation == true) {
      try {
        PostalPlace currLocation = await _getDeviceLocation();

        print(currLocation.lat);

        // If new Location has been fetched update old Location
        if (_currentLocation != currLocation) {
          _setCurrentLocation(currLocation);
        }
        return currLocation;
      } catch (err) {
        return _getLastLocation();
      }
    } else {
      return _getLastLocation();
    }
  }

  /// Function should be calles if User decides to use Device Location
  ///
  /// This function sets variables to use DEvice Location, it also returns current device Location
  Future<PostalPlace> changeToDeviceLocationAndGetLocation() async {
    _useDeviceLocation = true;
    _prefs.setBool('useDeviceLocation', true);
    return await getCurrentLocation();
  }

  /// Returns real device Location by using the Location plugin
  Future<PostalPlace> _getDeviceLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return Future.error(ViServiceLocationException());
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error(ViPermissionLocationException());
      }
    }

    LocationData currLocation = await _location.getLocation();
    print(currLocation.toString());
    return _convertLocationDataToPostalPlace(currLocation);
  }

  /// Converts a Location of typle LocationData to a PostalPlace
  Future<PostalPlace> _convertLocationDataToPostalPlace(
      LocationData location) async {
    //If new Location is same as old Location one can spare a conversion and use old PostalPlace
    if (_currentLocation != null &&
        _currentLocation!.equalsLocationData(location)) {
      print("equals");
      return _currentLocation!;
    }
    // Otherwise convert location to new PostalPlace
    else {
      //ToDo Bringe echte Logik in diese Funktion
      return _postalPlaceRepository.convertLocationToPostalPlace(location);
    }
  }

  /// Returns las Location of device. This function is used when [_useDeviceLocation] == false
  PostalPlace _getLastLocation() {
    if (_currentLocation != null) {
      return _currentLocation!;
    } else {
      // Default Location if nothing provided
      return PostalPlace.outside();
    }
  }

  /// If user sets Location by hand new Location is saved and mode changes to ['useDeviceLocation] == false
  void manuallySetLocation(PostalPlace location) {
    _useDeviceLocation = false;
    _prefs.setBool('useDeviceLocation', false);
    _setCurrentLocation(location);
  }

  /// Sets [_currentLocation] and notifys all Listeners. Also saves location in SharedPreferences
  void _setCurrentLocation(PostalPlace location) {
    _prefs.setString('lastLocation', location.toJsonString());
    _currentLocation = location;
    _executeCurrentPlaceListeners();
  }

  /// Returns current Geohash
  ///
  /// Internally this function is using getCurrentLocation()
  Future<String> getCurrentGeohash() async {
    PostalPlace position = await getCurrentLocation();
    String geohash = Geoflutterfire()
        .point(latitude: position.lat, longitude: position.long)
        .hash;
    return geohash.substring(0, 5); // return a geohash with limited accuracy
  }

  /// Returns the geohash Range for the currentLocation one can optionally specify a radius or use default Values
  GeohashRange getGeohashRange({double radius = 200000}) {
    if (_currentLocation == null) {
      return GeohashRange.empty();
    }
    List<String> range = createGeohashes(
        _currentLocation?.lat ?? 0, _currentLocation?.long ?? 0, radius, 3);
    if (range.length < 2) {
      if (range.length == 1) {
        return GeohashRange(lower: range[0], upper: range[0]);
      }
      throw ViException("RangeError in GeoHashRange: " + range.toString());
    }
    print(range.toString());
    return GeohashRange(lower: range[1], upper: range[0]);
  }

  addCurrentPlaceListener(Function function) {
    _currentPlaceListeners.add(function);
  }

  _executeCurrentPlaceListeners() {
    for (Function funct in _currentPlaceListeners) {
      funct(_currentLocation);
    }
  }
}
