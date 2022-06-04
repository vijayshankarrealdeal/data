class DataMap {
  double? latitude;
  double? longitude;
  String? continent;
  String? city;
  String? countryName;
  LocalityInfo? localityInfo;

  DataMap({latitude, longitude, continent, city, countryName, localityInfo});

  DataMap.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    continent = json['continent'];
    city = json['city'];
    countryName = json['countryName'];
    localityInfo = json['localityInfo'] != null
        ? LocalityInfo.fromJson(json['localityInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['continent'] = continent;
    data['city'] = city;
    data['countryName'] = countryName;
    if (localityInfo != null) {
      data['localityInfo'] = localityInfo!.toJson();
    }
    return data;
  }
}

class LocalityInfo {
  List<Administrative>? administrative;
  List<Informative>? informative;

  LocalityInfo({administrative, informative});

  LocalityInfo.fromJson(Map<String, dynamic> json) {
    if (json['administrative'] != null) {
      administrative = <Administrative>[];
      json['administrative'].forEach((v) {
        administrative!.add(Administrative.fromJson(v));
      });
    }
    if (json['informative'] != null) {
      informative = <Informative>[];
      json['informative'].forEach((v) {
        informative!.add(Informative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (administrative != null) {
      data['administrative'] = administrative!.map((v) => v.toJson()).toList();
    }
    if (informative != null) {
      data['informative'] = informative!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Administrative {
  String? name;
  String? description;
  String? isoName;
  int? order;
  int? adminLevel;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Administrative(
      {name,
      description,
      isoName,
      order,
      adminLevel,
      isoCode,
      wikidataId,
      geonameId});

  Administrative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    order = json['order'];
    adminLevel = json['adminLevel'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['isoName'] = isoName;
    data['order'] = order;
    data['adminLevel'] = adminLevel;
    data['isoCode'] = isoCode;
    data['wikidataId'] = wikidataId;
    data['geonameId'] = geonameId;
    return data;
  }
}

class Informative {
  String? name;
  String? description;
  int? order;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Informative({name, description, order, isoCode, wikidataId, geonameId});

  Informative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    order = json['order'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['order'] = order;
    data['isoCode'] = isoCode;
    data['wikidataId'] = wikidataId;
    data['geonameId'] = geonameId;
    return data;
  }
}
