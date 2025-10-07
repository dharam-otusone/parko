import 'package:flutter/material.dart';

class QcParametersScreen extends StatefulWidget {
  const QcParametersScreen({super.key});

  @override
  State<QcParametersScreen> createState() => _QcParametersScreenState();
}

class _QcParametersScreenState extends State<QcParametersScreen> {
  String selectedTab = 'Create Parameter';

  final TextEditingController materialController = TextEditingController();
  final TextEditingController parameterController = TextEditingController();
  final TextEditingController acceptanceController = TextEditingController();

  String? selectedStage;
  String? selectedMethod;
  String? selectedDataType;
  String? selectedModule;

  final List<String> stages = ['Incoming', 'Forming', 'Coating', 'Assembly'];
  final List<String> methods = ['Visual', 'Dimensional', 'Functional'];
  final List<String> dataTypes = ['Text', 'Numeric', 'Boolean'];
  final List<String> modules = ['Inspection', 'Production', 'Dispatch'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "QC Parameters Management",
          style: TextStyle(
            color: Color(0xFFEC3237),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------- Tabs ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab("Browse Parameters"),
                _buildTab("Create Parameter"),
                _buildTab("Statistics"),
              ],
            ),
            const SizedBox(height: 20),

            // ---------- Form Container ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEC3237), width: 1.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create New QC Parameter",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Process Stage Dropdown
                  _buildDropdownField(
                    title: "Process Stage",
                    hint: "Select Stage",
                    value: selectedStage,
                    items: stages,
                    onChanged: (val) => setState(() => selectedStage = val),
                  ),

                  _buildTextField(
                    "Material / Product",
                    "Enter material Name",
                    controller: materialController,
                  ),

                  _buildTextField(
                    "Parameter Name",
                    "Enter Parameter Name",
                    controller: parameterController,
                  ),

                  _buildDropdownField(
                    title: "Inspection Method",
                    hint: "Select Method",
                    value: selectedMethod,
                    items: methods,
                    onChanged: (val) => setState(() => selectedMethod = val),
                  ),

                  _buildDropdownField(
                    title: "Data Type",
                    hint: "Select Data Type",
                    value: selectedDataType,
                    items: dataTypes,
                    onChanged: (val) => setState(() => selectedDataType = val),
                  ),

                  _buildTextField(
                    "Acceptance Criteria",
                    "Enter Acceptance Criteria",
                    controller: acceptanceController,
                  ),

                  _buildDropdownField(
                    title: "Linked Module",
                    hint: "Select Module",
                    value: selectedModule,
                    items: modules,
                    onChanged: (val) => setState(() => selectedModule = val),
                  ),

                  const SizedBox(height: 20),

                  // ---------- Buttons ----------
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Parameter Saved!")),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFEC3237),
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save Parameter",
                            style: TextStyle(
                              color: Color(0xFFEC3237),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedStage = null;
                              selectedMethod = null;
                              selectedDataType = null;
                              selectedModule = null;
                              materialController.clear();
                              parameterController.clear();
                              acceptanceController.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Reset Form",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Tab Widget ----------
  Widget _buildTab(String title) {
    final isSelected = selectedTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? const Color(0xFFEC3237) : Colors.white,
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

  // ---------- Dropdown Field ----------
  Widget _buildDropdownField({
    required String title,
    required String hint,
    String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEC3237), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(border: InputBorder.none),
              hint: Text(hint, style: const TextStyle(color: Colors.grey)),
              items:
                  items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Text Field ----------
  Widget _buildTextField(
    String title,
    String hint, {
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFEC3237),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFEC3237),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFEC3237),
                  width: 1.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
