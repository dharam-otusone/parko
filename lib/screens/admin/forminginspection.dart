import 'package:flutter/material.dart';
import 'package:parko/provider/forming_inspection_model.dart';
import 'package:parko/screens/admin/forming_inspection.dart';
import 'package:parko/screens/admin/forminginspectiondetailscreen.dart';

import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

class InspectionListScreen extends StatefulWidget {
  const InspectionListScreen({super.key});

  @override
  State<InspectionListScreen> createState() => _InspectionListScreenState();
}

class _InspectionListScreenState extends State<InspectionListScreen> {
  String? selectedInspector;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FormingInpectionProvider>(
        context,
        listen: false,
      ).fetchInspections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inspection List')),
      body: Consumer<FormingInpectionProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Dropdown Filter
                Row(
                  children: [
                    const Text(
                      'Filter by Inspector: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedInspector ?? 'All',
                        items:
                            provider.inspectorNames
                                .map(
                                  (name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() => selectedInspector = value);
                          provider.filterByInspector(value);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Inspections List
                Expanded(
                  child:
                      provider.inspections.isEmpty
                          ? const Center(child: Text('No inspections found'))
                          : ListView.builder(
                            itemCount: provider.inspections.length,
                            itemBuilder: (context, index) {
                              final inspection = provider.inspections[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              FormingInspectionDetailScreen(
                                                id: inspection.id,
                                              ),
                                    ),
                                  );
                                }, // ✅ GoRouter navigation
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          inspection.batchNumber,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Inspector: ${inspection.inspectorName}',
                                        ),
                                        Text('Shift: ${inspection.shift}'),
                                        // Text('Machine: ${inspection.}'),
                                        Text(
                                          'Status: ${inspection.status}',
                                          style: TextStyle(
                                            color:
                                                inspection.status == 'pass'
                                                    ? Colors.green
                                                    : inspection.status ==
                                                        'hold'
                                                    ? Colors.orange
                                                    : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
