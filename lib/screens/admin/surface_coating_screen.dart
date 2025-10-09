import 'package:flutter/material.dart';
import 'package:parko/provider/surface_coating_model.dart';
import 'package:provider/provider.dart';

import 'package:go_router/go_router.dart';

class SurfaceCoatingListScreen extends StatefulWidget {
  const SurfaceCoatingListScreen({super.key});

  @override
  State<SurfaceCoatingListScreen> createState() =>
      _SurfaceCoatingListScreenState();
}

class _SurfaceCoatingListScreenState extends State<SurfaceCoatingListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SurfaceCoatingProvider>(
        context,
        listen: false,
      ).fetchSurfaceCoatingInspections();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurfaceCoatingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Surface Coating Inspections')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Filter by Inspector Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    provider.filterByInspector(_searchController.text.trim());
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.error != null
                    ? Center(child: Text(provider.error!))
                    : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: provider.inspections.length,
                      itemBuilder: (context, index) {
                        final item = provider.inspections[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(
                              item.batchNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Inspector: ${item.inspectorName}\nStatus: ${item.status}',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap:
                                () => context.push(
                                  '/surface-coating/${item.id}',
                                ), // 👈 GoRouter navigation
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
