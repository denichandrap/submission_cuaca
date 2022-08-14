// To parse this JSON data, do
//
//     final kota = kotaFromJson(jsonString);

import 'dart:convert';

List<Kota> kotaFromJson(String str) =>
    List<Kota>.from(json.decode(str).map((x) => Kota.fromJson(x)));

String kotaToJson(List<Kota> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kota {
  Kota({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  final String id;
  final String provinceId;
  final String name;

  factory Kota.fromJson(Map<String, dynamic> json) => Kota(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
