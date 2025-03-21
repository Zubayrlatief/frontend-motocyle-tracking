class Motorcycle {
  final int? bikeId;
  final String make;
  final String model;
  final int bikeYear;
  final double rentalRate;
  final String engineCC;
  final String rentalStatus;

  Motorcycle({
    this.bikeId,
    required this.make,
    required this.model,
    required this.bikeYear,
    required this.rentalRate,
    required this.engineCC,
    required this.rentalStatus,
  });

  // Convert JSON to Motorcycle object
factory Motorcycle.fromJson(Map<String, dynamic> json) {
  return Motorcycle(
    bikeId: json['bike_id'] ?? 0,
    make: json['make'],
    model: json['model'],
    bikeYear: json['bike_year'],
    rentalRate: (json['rental_rate_per_week'] as num).toDouble(),  // Will now work as expected
    engineCC: json['engine_cc'],
    rentalStatus: json['rental_status'],
  );
}


  // Convert Motorcycle object to JSON
  Map<String, dynamic> toJson() {
    return {
      "bike_id": bikeId,
      "make": make,
      "model": model,
      "bike_year": bikeYear,
      "rental_rate_per_week": rentalRate,
      "engine_cc": engineCC,
      "rental_status": rentalStatus,
    };
  }
}
