import 'dart:math';

import 'dart:typed_data';

/// A list of possible directions of neighboring geohash.
enum Direction {
  NORTH,
  NORTHEAST,
  EAST,
  SOUTHEAST,
  SOUTH,
  SOUTHWEST,
  WEST,
  NORTHWEST,
  CENTRAL
}

/// A class that can convert a geohash String to [Longitude, Latitude] and back.
class GeoHasher {
  static String _baseSequence = '0123456789bcdefghjkmnpqrstuvwxyz';

  /// Creates a Map of available characters for a geohash
  Map<String, int> _base32Map =
      Map.fromIterable(_baseSequence.split(""), key: (key) {
    return key;
  }, value: (value) {
    return _baseSequence.indexOf(value);
  });

  /// Creates a reversed Map of available characters for a geohash
  Map<int, String?> _base32MapR =
      Map.fromIterable(_baseSequence.split(""), key: (key) {
    return _baseSequence.indexOf(key);
  }, value: (value) {
    return value;
  });

  /// Converts a List<int> of bits into a double for Longitude and Latitude
  double _bitsToDouble(
      {List<int> bits = const [],
      double lower = -90.0,
      double middle = 0.0,
      double upper = 90.0}) {
    bits.forEach((bit) {
      if (bit == 1) {
        lower = middle;
      } else {
        upper = middle;
      }
      middle = (upper + lower) / 2.0;
    });
    return middle;
  }

  /// Converts a double value Longitude or Latitude to a List<int> of bits
  List<int> _doubleToBits(
      {double? value,
      double lower = -90.0,
      double middle = 0.0,
      double upper = 90.0,
      int length = 15}) {
    List<int> ret = [];

    for (int i = 0; i < length; i++) {
      if ((value ?? 0) >= middle) {
        lower = middle;
        ret.add(1);
      } else {
        upper = middle;
        ret.add(0);
      }
      middle = (upper + lower) / 2;
    }

    return ret;
  }

  /// Converts a List<int> bits into a String geohash
  String _bitsToGeoHash(List<int> bitValue) {
    List<int> remainingBits = List<int>.from(bitValue);
    List<int> subBits = [];
    List<String?> geoHashList = [];

    String subBitsAsString;
    int value;
    for (int i = 0; i < bitValue.length / 5; i++) {
      subBits = remainingBits.sublist(0, 5);
      remainingBits = remainingBits.sublist(5);
      subBitsAsString = "";
      subBits.forEach((value) {
        subBitsAsString = subBitsAsString + value.toString();
      });
      value = int.parse(int.parse(subBitsAsString, radix: 2).toRadixString(10));

      geoHashList.add(_base32MapR[value]);
    }

    return geoHashList.join("");
  }

  /// Converts a String geohash into List<int> bits
  List<int> _geoHashToBits(String geohash) {
    List<int?> letterNumValue = [];
    List<int> bitList = [];
    geohash.split("").forEach((letter) {
      if (_base32Map[letter] != null) {
        letterNumValue.add(_base32Map[letter]);

        ByteBuffer buffer = Uint8List(5).buffer;
        ByteData bufferData = ByteData.view(buffer);
        bufferData.setUint32(0, _base32Map[letter] ?? 0);
        bufferData
            .getUint32(0)
            .toRadixString(2)
            .padLeft(5, "0")
            .split("")
            .forEach((letter) {
          bitList.add(int.parse(letter));
        });
      }
    });

    return bitList;
  }

  /// Encodes a given Longitude and Latitude into a String geohash
  String encode(double longitude, double latitude, {int precision = 12}) {
    bool precisionOdd = precision % 2 == 1;
    int originalPrecision = precision + 0;
    if (longitude < -180.0 || longitude > 180.0)
      throw RangeError.range(longitude, -180, 180, "Longitude");
    if (latitude < -90.0 || latitude > 90.0)
      throw RangeError.range(latitude, -180, 180, "Latitude");

    if (precision % 2 == 1) {
      precision = precision + 1;
    }
    if (precision != 1) precision ~/= 2;

    List<int> longitudeBits = _doubleToBits(
        value: longitude, lower: -180.0, upper: 180.0, length: precision * 5);
    List<int> latitudeBits = _doubleToBits(
        value: latitude, lower: -90.0, upper: 90.0, length: precision * 5);

    List<int> ret = [];
    for (int i = 0; i < longitudeBits.length; i++) {
      ret.add(longitudeBits[i]);
      ret.add(latitudeBits[i]);
    }

    String geohashString = _bitsToGeoHash(ret);

    return originalPrecision == 1
        ? geohashString.substring(0, 1)
        : (precisionOdd
            ? geohashString.substring(0, geohashString.length - 1)
            : geohashString);
  }

