class UserFields {
  static final List<String> values = [id, name, username, email, phno];

  static final String id = '_id';
  static final String name = 'name';
  static final String username = 'username';
  static final String email = 'email';
  static final String phno = 'phone';
}

class Service {
  Service({
    this.id,
    this.name,
    this.username,
    this.email,
    // this.address,
    this.phone,
    // this.website,
    // this.company,
  });

  int id;
  String name;
  String username;
  String email;
  // Address address;
  String phone;
  // String website;
  // Company company;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        // address: Address.fromJson(json["address"]),
        phone: json["phone"],
        // website: json["website"],
        // company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.username: username,
        UserFields.email: email,
        UserFields.phno: phone,
      };
  Service copy({
    int id,
     String name,
  String username,
  String email,
  
  String phone,

    
  }) =>
      Service(id: id?? this.id,
      
      name: name?? this.name,
      username: username?? this.username,
      email: email??this.email,
      phone: phone?? this.phone,
      
      );
}

class Address {
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );
}

class Geo {
  Geo({
    this.lat,
    this.lng,
  });

  String lat;
  String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );
}

class Company {
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  String name;
  String catchPhrase;
  String bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );
}
