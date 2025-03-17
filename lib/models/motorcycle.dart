class Motorcycle {
  final int bikeId;
  final String make;
  final String model;
  final int bikeYear;
  final String rentalRate;
  final String engineCC;
  final String rentalStatus;
  final int ownerId;

  Motorcycle({
    required this.bikeId,
    required this.make,
    required this.model,
    required this.bikeYear,
    required this.rentalRate,
    required this.engineCC,
    required this.rentalStatus,
    required this.ownerId,
  });

  factory Motorcycle.fromJson(Map<String, dynamic> json) {
    return Motorcycle(
      bikeId: json['bike_id'],
      make: json['make'],
      model: json['model'],
      bikeYear: json['bike_year'],
      rentalRate: json['rental_rate_per_week'],
      engineCC: json['engine_cc'],
      rentalStatus: json['rental_status'],
      ownerId: json['owner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'bike_year': bikeYear,
      'rental_rate_per_week': rentalRate,
      'engine_cc': engineCC,
      'rental_status': rentalStatus,
      'owner_id': ownerId,
    };
  }
}
