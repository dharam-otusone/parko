import 'package:flutter/material.dart';
import 'package:parko/provider/inspection_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InspectionDetailScreen extends StatefulWidget {
  final String inspectionId;

  const InspectionDetailScreen({super.key, required this.inspectionId});

  @override
  State<InspectionDetailScreen> createState() => _InspectionDetailScreenState();
}

class _InspectionDetailScreenState extends State<InspectionDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InspectionDetailProvider>(
        context,
        listen: false,
      ).fetchInspectionDetail(widget.inspectionId);
    });
  }

  Future<void> _downloadFile(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InspectionDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Details'),
        backgroundColor: Color(0xFFEC3237),
      ),
      body:
          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.inspection == null
              ? const Center(child: Text('No details found'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(provider),
                    const SizedBox(height: 16),
                    _buildPhotos(provider),
                    const SizedBox(height: 16),
                    _buildDimensionalChecks(provider),
                  ],
                ),
              ),
    );
  }

  Widget _buildHeader(InspectionDetailProvider provider) {
    final data = provider.inspection!;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Batch: ${data.batchNumber}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Inspector: ${data.inspectorName}'),
            Text('Shift: ${data.shift}'),
            Text('Status: ${data.status}'),
            Text('Material Type: ${data.materialType}'),
            Text('Invoice: ${data.invoiceNumber}'),
            Text('Functionality Check: ${data.functionalityCheck}'),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotos(InspectionDetailProvider provider) {
    final data = provider.inspection!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (data.photos.isEmpty) const Text('No photos available'),
        for (var photo in data.photos) Image.network(photo.path),
      ],
    );
  }

  Widget _buildDimensionalChecks(InspectionDetailProvider provider) {
    final data = provider.inspection!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dimensional Checks:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (var dim in data.dimensionalCheck)
          ListTile(
            title: Text('${dim.parameter}: ${dim.value}'),
            trailing: Text(dim.status, style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
