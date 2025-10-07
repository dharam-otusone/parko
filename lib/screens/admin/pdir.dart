import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PDIRScreen extends StatefulWidget {
  const PDIRScreen({Key? key}) : super(key: key);

  @override
  State<PDIRScreen> createState() => _PDIRScreenState();
}

class _PDIRScreenState extends State<PDIRScreen> {
  // Controllers for text fields
  final TextEditingController lotNumberController = TextEditingController();
  final TextEditingController batchNumberController = TextEditingController();
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController inspectionDateController =
      TextEditingController();
  final TextEditingController sampleSizeController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController approvedByController = TextEditingController();

  // Dropdowns
  String? selectedShift;
  String? selectedProductType;
  String? selectedFinalStatus;

  // Functionality test selections
  String? passFailTest;
  String? visualCheck;
  String? packagingIntegrity;
  String? cyclicTest;
  String? previousInspection;
  String? documentation;
  String? overallStatus;

  Color _getColor(String? selected, String option) {
    if (selected == option) {
      if (option == "Pass" ||
          option == "OK" ||
          option == "Verified" ||
          option == "Yes") {
        return Colors.green.shade400;
      } else if (option == "Fail" ||
          option == "NG" ||
          option == "Not Verified" ||
          option == "No") {
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
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Icons.arrow_back, color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Incoming\nInspections",
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
                  _buildTextField(
                    "Lot Number",
                    "Enter Lot Number",
                    lotNumberController,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    "Batch Number",
                    "Enter Batch Number",
                    batchNumberController,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    "Supplier Name",
                    "Enter Supplier Name",
                    supplierNameController,
                  ),
                  const SizedBox(height: 12),

                  // Shift & Sample Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdown(
                          title: "Shift",
                          hint: "Select Shift",
                          value: selectedShift,
                          items: ["Morning", "Evening", "Night"],
                          onChanged:
                              (val) => setState(() => selectedShift = val),
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          title: "Product Type",
                          hint: "Select Type",
                          value: selectedProductType,
                          items: ["Metal", "Plastic", "Rubber", "Other"],
                          onChanged:
                              (val) =>
                                  setState(() => selectedProductType = val),
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
                          "Enter Sample Size",
                          sampleSizeController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Functionality Test
                  const Text(
                    "Functionality Test",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Pass / Fail Check",
                    options: ["Pass", "Fail"],
                    selectedValue: passFailTest,
                    onChanged: (val) => setState(() => passFailTest = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Visual Check",
                    options: ["OK", "NG"],
                    selectedValue: visualCheck,
                    onChanged: (val) => setState(() => visualCheck = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Packaging Integrity",
                    options: ["OK", "NG"],
                    selectedValue: packagingIntegrity,
                    onChanged:
                        (val) => setState(() => packagingIntegrity = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Cyclic Test",
                    options: ["Verified", "Not Verified"],
                    selectedValue: cyclicTest,
                    onChanged: (val) => setState(() => cyclicTest = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Previous Inspection Record",
                    options: ["Yes", "No"],
                    selectedValue: previousInspection,
                    onChanged:
                        (val) => setState(() => previousInspection = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Documentation Complete",
                    options: ["Verified", "Not Verified"],
                    selectedValue: documentation,
                    onChanged: (val) => setState(() => documentation = val),
                  ),
                  const SizedBox(height: 10),
                  _buildToggleBox(
                    title: "Overall Status",
                    options: ["Pass", "Fail"],
                    selectedValue: overallStatus,
                    onChanged: (val) => setState(() => overallStatus = val),
                  ),
                  const SizedBox(height: 20),

                  // Approval Section
                  _buildTextField(
                    "Approved By",
                    "Enter Name",
                    approvedByController,
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    title: "Final Status",
                    hint: "Select Final Status",
                    value: selectedFinalStatus,
                    items: ["Accepted", "Rejected", "Hold"],
                    onChanged:
                        (val) => setState(() => selectedFinalStatus = val),
                  ),
                  const SizedBox(height: 12),

                  // Remarks
                  _buildTextField(
                    "Remarks",
                    "Add remarks here",
                    remarkController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),

                  // Upload Photos
                  _buildUploadBox(),
                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle form submit
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
                          fontWeight: FontWeight.w600,
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

  /// 🔹 Custom Text Field
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

  /// 🔹 Custom Dropdown
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

  /// 🔹 Toggle Button Box
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

  /// 🔹 Upload Box
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
            // TODO: handle upload logic
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red.shade200, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
