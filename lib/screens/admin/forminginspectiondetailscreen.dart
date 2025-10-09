import 'package:flutter/material.dart';
import 'package:parko/provider/forming_inspection_provider.dart';
import 'package:provider/provider.dart';

class FormingInspectionDetailScreen extends StatefulWidget {
  final String id;
  const FormingInspectionDetailScreen({super.key, required this.id});

  @override
  State<FormingInspectionDetailScreen> createState() =>
      _FormingInspectionDetailScreenState();
}

class _FormingInspectionDetailScreenState
    extends State<FormingInspectionDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FormingInpectionDetailProvider>(
        context,
        listen: false,
      ).fetchFormingInspectionById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormingInpectionDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Forming Inspection Details')),
      body:
          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.error != null
              ? Center(child: Text(provider.error!))
              : provider.inspection == null
              ? const Center(child: Text('No data found'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoTile('Batch Number', provider.inspection!.batchNumber),
                    _infoTile('Inspector', provider.inspection!.inspectorName),
                    _infoTile('Shift', provider.inspection!.shift),
                    _infoTile('Machine ID', provider.inspection!.machineId),
                    _infoTile('Status', provider.inspection!.status),
                    _infoTile('Remarks', provider.inspection!.remarks),
                    const SizedBox(height: 16),

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
                          provider.inspection!.photos
                              .map(
                                (p) => InkWell(
                                  onTap: () async {
                                    // download or open URL
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
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Dimensional Results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...provider.inspection!.dimensionalResults.map(
                      (r) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sample #${r.sampleNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...r.dimensions.map(
                                (d) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(d.parameter),
                                    Text(
                                      'Value: ${d.measurement} (${d.tolerance})',
                                    ),
                                    Text(d.status),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
