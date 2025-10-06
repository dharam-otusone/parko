import 'package:flutter/material.dart';

class IncomingInspectionForm extends StatefulWidget {
  const IncomingInspectionForm({Key? key}) : super(key: key);

  @override
  State<IncomingInspectionForm> createState() => _IncomingInspectionFormState();
}

class _IncomingInspectionFormState extends State<IncomingInspectionForm> {
  String? selectedMaterial;
  String? selectedSupplier;
  String? selectedDimension;

  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController invoiceDateController = TextEditingController();
  final TextEditingController receivedDateController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

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
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(8),
                color: Colors.red.shade50,
              ),
              child: Column(
                children: [
                  _buildDropdown(
                    label: "Material/part name",
                    value: selectedMaterial,
                    items: ["Material A", "Material B", "Material C"],
                    onChanged: (val) => setState(() => selectedMaterial = val),
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    label: "Supplier Name",
                    value: selectedSupplier,
                    items: ["Supplier X", "Supplier Y", "Supplier Z"],
                    onChanged: (val) => setState(() => selectedSupplier = val),
                  ),
                  const SizedBox(height: 12),
                  _buildDropdown(
                    label: "Dimension Of Material",
                    value: selectedDimension,
                    items: ["10x10", "20x20", "30x30"],
                    onChanged: (val) => setState(() => selectedDimension = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // TextFields
            _buildTextField(
              "Invoice No.",
              "Enter the Invoice number",
              invoiceNoController,
            ),
            _buildTextField(
              "Invoice Date",
              "MM/DD/YYYY",
              invoiceDateController,
            ),
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

            // Button
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
                  // Handle Next button action
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
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(label),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
      onChanged: onChanged,
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
}
