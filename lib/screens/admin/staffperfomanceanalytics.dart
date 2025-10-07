import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StaffPerformanceAnalyticsScreen extends StatefulWidget {
  const StaffPerformanceAnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<StaffPerformanceAnalyticsScreen> createState() =>
      _StaffPerformanceAnalyticsScreenState();
}

class _StaffPerformanceAnalyticsScreenState
    extends State<StaffPerformanceAnalyticsScreen> {
  String selectedTab = 'Overview';
  String selectedShift = 'Day Shift';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Icons.arrow_back, color: Colors.red),
        ),
        title: const Text(
          "Staff Performance Analytics",
          style: TextStyle(
            color: Color(0xFFEC3237),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------------- Tabs ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton('Overview'),
                const SizedBox(width: 10),
                _buildTabButton('Process Analysis'),
              ],
            ),
            const SizedBox(height: 20),

            // ---------------- Dynamic Content ----------------
            Expanded(
              child:
                  selectedTab == 'Overview'
                      ? _buildOverviewSection()
                      : _buildProcessAnalysisSection(),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TAB BUTTONS ----------------
  Widget _buildTabButton(String title) {
    final isSelected = selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEC3237) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEC3237)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFEC3237),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- OVERVIEW SECTION ----------------
  Widget _buildOverviewSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOverviewCard(),
          const SizedBox(height: 16),

          // Status Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildStatusChip("Passed", "8", Colors.green),
              _buildStatusChip("On Hold", "3", Colors.orange),
              _buildStatusChip("Rework", "2", Colors.blue),
              _buildStatusChip("Scrap", "1", Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Shift Buttons
          Row(
            children: [
              Expanded(child: _buildShiftButton("Day Shift")),
              const SizedBox(width: 12),
              Expanded(child: _buildShiftButton("Night Shift")),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- OVERVIEW CARD ----------------
  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEC3237), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "14",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            "Total Inspections",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const LinearProgressIndicator(
            value: 0.8,
            color: Color(0xFFEC3237),
            backgroundColor: Color(0xFFE0E0E0),
          ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Pass Rate: 85%", style: TextStyle(color: Colors.grey)),
              Text("Completion: 90%", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- STATUS CHIP (NUMBER ABOVE TEXT) ----------------
  Widget _buildStatusChip(String label, String number, Color color) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.8),
        // borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          // const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SHIFT BUTTON ----------------
  Widget _buildShiftButton(String shift) {
    final isSelected = selectedShift == shift;
    Icon icon =
        shift == "Day Shift" ? Icon(Icons.sunny) : Icon(Icons.nightlight);
    return GestureDetector(
      onTap: () => setState(() => selectedShift = shift),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFFEC3237) : Colors.white,
          border: Border.all(color: const Color(0xFFEC3237), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("8", style: TextStyle(fontSize: 16)),
            Icon(icon.icon, color: isSelected ? Colors.amber : Colors.black45),
            Text(
              shift,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFEC3237),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- PROCESS ANALYSIS SECTION ----------------
  Widget _buildProcessAnalysisSection() {
    final processes = [
      "Incoming",
      "Forming",
      "Coating",
      "Assembly",
      "Stamping",
      "Packing",
      "Pdir",
    ];

    return ListView.builder(
      itemCount: processes.length,
      itemBuilder: (context, index) {
        return _buildProcessCard(processes[index]);
      },
    );
  }

  // ---------------- PROCESS CARD ----------------
  Widget _buildProcessCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEC3237), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEC3237).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "1",
                  style: TextStyle(
                    color: Color(0xFFEC3237),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          const LinearProgressIndicator(
            value: 0.8,
            color: Color(0xFFEC3237),
            backgroundColor: Color(0xFFE0E0E0),
          ),
          const SizedBox(height: 10),

          // Status Chips in Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatusChip("Passed", "8", Colors.green),
              _buildStatusChip("Hold", "1", Colors.orange),
              _buildStatusChip("Issues", "0", Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
