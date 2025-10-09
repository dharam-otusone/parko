class FormingInspection {
  final String id;
  final String batchNumber;
  final String inspectorName;
  final String shift;
  final String inspectionDate;
  final int sampleSize;
  final String status;
  final String remarks;
  final String machineId;
  final String visualCheck;
  final String surfaceFinish;
  final String deformation;
  final List<Photo> photos;
  final List<DimensionalResult> dimensionalResults;

  FormingInspection({
    required this.id,
    required this.batchNumber,
    required this.inspectorName,
    required this.shift,
    required this.inspectionDate,
    required this.sampleSize,
    required this.status,
    required this.remarks,
    required this.machineId,
    required this.visualCheck,
    required this.surfaceFinish,
    required this.deformation,
    required this.photos,
    required this.dimensionalResults,
  });

  factory FormingInspection.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return FormingInspection(
      id: data['_id'] ?? '',
      batchNumber: data['batchNumber'] ?? '',
      inspectorName: data['inspectorName'] ?? '',
      shift: data['shift'] ?? '',
      inspectionDate: data['inspectionDate'] ?? '',
      sampleSize: data['sampleSize'] ?? 0,
      status: data['status'] ?? '',
      remarks: data['remarks'] ?? '',
      machineId: data['machineId'] ?? '',
      visualCheck: data['visualCheck'] ?? '',
      surfaceFinish: data['surfaceFinish'] ?? '',
      deformation: data['deformation'] ?? '',
      photos:
          (data['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e))
              .toList() ??
          [],
      dimensionalResults:
          (data['dimensionalResults'] as List<dynamic>?)
              ?.map((e) => DimensionalResult.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Photo {
  final String filename;
  final String originalName;
  final String path;

  Photo({
    required this.filename,
    required this.originalName,
    required this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      filename: json['filename'] ?? '',
      originalName: json['originalName'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class DimensionalResult {
  final int sampleNumber;
  final List<Dimension> dimensions;
  final String overallStatus;

  DimensionalResult({
    required this.sampleNumber,
    required this.dimensions,
    required this.overallStatus,
  });

  factory DimensionalResult.fromJson(Map<String, dynamic> json) {
    return DimensionalResult(
      sampleNumber: json['sampleNumber'] ?? 0,
      dimensions:
          (json['dimensions'] as List<dynamic>?)
              ?.map((e) => Dimension.fromJson(e))
              .toList() ??
          [],
      overallStatus: json['overallStatus'] ?? '',
    );
  }
}

class Dimension {
  final String parameter;
  final double measurement;
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
      measurement: (json['measurement'] ?? 0).toDouble(),
      tolerance: json['tolerance'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
