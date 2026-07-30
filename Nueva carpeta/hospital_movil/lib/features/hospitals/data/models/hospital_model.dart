import '../../domain/entities/hospital.dart';

class HospitalModel extends Hospital {
  const HospitalModel({
    required super.id,
    required super.name,
    required super.direction,
    super.barrio,
    super.latitude,
    super.longitude,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    final rawDirection = json['hospitalDirection'] as String? ?? 'Dirección no especificada';
    
    // Parse barrio if present in direction string (e.g. "Av. Las Américas #14-20, Barrio El Prado")
    String directionText = rawDirection;
    String? extractedBarrio;
    if (rawDirection.contains(', Barrio ')) {
      final parts = rawDirection.split(', Barrio ');
      directionText = parts[0];
      extractedBarrio = 'Barrio ${parts[1]}';
    } else if (rawDirection.contains('Barrio ')) {
      final idx = rawDirection.indexOf('Barrio ');
      directionText = rawDirection.substring(0, idx).trim();
      if (directionText.endsWith(',')) {
        directionText = directionText.substring(0, directionText.length - 1);
      }
      extractedBarrio = rawDirection.substring(idx).trim();
    }

    return HospitalModel(
      id: json['hospitalId'] as int? ?? 0,
      name: json['hospitalName'] as String? ?? 'HOSPITAL S.A.',
      direction: directionText,
      barrio: extractedBarrio,
      latitude: json['hospitalLatitude'] as String?,
      longitude: json['hospitalLongitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hospitalId': id,
      'hospitalName': name,
      'hospitalDirection': barrio != null ? '$direction, $barrio' : direction,
      'hospitalLatitude': latitude,
      'hospitalLongitude': longitude,
    };
  }
}
