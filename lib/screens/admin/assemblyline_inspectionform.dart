import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AssemblyLineInspectionForm extends StatefulWidget {
  const AssemblyLineInspectionForm({Key? key}) : super(key: key);

  @override
  State<AssemblyLineInspectionForm> createState() =>
      _AssemblyLineInspectionFormState();
}

class _AssemblyLineInspectionFormState
    extends State<AssemblyLineInspectionForm> {
  final TextEditingController batchNumberController = TextEditingController();
  final TextEditingController inspectionDateController =
      TextEditingController();
  final TextEditingController sampleSizeController = TextEditingController();
  final TextEditingController lineNumberController = TextEditingController();
  final TextEditingController stationIdController = TextEditingController();

  String? selectedInspector;
  String? selectedShift;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Icons.arrow_back, color: Colors.red),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Assembly / Station\nInspection Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFEC3237),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),

                  _buildTextField(
                    "Batch Number *",
                    "Enter number",
                    batchNumberController,
                  ),

                  _buildDropdown(
                    title: "Inspector Name",
                    hint: "Select Mode",
                    value: selectedInspector,
                    items: ["Inspector 1", "Inspector 2", "Inspector 3"],
                    onChanged: (val) => setState(() => selectedInspector = val),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdown(
                          title: "Shift",
                          hint: "Select Shifts",
                          value: selectedShift,
                          items: ["Morning", "Evening", "Night"],
                          onChanged:
                              (val) => setState(() => selectedShift = val),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          "Inspection Date",
                          "DD/MM/YYYY",
                          inspectionDateController,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          "Sample Size",
                          "Enter the sample Size",
                          sampleSizeController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    "Line Number",
                    "Assembly Line Number",
                    lineNumberController,
                  ),
                  const SizedBox(height: 12),

                  _buildTextField(
                    "Station ID",
                    "Station Identifier",
                    stationIdController,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const AssemblyInspectionReport(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC3237),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            border: Border.all(color: Colors.red.shade200, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String title,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(hint, style: const TextStyle(color: Colors.black54)),
              isExpanded: true,
              items:
                  items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

/// 🔹 SECOND SCREEN: Assembly Inspection Report
class AssemblyInspectionReport extends StatefulWidget {
  const AssemblyInspectionReport({Key? key}) : super(key: key);

  @override
  State<AssemblyInspectionReport> createState() =>
      _AssemblyInspectionReportState();
}

class _AssemblyInspectionReportState extends State<AssemblyInspectionReport> {
  String? operationSmoothness;
  String? lockingPerformance;
  String? softCloseMechanism;

  final TextEditingController noiseController = TextEditingController();

  Color _getColor(String? selected, String option) {
    if (selected == option) {
      if (option == "Smooth" || option == "Proper") {
        return Colors.green.shade400;
      } else if (option == "Jam" || option == "Fails") {
        return Colors.red.shade400;
      }
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Assembly Inspection Report",
          style: TextStyle(
            color: Color(0xFFEC3237),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Functionality Test",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              "Test the operational functionality of assembled products",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Operation Smoothness
            _buildToggleBox(
              title: "Operation Smoothness",
              options: ["Smooth", "Jam"],
              selectedValue: operationSmoothness,
              onChanged: (val) => setState(() => operationSmoothness = val),
            ),
            const SizedBox(height: 10),

            // Locking Performance
            _buildToggleBox(
              title: "Locking Performance",
              options: ["Proper", "Fails"],
              selectedValue: lockingPerformance,
              onChanged: (val) => setState(() => lockingPerformance = val),
            ),
            const SizedBox(height: 10),

            // Soft Close
            _buildToggleBox(
              title: "Soft Close Mechanism",
              options: ["Proper", "Fails"],
              selectedValue: softCloseMechanism,
              onChanged: (val) => setState(() => softCloseMechanism = val),
            ),
            const SizedBox(height: 10),

            // Noise
            _buildNoiseInput(),

            const SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC3237),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBox({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                options.map((option) {
                  final color = _getColor(selectedValue, option);
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(option),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: Colors.red.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(
                              color:
                                  (color == Colors.white)
                                      ? Colors.black
                                      : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoiseInput() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Noise Level Measurement",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: noiseController,
            decoration: InputDecoration(
              hintText: "Enter the dB value",
              filled: true,
              fillColor: Colors.red.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
