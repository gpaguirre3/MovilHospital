import 'package:equatable/equatable.dart';

class Hospital extends Equatable {
  final int id;
  final String name;
  final String direction;
  final String? barrio;
  final String? latitude;
  final String? longitude;

  const Hospital({
    required this.id,
    required this.name,
    required this.direction,
    this.barrio,
    this.latitude,
    this.longitude,
  });

  /// Extracts or formats code + name string, e.g. "63565 CORAL AMERICAS)"
  String get formattedCodeName => '$id ${name.toUpperCase()})';

  /// Full display subtitle: "(Av. Las Américas #14-20, Barrio El Prado)"
  String get fullAddressText {
    final b = barrio != null && barrio!.isNotEmpty ? ', $barrio' : '';
    return '($direction$b)';
  }

  @override
  List<Object?> get props => [id, name, direction, barrio, latitude, longitude];
}
