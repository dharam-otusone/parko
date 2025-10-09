class Inspection {
  final String id;
  final String batchNumber;
  final String inspectorName;
  final String shift;
  final DateTime inspectionDate;
  final int sampleSize;
  final String status;
  final String remarks;
  final List<Photo> photos;
  final String machineId;
  final List<DimensionalResult> dimensionalResults;
  final String visualCheck;
  final String surfaceFinish;
  final String deformation;

  Inspection({
    required this.id,
    required this.batchNumber,
    required this.inspectorName,
    required this.shift,
    required this.inspectionDate,
    required this.sampleSize,
    required this.status,
    required this.remarks,
    required this.photos,
    required this.machineId,
    required this.dimensionalResults,
    required this.visualCheck,
    required this.surfaceFinish,
    required this.deformation,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json['_id'] ?? '',
      batchNumber: json['batchNumber'] ?? '',
      inspectorName: json['inspectorName'] ?? '',
      shift: json['shift'] ?? '',
      inspectionDate: DateTime.parse(json['inspectionDate']),
      sampleSize: json['sampleSize'] ?? 0,
      status: json['status'] ?? '',
      remarks: json['remarks'] ?? '',
      photos: (json['photos'] as List).map((e) => Photo.fromJson(e)).toList(),
      machineId: json['machineId'] ?? '',
      dimensionalResults:
          (json['dimensionalResults'] as List)
              .map((e) => DimensionalResult.fromJson(e))
              .toList(),
      visualCheck: json['visualCheck'] ?? '',
      surfaceFinish: json['surfaceFinish'] ?? '',
      deformation: json['deformation'] ?? '',
    );
  }
}

class Photo {
  final String originalName;
  final String path;

  Photo({required this.originalName, required this.path});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      originalName: json['originalName'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class DimensionalResult {
  final int sampleNumber;
  final List<Dimension> dimensions;
  final String? overallStatus;

  DimensionalResult({
    required this.sampleNumber,
    required this.dimensions,
    this.overallStatus,
  });

  factory DimensionalResult.fromJson(Map<String, dynamic> json) {
    return DimensionalResult(
      sampleNumber: json['sampleNumber'] ?? 0,
      dimensions:
          (json['dimensions'] as List)
              .map((e) => Dimension.fromJson(e))
              .toList(),
      overallStatus: json['overallStatus'],
    );
  }
}

class Dimension {
  final String parameter;
  final dynamic measurement;
  final String tolerance;
  final String status;

  Dimension({
    required this.parameter,
    required this.measurement,
    required this.tolerance,
    required this.status,
  });

  factory Dimension.fromJson(Map<String, dynamic> json) {
    return Dimension(
      parameter: json['parameter'] ?? '',
      measurement: json['measurement'],
      tolerance: json['tolerance'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
