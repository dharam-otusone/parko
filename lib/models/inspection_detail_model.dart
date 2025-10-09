class InspectionDetail {
  final String id;
  final String batchNumber;
  final String inspectorName;
  final String shift;
  final DateTime inspectionDate;
  final int sampleSize;
  final String status;
  final String remarks;
  final List<Photo> photos;
  final String materialType;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime materialReceivedDate;
  final int quantityReceived;
  final String functionalityCheck;
  final List<DimensionalCheck> dimensionalCheck;
  final String visualInspection;
  final String holdReason;
  final int quantityAffected;

  InspectionDetail({
    required this.id,
    required this.batchNumber,
    required this.inspectorName,
    required this.shift,
    required this.inspectionDate,
    required this.sampleSize,
    required this.status,
    required this.remarks,
    required this.photos,
    required this.materialType,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.materialReceivedDate,
    required this.quantityReceived,
    required this.functionalityCheck,
    required this.dimensionalCheck,
    required this.visualInspection,
    required this.holdReason,
    required this.quantityAffected,
  });

  factory InspectionDetail.fromJson(Map<String, dynamic> json) {
    return InspectionDetail(
      id: json['_id'] ?? '',
      batchNumber: json['batchNumber'] ?? '',
      inspectorName: json['inspectorName'] ?? '',
      shift: json['shift'] ?? '',
      inspectionDate: DateTime.parse(json['inspectionDate']),
      sampleSize: json['sampleSize'] ?? 0,
      status: json['status'] ?? '',
      remarks: json['remarks'] ?? '',
      photos: (json['photos'] as List).map((e) => Photo.fromJson(e)).toList(),
      materialType: json['materialType'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      invoiceDate: DateTime.parse(json['invoiceDate']),
      materialReceivedDate: DateTime.parse(json['materialReceivedDate']),
      quantityReceived: json['quantityReceived'] ?? 0,
      functionalityCheck: json['functionalityCheck'] ?? '',
      dimensionalCheck:
          (json['dimensionalCheck'] as List)
              .map((e) => DimensionalCheck.fromJson(e))
              .toList(),
      visualInspection: json['visualInspection'] ?? '',
      holdReason: json['holdReason'] ?? '',
      quantityAffected: json['quantityAffected'] ?? 0,
    );
  }
}

class Photo {
  final String path;
  final String originalName;

  Photo({required this.path, required this.originalName});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      path: json['path'] ?? '',
      originalName: json['originalName'] ?? '',
    );
  }
}

class DimensionalCheck {
  final String parameter;
  final dynamic value;
  final String status;

  DimensionalCheck({
    required this.parameter,
    required this.value,
    required this.status,
  });

  factory DimensionalCheck.fromJson(Map<String, dynamic> json) {
    return DimensionalCheck(
      parameter: json['parameter'] ?? '',
      value: json['value'],
      status: json['status'] ?? '',
    );
  }
}
