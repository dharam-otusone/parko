import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class IncomingInspectionDynamicForm extends StatefulWidget {
  const IncomingInspectionDynamicForm({Key? key}) : super(key: key);

  @override
  State<IncomingInspectionDynamicForm> createState() =>
      _IncomingInspectionDynamicFormState();
}

class _IncomingInspectionDynamicFormState
    extends State<IncomingInspectionDynamicForm> {
  final TextEditingController sampleSizeController = TextEditingController();

  String? selectedModeOfInspection; // Dropdown selection
  String? selectedThickness;
  String? selectedWidth;
  List<String> selectedIssues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Incoming Inspection\nReport Form",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Main Form Section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red.shade50,
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          "Sample Size",
                          "Enter the sample size",
                          sampleSizeController,
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          label: "Mode of Inspection",
                          value: selectedModeOfInspection,
                          items: ["Dimensionality Check", "Visually Check"],
                          onChanged:
                              (val) => setState(
                                () => selectedModeOfInspection = val,
                              ),
                        ),
                        const SizedBox(height: 12),
                        _buildUploadField("Dimension Of Material"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dynamic Section Based on Mode
                  if (selectedModeOfInspection == "Dimensionality Check")
                    _buildDimensionalitySection()
                  else if (selectedModeOfInspection == "Visually Check")
                    _buildVisuallyCheckSection(),

                  const SizedBox(height: 20),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Form Submitted");
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- UI Components ---------- //

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            border: Border.all(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text("Select ${label}"),
              isExpanded: true,
              items:
                  items
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
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
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            border: Border.all(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadField(String label) {
    return InkWell(
      onTap: () {
        debugPrint("Upload Photo tapped");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
          color: Colors.red.shade50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54)),
            const Icon(Icons.upload_file, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green.shade100,
                  side: BorderSide(color: Colors.green.shade300),
                ),
                onPressed: () {},
                child: const Text("Approved"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  side: BorderSide(color: Colors.red.shade300),
                ),
                onPressed: () {},
                child: const Text("Rejected"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 45),
            backgroundColor: Colors.yellow.shade100,
            side: BorderSide(color: Colors.yellow.shade600),
          ),
          onPressed: () {},
          child: const Text("Hold"),
        ),
      ],
    );
  }

  // ---------- Dynamic Sections ---------- //

  Widget _buildDimensionalitySection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dimensionality Check",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            label: "Thickness",
            value: selectedThickness,
            items: ["Thin", "Medium", "Thick"],
            onChanged: (val) => setState(() => selectedThickness = val),
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            label: "Width",
            value: selectedWidth,
            items: ["Narrow", "Medium", "Wide"],
            onChanged: (val) => setState(() => selectedWidth = val),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildVisuallyCheckSection() {
    final issues = ["Rusty", "Dent", "Deformity", "Scratch"];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Visually Check",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children:
                issues.map((issue) {
                  return ChoiceChip(
                    label: Text(issue),
                    selected: selectedIssues.contains(issue),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedIssues.add(issue);
                        } else {
                          selectedIssues.remove(issue);
                        }
                      });
                    },
                    selectedColor: Colors.red.shade200,
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }
}
