// To parse this JSON data, do
//
//     final pharmacy = pharmacyFromJson(jsonString);

import 'dart:convert';

List<Pharmacy> pharmacyFromJson(String str) =>
    List<Pharmacy>.from(json.decode(str).map((x) => Pharmacy.fromJson(x)));

String pharmacyToJson(List<Pharmacy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pharmacy {
  Pharmacy({
    required this.tarih,
    required this.lokasyonY,
    required this.lokasyonX,
    required this.bolgeAciklama,
    required this.adi,
    required this.telefon,
    required this.adres,
    required this.bolgeId,
    required this.bolge,
    required this.uzaklikMetre,
    required this.eczaneId,
    required this.ilceId,
  });

  DateTime tarih;
  String lokasyonY;
  String lokasyonX;
  String bolgeAciklama;
  String adi;
  String telefon;
  String adres;
  int bolgeId;
  String bolge;
  dynamic uzaklikMetre;
  int eczaneId;
  int ilceId;

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
        tarih: DateTime.parse(json["Tarih"]),
        lokasyonY: json["LokasyonY"],
        lokasyonX: json["LokasyonX"],
        bolgeAciklama:
            json["BolgeAciklama"] == null ? null : json["BolgeAciklama"],
        adi: json["Adi"],
        telefon: json["Telefon"],
        adres: json["Adres"],
        bolgeId: json["BolgeId"],
        bolge: json["Bolge"],
        uzaklikMetre: json["UzaklikMetre"],
        eczaneId: json["EczaneId"],
        ilceId: json["IlceId"],
      );

  Map<String, dynamic> toJson() => {
        "Tarih": tarih.toIso8601String(),
        "LokasyonY": lokasyonY,
        "LokasyonX": lokasyonX,
        "BolgeAciklama": bolgeAciklama == null ? null : bolgeAciklama,
        "Adi": adi,
        "Telefon": telefon,
        "Adres": adres,
        "BolgeId": bolgeId,
        "Bolge": bolge,
        "UzaklikMetre": uzaklikMetre,
        "EczaneId": eczaneId,
        "IlceId": ilceId,
      };
}
