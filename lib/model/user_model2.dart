import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  int id;
  String email;
  String username;
  String name;
  String phone;
  Address address;
  Company company;

  Employee({this.id, this.email, this.username, this.name,this.phone, this.address,this.company});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        name: json["name"],
        phone: json["phone"],
      address :
      json['address'] != null ? new Address.fromJson(json['address']) : null,
    company :
    json['company'] != null ? new Company.fromJson(json['company']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "name": name,
        if (this.address != null)
          'address' :this.address.toJson(),
        "phone": phone,
       if (this.company != null)
         'company' : this.company.toJson(),

      };
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;


  Address({this.street, this.suite, this.city, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    // geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    // data['zipcode'] = this.zipcode;
    // if (this.geo != null) {
    //   data['geo'] = this.geo.toJson();
    // }
    return data;
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}
