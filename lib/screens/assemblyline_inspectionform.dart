import 'package:flutter/material.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  // Heading
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

                  // Batch Number
                  _buildTextField(
                    "Batch Number *",
                    "Enter number",
                    batchNumberController,
                  ),

                  // Inspector Name Dropdown
                  _buildDropdown(
                    title: "Inspector Name",
                    hint: "Select Mode",
                    value: selectedInspector,
                    items: ["Inspector 1", "Inspector 2", "Inspector 3"],
                    onChanged: (val) => setState(() => selectedInspector = val),
                  ),

                  const SizedBox(height: 10),

                  // Section container for Shift / Date / Sample Size
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(
                        color: Colors.red.shade200,
                        style: BorderStyle.solid,
                      ),
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

                  // Line Number
                  _buildTextField(
                    "Line Number",
                    "Assembly Line Number",
                    lineNumberController,
                  ),

                  const SizedBox(height: 12),

                  // Station ID
                  _buildTextField(
                    "Station ID",
                    "Station Identifier",
                    stationIdController,
                  ),

                  const SizedBox(height: 30),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: handle next navigation
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

  // 🔹 Custom reusable textfield builder
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

  // 🔹 Custom reusable dropdown builder
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
