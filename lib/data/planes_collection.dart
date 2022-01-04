import '../models/vehicle.dart';
import '../utilities/constants.dart';

class PlanesCollection {
  List<Vehicle> planes = [
    Vehicle(
      image: 'assets/planes/a2d.png',
      name: 'A2D',
      nation: 'USA',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['wWII'],
    ),
    Vehicle(
      image: 'assets/planes/a5m4.png',
      name: 'A5M4',
      nation: 'Japan',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['preWWII'],
    ),
    Vehicle(
      image: 'assets/planes/a6m2_n_zero.png',
      name: 'A6M2-N-0',
      nation: 'Japan',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['preWWII'],
    ),
    Vehicle(
      image: 'assets/planes/a6m2_zero.png',
      name: 'A6M2',
      nation: 'Japan',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['wWII'],
    ),
    Vehicle(
      image: 'assets/planes/a7m2.png',
      name: 'A7M2',
      nation: 'Japan',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['wWII'],
    ),
    Vehicle(
      image: 'assets/planes/a26b.png',
      name: 'A5M4',
      nation: 'Japan',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['preWWII'],
    ),
    Vehicle(
      image: 'assets/planes/a129.png',
      name: 'A.129',
      nation: 'Italy',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['coldWar'],
    ),
    Vehicle(
      image: 'assets/planes/ah1f.png',
      name: 'AH-1F',
      nation: 'USA',
      type: vehiclesType['plane'],
      periodOfTime: periodsCollection['coldWar'],
    ),
  ];
}
