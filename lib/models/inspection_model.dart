class Photo {
  final String id;
  final String filename;
  final String originalName;
  final String path;
  final String uploadedAt;

  Photo({
    required this.id,
    required this.filename,
    required this.originalName,
    required this.path,
    required this.uploadedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['_id'] ?? '',
      filename: json['filename'] ?? '',
      originalName: json['originalName'] ?? '',
      path: json['path'] ?? '',
      uploadedAt: json['uploadedAt'] ?? '',
    );
  }
}

class Inspection {
  final String id;
  final String batchNumber;
  final String inspectorName;
  final String inspectorEmail;
  final String shift;
  final String inspectionDate;
  final String status;
  final String remarks;
  final List<Photo> photos;
  final String materialType;
  final String invoiceNumber;
  final int quantityReceived;

  Inspection({
    required this.id,
    required this.batchNumber,
    required this.inspectorName,
    required this.inspectorEmail,
    required this.shift,
    required this.inspectionDate,
    required this.status,
    required this.remarks,
    required this.photos,
    required this.materialType,
    required this.invoiceNumber,
    required this.quantityReceived,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json['_id'] ?? '',
      batchNumber: json['batchNumber'] ?? '',
      inspectorName: json['inspectorName'] ?? '',
      inspectorEmail:
          json['inspectorId'] != null
              ? (json['inspectorId']['email'] ?? '')
              : '',
      shift: json['shift'] ?? '',
      inspectionDate: json['inspectionDate'] ?? '',
      status: json['status'] ?? '',
      remarks: json['remarks'] ?? '',
      photos:
          (json['photos'] as List?)?.map((p) => Photo.fromJson(p)).toList() ??
          [],
      materialType: json['materialType'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      quantityReceived: json['quantityReceived'] ?? 0,
    );
  }
}
