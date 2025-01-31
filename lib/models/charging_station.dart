import 'package:hive_flutter/hive_flutter.dart';

part 'charging_station.g.dart';

@HiveType(typeId: 0)
class ChargingStation extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final double power;

  @HiveField(6)
  final List<String> connectors;

  @HiveField(7)
  final bool isAvailable;

  @HiveField(8)
  final double price;

  @HiveField(9)
  final String operator;

  @HiveField(10)
  final double rating;

  @HiveField(11)
  final bool favorite;

  ChargingStation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.power,
    required this.connectors,
    required this.isAvailable,
    required this.price,
    required this.operator,
    required this.rating,
    this.favorite = false,
  });

  ChargingStation copyWith({bool? favorite}) {
    return ChargingStation(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      address: address,
      power: power,
      connectors: connectors,
      isAvailable: isAvailable,
      price: price,
      operator: operator,
      rating: rating,
      favorite: favorite ?? this.favorite,
    );
  }

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      address: json['address'],
      power: json['power'].toDouble(),
      connectors: List<String>.from(json['connectors']),
      isAvailable: json['isAvailable'],
      price: json['price'].toDouble(),
      operator: json['operator'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'power': power,
        'connectors': connectors,
        'isAvailable': isAvailable,
        'price': price,
        'operator': operator,
        'rating': rating,
      };
}
