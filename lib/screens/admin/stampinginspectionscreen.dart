import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StampingInspectionScreen extends StatefulWidget {
  const StampingInspectionScreen({Key? key}) : super(key: key);

  @override
  State<StampingInspectionScreen> createState() =>
      _StampingInspectionScreenState();
}

class _StampingInspectionScreenState extends State<StampingInspectionScreen> {
  final TextEditingController batchNumberController = TextEditingController();
  final TextEditingController inspectionDateController =
      TextEditingController();
  final TextEditingController sampleSizeController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  String? selectedInspector;
  String? selectedShift;
  String? selectedVisualCheck;
  String? selectedFinalStatus;

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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Stamping\nInspections",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFEC3237),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Batch Number
                  _buildTextField(
                    "Batch Number *",
                    "Enter number",
                    batchNumberController,
                  ),
                  const SizedBox(height: 12),

                  // Inspector Name Dropdown
                  _buildDropdown(
                    title: "Inspector Name",
                    hint: "Select Mode",
                    value: selectedInspector,
                    items: ["Inspector 1", "Inspector 2", "Inspector 3"],
                    onChanged: (val) => setState(() => selectedInspector = val),
                  ),
                  const SizedBox(height: 12),

                  // Section for Shift / Date / Sample Size
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
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
                  const SizedBox(height: 16),

                  // Dimension Check
                  _buildTextField(
                    "Dimension Check",
                    "Enter Dimension",
                    dimensionController,
                  ),
                  const SizedBox(height: 12),

                  // Visual Check Dropdown
                  _buildDropdown(
                    title: "Visual Check",
                    hint: "Select Visual Inspection Result",
                    value: selectedVisualCheck,
                    items: ["OK", "Not OK", "Rework", "Hold"],
                    onChanged:
                        (val) => setState(() => selectedVisualCheck = val),
                  ),
                  const SizedBox(height: 12),

                  // Final Status Dropdown
                  _buildDropdown(
                    title: "Final Status",
                    hint: "Select Overall Inspection Status",
                    value: selectedFinalStatus,
                    items: ["Accepted", "Rejected", "Hold"],
                    onChanged:
                        (val) => setState(() => selectedFinalStatus = val),
                  ),
                  const SizedBox(height: 12),

                  // Remark Field
                  _buildTextField(
                    "Remark",
                    "Add any additional remarks",
                    remarkController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),

                  // Upload Photo
                  _buildUploadBox(),

                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: handle submit action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

  /// 🔹 Reusable TextField
  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
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
            maxLines: maxLines,
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

  /// 🔹 Reusable Dropdown
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
            border: Border.all(color: Colors.red.shade200, width: 1.5),
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

  /// 🔹 Upload Photo Box
  Widget _buildUploadBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload Photos",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            // TODO: Add upload image logic
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red.shade200, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload, color: Colors.redAccent),
                  SizedBox(width: 6),
                  Text(
                    "Tap to Upload photo",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