  /// Decodes a given String into a List<double> containing Longitude and
  /// Latitude in decimal degrees.
  List<double> decode(String geohash) {
    if (geohash == "")
      throw ArgumentError.value(geohash, "geohash");
    else if (!geohash
        .contains(new RegExp(r'^[0123456789bcdefghjkmnpqrstuvwxyz]+$')))
      throw ArgumentError("Invalid character in GeoHash");

    List<int> bits = _geoHashToBits(geohash);
    List<int> longitudeBits = [];
    List<int> latitudeBits = [];

    for (int i = 0; i < bits.length; i++) {
      if (i % 2 == 0 || i == 0) {
        longitudeBits.add(bits[i]);
      } else {
        latitudeBits.add(bits[i]);
      }
    }

    return [
      _bitsToDouble(bits: longitudeBits, lower: -180, upper: 180),
      _bitsToDouble(bits: latitudeBits)
    ];
  }

  /// Returns a String geohash of the neighbor of the given String in the given
  /// direction.
  String _adjacent({required String geohash, required String direction}) {
    assert(direction.contains(new RegExp(r'[nsewNSEW]')),
        "Invalid Direction $direction not in NSEW");

    Map<String, List> neighbor = {
      'n': [
        'p0r21436x8zb9dcf5h7kjnmqesgutwvy',
        'bc01fg45238967deuvhjyznpkmstqrwx'
      ],
      's': [
        '14365h7k9dcfesgujnmqp0r2twvyx8zb',
        '238967debc01fg45kmstqrwxuvhjyznp'
      ],
      'e': [
        'bc01fg45238967deuvhjyznpkmstqrwx',
        'p0r21436x8zb9dcf5h7kjnmqesgutwvy'
      ],
      'w': [
        '238967debc01fg45kmstqrwxuvhjyznp',
        '14365h7k9dcfesgujnmqp0r2twvyx8zb'
      ]
    };

    Map<String, List> border = {
      'n': ['prxz', 'bcfguvyz'],
      's': ['028b', '0145hjnp'],
      'e': ['bcfguvyz', 'prxz'],
      'w': ['0145hjnp', '028b']
    };

    String last = geohash[geohash.length - 1];
    String parent = geohash.substring(0, geohash.length - 1);
    int t = geohash.length % 2;

    if ((border[direction]?[t]).toString().contains(last)) {
      parent = _adjacent(geohash: parent, direction: direction);
    }

    return parent +
        _baseSequence[(neighbor[direction]?[t]).toString().indexOf(last)];
  }

  /// Returns a Map<String, String> containing the `Direction` as the key and
  /// the value being the geohash of the neighboring geohash in that direction.
  Map<String, String> neighbors(String geohash) {
    if (geohash == "")
      throw ArgumentError.value(geohash, "geohash");
    else if (!geohash
        .contains(new RegExp(r'^[0123456789bcdefghjkmnpqrstuvwxyz]+$')))
      throw ArgumentError("Invalid character in GeoHash");

    return {
      Direction.NORTH.toString().split(".")[1]:
          _adjacent(geohash: geohash, direction: "n"),
      Direction.NORTHEAST.toString().split(".")[1]: _adjacent(
          geohash: _adjacent(geohash: geohash, direction: 'n'), direction: 'e'),
      Direction.EAST.toString().split(".")[1]:
          _adjacent(geohash: geohash, direction: 'e'),
      Direction.SOUTHEAST.toString().split(".")[1]: _adjacent(
          geohash: _adjacent(geohash: geohash, direction: 's'), direction: 'e'),
      Direction.SOUTH.toString().split(".")[1]:
          _adjacent(geohash: geohash, direction: 's'),
      Direction.SOUTHWEST.toString().split(".")[1]: _adjacent(
          geohash: _adjacent(geohash: geohash, direction: 's'), direction: 'w'),
      Direction.WEST.toString().split(".")[1]:
          _adjacent(geohash: geohash, direction: 'w'),
      Direction.NORTHWEST.toString().split(".")[1]: _adjacent(
          geohash: _adjacent(geohash: geohash, direction: 'n'), direction: 'w'),
      Direction.CENTRAL.toString().split(".")[1]: geohash
    };
  }
}

/// A containing class for a geohash
class GeoHash {
  String _geohash;
  double _longitude;
  double _latitude;
  Map<String, String> _neighbors;

  /// Returns the String geohash
  String get geohash {
    return _geohash;
  }

  /// Returns the double longitude with an optional decimal accuracy
  double longitude({int decimalAccuracy = -1}) {
    if (decimalAccuracy == -1)
      return _longitude;
    else {}
    return double.parse(_longitude.toStringAsFixed(decimalAccuracy));
  }

  /// Returns the double latitude with an optional decimal accuracy
  double latitude({int decimalAccuracy = -1}) {
    if (decimalAccuracy == -1)
      return _latitude;
    else
      return double.parse(_latitude.toStringAsFixed(decimalAccuracy));
  }

