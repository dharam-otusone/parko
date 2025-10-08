import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarMenu(),
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/staffonboarding');
          },
          child: const Text('Home Screen'),
        ),
      ),
    );
  }
}

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red.shade600,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Profile Section
          Container(
            height: 180, // Increased height
            decoration: BoxDecoration(color: Colors.red.shade600),
            child: Stack(
              children: [
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Profile Picture
                      const CircleAvatar(
                        radius: 36, // Increased size
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.red,
                          size: 40,
                        ), // Increased icon size
                      ),
                      const SizedBox(width: 16),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Shreya Babukar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Admin",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Dashboard
          ExpansionTile(
            showTrailingIcon: false,
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: const Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
            children: [
              ListTile(
                title: const Text(
                  "Overview",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => context.go('/dashboard/overview'),
              ),
              ListTile(
                title: const Text(
                  "Insights",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => context.go('/dashboard/insights'),
              ),
            ],
          ),
          ExpansionTile(
            showTrailingIcon: false,
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: GestureDetector(
              onTap: () => context.go('/dashboard/staffonboardscreen'),
              child: const Text(
                "Staff Onboarding",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Suppliers
          ExpansionTile(
            showTrailingIcon: false,
            leading: const Icon(Icons.group, color: Colors.white),
            title: const Text(
              "Suppliers",
              style: TextStyle(color: Colors.white),
            ),
            children: [
              ListTile(
                title: const Text(
                  "All Suppliers",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => context.go('/dashboard/suppliers/all'),
              ),
              ListTile(
                title: const Text(
                  "Add Supplier",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => context.go('/dashboard/suppliers/add'),
              ),
            ],
          ),

          // Other Submenus
          _buildSubMenu(
            context,
            "Incoming Inspection",
            Icons.search,
            "/dashboard/incominginspection",
          ),
          _buildSubMenu(
            context,
            "Forming Process Inspection",
            Icons.fact_check,
            "/dashboard/forminginspection",
          ),
          _buildSubMenu(
            context,
            "Surface Coating Inspection",
            Icons.format_paint,
            "/dashboard/surfacecoating",
          ),
          _buildSubMenu(
            context,
            "Assembly Line Inspection",
            Icons.precision_manufacturing,
            "/dashboard/assemblyline",
          ),
          _buildSubMenu(
            context,
            "Stamping Inspection",
            Icons.stay_primary_landscape,
            "/dashboard/stamping",
          ),
          _buildSubMenu(
            context,
            "Packaging Inspection",
            Icons.inventory,
            "/dashboard/packaging",
          ),
          _buildSubMenu(
            context,
            "Final PDIR",
            Icons.check_circle,
            "/dashboard/finalpdir",
          ),
          _buildSubMenu(
            context,
            "QC Parameter",
            Icons.settings,
            "/dashboard/qcparameter",
          ),

          const Divider(color: Colors.white54),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => context.go('/newform'),
              icon: const Icon(Icons.add),
              label: const Text("Add New Form"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenu(
    BuildContext context,
    String title,
    IconData icon,
    String baseRoute,
  ) {
    return ExpansionTile(
      showTrailingIcon: false,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      children: [
        ListTile(
          title: const Text(
            "Create New",
            style: TextStyle(color: Colors.white70),
          ),
          onTap: () => context.go("$baseRoute/create"),
        ),
        ListTile(
          title: const Text("All", style: TextStyle(color: Colors.white70)),
          onTap: () => context.go("$baseRoute/all"),
        ),
      ],
    );
  }
}
