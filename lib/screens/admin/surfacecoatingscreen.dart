import 'package:flutter/material.dart';
import 'package:parko/models/surface_coating_model.dart';
import 'package:parko/provider/surface_coating_model.dart';
import 'package:provider/provider.dart';

class SurfaceCoatingDetailScreen extends StatelessWidget {
  final String id;
  const SurfaceCoatingDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurfaceCoatingProvider>(context);
    final inspection = provider.inspections.firstWhere(
      (element) => element.id == id,
      orElse:
          () => SurfaceCoating(
            id: '',
            batchNumber: '',
            inspectorName: '',
            shift: '',
            inspectionDate: '',
            sampleSize: 0,
            status: '',
            remarks: '',
            inspectionType: '',
            processType: '',
            supervisorName: '',
            requiredThicknessRange: Range(min: 0, max: 0),
            photos: [],
            coatingThickness: [],
            visualCheck: '',
            adhesionTest: '',
            colorConsistency: '',
            surfaceDefects: '',
          ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Surface Coating Details')),
      body:
          inspection.id.isEmpty
              ? const Center(child: Text('Inspection not found'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoTile('Batch Number', inspection.batchNumber),
                    _infoTile('Inspector', inspection.inspectorName),
                    _infoTile('Shift', inspection.shift),
                    _infoTile('Supervisor', inspection.supervisorName),
                    _infoTile('Process Type', inspection.processType),
                    _infoTile('Inspection Type', inspection.inspectionType),
                    _infoTile('Status', inspection.status),
                    _infoTile('Remarks', inspection.remarks),
                    const SizedBox(height: 12),
                    _infoTile(
                      'Required Thickness',
                      '${inspection.requiredThicknessRange.min} - ${inspection.requiredThicknessRange.max} µm',
                    ),
                    const Divider(),

                    const Text(
                      'Photos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          inspection.photos.map((p) {
                            return InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Downloading ${p.originalName}...',
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                p.path,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) => Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                      ),
                                    ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Coating Thickness',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...inspection.coatingThickness.map(
                      (t) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text('Sample #${t.sampleNumber}'),
                          subtitle: Text(
                            'Thickness: ${t.thickness} µm\nLocation: ${t.location}',
                          ),
                        ),
                      ),
                    ),

                    const Divider(),
                    _infoTile('Visual Check', inspection.visualCheck),
                    _infoTile('Adhesion Test', inspection.adhesionTest),
                    _infoTile('Color Consistency', inspection.colorConsistency),
                    _infoTile('Surface Defects', inspection.surfaceDefects),
                  ],
                ),
              ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
