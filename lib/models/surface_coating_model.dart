class SurfaceCoating {
  final String id;
  final String batchNumber;
  final String inspectorName;
  final String shift;
  final String inspectionDate;
  final int sampleSize;
  final String status;
  final String remarks;
  final String inspectionType;
  final String processType;
  final String supervisorName;
  final Range requiredThicknessRange;
  final List<Photo> photos;
  final List<CoatingThickness> coatingThickness;
  final String visualCheck;
  final String adhesionTest;
  final String colorConsistency;
  final String surfaceDefects;

  SurfaceCoating({
    required this.id,
    required this.batchNumber,
    required this.inspectorName,
    required this.shift,
    required this.inspectionDate,
    required this.sampleSize,
    required this.status,
    required this.remarks,
    required this.inspectionType,
    required this.processType,
    required this.supervisorName,
    required this.requiredThicknessRange,
    required this.photos,
    required this.coatingThickness,
    required this.visualCheck,
    required this.adhesionTest,
    required this.colorConsistency,
    required this.surfaceDefects,
  });

  factory SurfaceCoating.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return SurfaceCoating(
      id: data['_id'] ?? '',
      batchNumber: data['batchNumber'] ?? '',
      inspectorName: data['inspectorName'] ?? '',
      shift: data['shift'] ?? '',
      inspectionDate: data['inspectionDate'] ?? '',
      sampleSize: data['sampleSize'] ?? 0,
      status: data['status'] ?? '',
      remarks: data['remarks'] ?? '',
      inspectionType: data['inspectionType'] ?? '',
      processType: data['processType'] ?? '',
      supervisorName: data['supervisorName'] ?? '',
      requiredThicknessRange: Range.fromJson(
        data['requiredThicknessRange'] ?? {},
      ),
      photos:
          (data['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e))
              .toList() ??
          [],
      coatingThickness:
          (data['coatingThickness'] as List<dynamic>?)
              ?.map((e) => CoatingThickness.fromJson(e))
              .toList() ??
          [],
      visualCheck: data['visualCheck'] ?? '',
      adhesionTest: data['adhesionTest'] ?? '',
      colorConsistency: data['colorConsistency'] ?? '',
      surfaceDefects: data['surfaceDefects'] ?? '',
    );
  }
}

class Range {
  final double min;
  final double max;

  Range({required this.min, required this.max});

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
      min: (json['min'] ?? 0).toDouble(),
      max: (json['max'] ?? 0).toDouble(),
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

class CoatingThickness {
  final int sampleNumber;
  final double thickness;
  final String location;

  CoatingThickness({
    required this.sampleNumber,
    required this.thickness,
    required this.location,
  });

  factory CoatingThickness.fromJson(Map<String, dynamic> json) {
    return CoatingThickness(
      sampleNumber: json['sampleNumber'] ?? 0,
      thickness: (json['thickness'] ?? 0).toDouble(),
      location: json['location'] ?? '',
    );
  }
}
