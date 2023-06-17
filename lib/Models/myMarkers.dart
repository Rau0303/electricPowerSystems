class ChargePoint {
  dynamic id;
  String charge_box_id;
  dynamic address;
  String description;
  double location_latitude;
  double location_longitude;

  ChargePoint({
    required this.id,
    required this.charge_box_id,
    required this.address,
    required this.description,
    required this.location_latitude,
    required this.location_longitude,
  });




  factory ChargePoint.fromJson(Map<String, dynamic> json) {
    return ChargePoint(
      id: json['id'].toString(),
      charge_box_id: json['charge_box_id'] ?? '',
      address: json['address'].toString(),
      description: json['description'] ?? 'Unknown',
      location_latitude:double.parse( json['location_latitude'] ?? '0.0'),
      location_longitude: double.parse(json['location_longitude'] ?? '0.0'),
    );
  }
}