  /// Returns a Map<String, String> containing the `Direction` as the key and
  /// the value being the geohash of the neighboring geohash in that direction.
  Map<String, String> get neighbors {
    return _neighbors;
  }

  /// Returns a String geohash of a neighboring geohash in a given direction
  String neighbor(Direction direction) {
    return _neighbors[direction.toString().split(".")[1]] ?? "";
  }

  /// Constructor given a String geohash
  GeoHash(String geohash)
      : _geohash = geohash,
        _neighbors = GeoHasher().neighbors(geohash),
        _longitude = GeoHasher().decode(geohash)[0],
        _latitude = GeoHasher().decode(geohash)[1];

  /// Constructor given Longitude and Latitude
  GeoHash.fromDecimalDegrees(double longitude, double latitude,
      {int precision = 9})
      : _longitude = longitude,
        _latitude = latitude,
        _geohash =
            GeoHasher().encode(longitude, latitude, precision: precision),
        _neighbors = {} {
    _neighbors = GeoHasher().neighbors(_geohash);
  }

  /// Returns true if given geohash is equal to or is a neighbor of this one.
  bool isNeighbor(String geohash) {
    if (geohash.length != _geohash.length) return false;

    bool contains = false;
    _neighbors.forEach((key, value) {
      if (value == geohash) contains = true;
    });

    return contains;
  }

  /// Returns true if the given geohash contains this one within it.
  bool isInside(String geohash) {
    if (geohash.length > _geohash.length) return false;

    if (_geohash.substring(0, geohash.length) == geohash) {
      return true;
    }

    return false;
  }

  /// Returns true if the given geohash is contained within this geohash
  bool contains(String geohash) {
    if (geohash.length < _geohash.length) return false;

    if (geohash.substring(0, _geohash.length) == _geohash) {
      return true;
    }

    return false;
  }

  /// Returns a new Geohash for the parent of this one.
  GeoHash parent() {
    return GeoHash(_geohash.substring(0, _geohash.length - 1));
  }
}

GeoHasher geoHasher = GeoHasher();

/// Get centroid
List<double> getCentroid(latitude, longitude, height, width) {
  double centeredY = latitude + (height / 2);
  double centeredX = longitude + (width / 2);

  return [centeredX, centeredY];
}

/// Check to see if a point is contained in a circle
bool inCircleCheck(double latitude, double longitude, double centerLat,
    double centerLon, double radius) {
  double xDiff = longitude - centerLon;
  double yDiff = latitude - centerLat;

  if (pow(xDiff, 2) + pow(yDiff, 2) <= pow(radius, 2)) {
    return true;
  }

  return false;
}

/// Convert location point to geohash taking into account Earth curvature
String convertToGeohash(y, x, latitude, longitude, int precision) {
  double pi = 3.14159265359;

  double rEarth = 6371000;

  double latDiff = (y / rEarth) * (180 / pi);
  double lonDiff = (x / rEarth) * (180 / pi) / cos(latitude * pi / 180);

  double finalLat = latitude + latDiff;
  double finalLon = longitude + lonDiff;

  return geoHasher.encode(finalLon, finalLat, precision: precision);
}

// Generate geohashes based on radius in meters
List<String> createGeohashes(
    double latitude, double longitude, double radius, int precision) {
  if (precision > 12 || precision < 0) {
    throw ArgumentError('Incorrect precision found');
  }

  double x = 0.0;
  double y = 0.0;

  List<String> geohashes = [];

  List<double> gridWidth = [
    5009400.0,
    1252300.0,
    156500.0,
    39100.0,
    4900.0,
    1200.0,
    152.9,
    38.2,
    4.8,
    1.2,
    0.149,
    0.0370
  ];
  List<double> gridHeight = [
    4992600.0,
    624100.0,
    156000.0,
    19500.0,
    4900.0,
    609.4,
    152.4,
    19.0,
    4.8,
    0.595,
    0.149,
    0.0199
  ];

  double height = (gridHeight[precision - 1]) / 2;
  double width = (gridWidth[precision - 1]) / 2;

  int latMoves = (radius / height).ceil();
  int lonMoves = (radius / width).ceil();

  for (var i = 0; i < latMoves; i++) {
    double tempLat = y + height * i;
    for (var j = 0; j < lonMoves; j++) {
      double tempLong = y + width * j;

      if (inCircleCheck(tempLat, tempLong, y, x, radius)) {
        List<double> centerList = getCentroid(tempLat, tempLong, height, width);
        double centerX = centerList[0];
        double centerY = centerList[1];

        geohashes.addAll([
          convertToGeohash(centerY, centerX, latitude, longitude, precision),
          convertToGeohash(-centerY, centerX, latitude, longitude, precision),
          convertToGeohash(centerY, -centerX, latitude, longitude, precision),
          convertToGeohash(-centerY, -centerX, latitude, longitude, precision),
        ]);
      }
    }
  }
  // remove duplicates
  return geohashes.toSet().toList();
}
