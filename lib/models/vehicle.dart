import '../models/period_of_time.dart';
import '../models/vehicle_type.dart';

class Vehicle {
  Vehicle({
    this.image,
    this.name,
    this.nation,
    this.type,
    this.periodOfTime,
  });

  String? image;
  String? name;
  String? nation;
  VehicleType? type;
  PeriodOfTime? periodOfTime;
}
