import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IncomingInspectionForm extends StatefulWidget {
  const IncomingInspectionForm({Key? key}) : super(key: key);

  @override
  State<IncomingInspectionForm> createState() => _IncomingInspectionFormState();
}

class _IncomingInspectionFormState extends State<IncomingInspectionForm> {
  // Step control
  int currentStep = 0;

  // Step 1 controllers and variables
  String? selectedMaterial;
  String? selectedSupplier;
  String? selectedDimension;
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController invoiceDateController = TextEditingController();
  final TextEditingController receivedDateController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  // Step 2 controllers and variables
  final TextEditingController sampleSizeController = TextEditingController();
  bool showDimensionalityCheck = false;
  bool showVisualCheck = false;
  String? selectedThickness;
  String? selectedWidth;
  List<String> selectedIssues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (currentStep == 0) {
              context.go('/home');
            } else {
              setState(() => currentStep = 0);
            }
          },
          icon: Icon(Icons.arrow_back, color: Colors.red),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Incoming Inspection\nReport Form",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Step indicator
            _buildStepIndicator(),
            const SizedBox(height: 20),

            // Conditional content based on step
            currentStep == 0 ? _buildStepOne() : _buildStepTwo(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: currentStep == 1 ? Colors.red : Colors.red.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepOne() {
    return Column(
      children: [
        // Material/Part Name
        _buildDropdownWithBorder(
          label: "Material/part name",
          value: selectedMaterial,
          items: ["Material A", "Material B", "Material C"],
          onChanged: (val) => setState(() => selectedMaterial = val),
        ),
        const SizedBox(height: 16),

        // Supplier Name
        _buildDropdownWithBorder(
          label: "Supplier Name",
          value: selectedSupplier,
          items: ["Supplier X", "Supplier Y", "Supplier Z"],
          onChanged: (val) => setState(() => selectedSupplier = val),
        ),
        const SizedBox(height: 16),

        // Dimension Of Material
        _buildDropdownWithBorder(
          label: "Dimension Of Material",
          value: selectedDimension,
          items: ["10x10", "20x20", "30x30"],
          onChanged: (val) => setState(() => selectedDimension = val),
        ),
        const SizedBox(height: 20),

        // TextFields
        _buildTextField(
          "Invoice No.",
          "Enter the Invoice number",
          invoiceNoController,
        ),
        _buildTextField("Invoice Date", "MM/DD/YYYY", invoiceDateController),
        _buildTextField(
          "Material Received Date",
          "MM/DD/YYYY",
          receivedDateController,
        ),
        _buildTextField(
          "Total Qty Received",
          "Enter the Quantity",
          qtyController,
        ),

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
              setState(() => currentStep = 1);
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
    );
  }

  Widget _buildStepTwo() {
    return Column(
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
              _buildTextFieldStep2(
                "Sample Size",
                "Enter the sample size",
                sampleSizeController,
              ),
              const SizedBox(height: 12),
              _buildUploadField("Dimension Of Material"),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Mode of Inspection - Toggle Buttons
        const Text(
          "Mode of Inspection",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInspectionModeButton(
                label: "Dimensionality Check",
                isSelected: showDimensionalityCheck,
                onTap: () {
                  setState(() {
                    showDimensionalityCheck = !showDimensionalityCheck;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInspectionModeButton(
                label: "Visually Check",
                isSelected: showVisualCheck,
                onTap: () {
                  setState(() {
                    showVisualCheck = !showVisualCheck;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Dimensionality Check Section
        if (showDimensionalityCheck) _buildDimensionalitySection(),
        if (showDimensionalityCheck && showVisualCheck)
          const SizedBox(height: 20),

        // Visual Check Section
        if (showVisualCheck) _buildVisuallyCheckSection(),

        const SizedBox(height: 20),

        // Submit Button
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
              context.go('/surfacecoatingform');
              debugPrint("Form Submitted");
            },
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Step 1 Widgets
  Widget _buildDropdownWithBorder({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.red.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red.shade200),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text("Select $label"),
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
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.red.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Step 2 Widgets
  Widget _buildInspectionModeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.red.shade50,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.red.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.white : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.red.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownStep2({
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
            color: Colors.white,
            border: Border.all(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text("Select $label"),
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

  Widget _buildTextFieldStep2(
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
            color: Colors.white,
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
          color: Colors.white,
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

  Widget _buildDimensionalitySection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dimensionality Check",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildDropdownStep2(
            label: "Thickness",
            value: selectedThickness,
            items: ["Thin", "Medium", "Thick"],
            onChanged: (val) => setState(() => selectedThickness = val),
          ),
          const SizedBox(height: 12),
          _buildDropdownStep2(
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
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Visually Check",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

  @override
  void dispose() {
    invoiceNoController.dispose();
    invoiceDateController.dispose();
    receivedDateController.dispose();
    qtyController.dispose();
    sampleSizeController.dispose();
    super.dispose();
  }
}
