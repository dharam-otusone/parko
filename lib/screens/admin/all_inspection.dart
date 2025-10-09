import 'package:flutter/material.dart';
import 'package:parko/provider/inspection_provider.dart';
import 'package:parko/screens/admin/inspection_detail_screen.dart';
import 'package:provider/provider.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<InspectionProvider>(context, listen: false).fetchInspections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<InspectionProvider>(
        builder: (context, provider, _) {
          final inspections = provider.inspections;

          if (inspections.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: provider.selectedInspector,
                  isExpanded: true,
                  items:
                      provider.allInspectors
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) provider.filterByInspector(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: inspections.length,
                  itemBuilder: (context, index) {
                    final insp = inspections[index];
                    return GestureDetector(
                      onTap: () {
                        print('tapped ${insp.id}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => InspectionDetailScreen(
                                  inspectionId: insp.id,
                                ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(insp.inspectorName[0].toUpperCase()),
                          ),
                          title: Text(insp.inspectorName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status: ${insp.status}'),
                              Text('Batch: ${insp.batchNumber}'),
                              Text('Material: ${insp.materialType}'),
                              Text('Qty: ${insp.quantityReceived}'),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            print('tapped ${insp.id}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => InspectionDetailScreen(
                                      inspectionId: insp.id,
                                    ),
                              ),
                            );
                            // Optional: show details page or dialog with photos
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
