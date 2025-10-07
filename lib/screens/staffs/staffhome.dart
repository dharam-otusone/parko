import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Staffhome extends StatefulWidget {
  const Staffhome({super.key});

  @override
  State<Staffhome> createState() => _StaffhomeState();
}

class _StaffhomeState extends State<Staffhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: SideBarMenu());
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
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.red.shade600),
            accountName: const Text("Shreya Babukar"),
            accountEmail: const Text("Admin"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.red),
            ),
          ),

          // Dashboard with 2 submenus
          ExpansionTile(
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

          // Suppliers with 2 submenus
          ExpansionTile(
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
                onTap: () => context.go('/suppliers/all'),
              ),
              ListTile(
                title: const Text(
                  "Add Suppliers",
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () => context.go('/suppliers/add'),
              ),
            ],
          ),

          // Items from Submitted Form onwards (always 2 submenus)
          _buildSubMenu(
            context,
            "Submitted Form",
            Icons.assignment,
            "/submittedform",
          ),

          _buildSubMenu(
            context,
            "Incoming Inspection",
            Icons.search,
            "/incominginspection",
          ),
          _buildSubMenu(
            context,
            "Forming Process Inspection",
            Icons.fact_check,
            "/formingprocess",
          ),
          _buildSubMenu(
            context,
            "Surface Coating Inspection",
            Icons.format_paint,
            "/surfacecoating",
          ),
          _buildSubMenu(
            context,
            "Assembly Line Inspection",
            Icons.precision_manufacturing,
            "/assemblyline",
          ),
          _buildSubMenu(
            context,
            "Stamping Inspection",
            Icons.stay_primary_landscape,
            "/stamping",
          ),
          _buildSubMenu(
            context,
            "Packaging Inspection",
            Icons.inventory,
            "/packaging",
          ),
          _buildSubMenu(
            context,
            "Final PDIR",
            Icons.check_circle,
            "/finalpdir",
          ),
          _buildSubMenu(
            context,
            "QC Parameter",
            Icons.settings,
            "/qcparameter",
          ),

          const Divider(color: Colors.white54),

          // Bottom button
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

  /// Helper to build submenu items with "Create New" and "All"
  Widget _buildSubMenu(
    BuildContext context,
    String title,
    IconData icon,
    String baseRoute,
  ) {
    return ExpansionTile(
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
