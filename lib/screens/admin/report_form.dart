import 'package:flutter/material.dart';

class FormingInspectionReportForm extends StatefulWidget {
  const FormingInspectionReportForm({Key? key}) : super(key: key);

  @override
  State<FormingInspectionReportForm> createState() =>
      _FormingInspectionReportFormState();
}

class _FormingInspectionReportFormState
    extends State<FormingInspectionReportForm> {
  int currentStep = 1;

  // Step 1 controllers
  final TextEditingController batchNumberController = TextEditingController();
  final TextEditingController inspectionDateController =
      TextEditingController();

  String? selectedInspector;
  String? selectedShift;
  String? selectedMachineId;
  String? selectedSampleSize;

  // Step 2 dynamic data
  List<Sample> samples = [Sample()];

  // ---------- BUILD ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Forming Inspection\nReport Form",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: currentStep == 1 ? _buildStep1(context) : _buildStep2(context),
      ),
    );
  }

  // ---------- STEP 1 ----------
  Widget _buildStep1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(
          "Batch Number *",
          "Enter number",
          batchNumberController,
        ),
        const SizedBox(height: 16),
        _buildDropdown(
          label: "Inspector Name",
          value: selectedInspector,
          items: ["Inspector 1", "Inspector 2", "Inspector 3"],
          onChanged: (val) => setState(() => selectedInspector = val),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildDropdown(
                label: "Shift",
                value: selectedShift,
                items: ["Shift A", "Shift B", "Shift C"],
                onChanged: (val) => setState(() => selectedShift = val),
              ),
              const SizedBox(height: 12),
              _buildTextField(
                "Inspection Date",
                "DD/MM/YYYY",
                inspectionDateController,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Machine ID",
                value: selectedMachineId,
                items: ["M-101", "M-102", "M-103"],
                onChanged: (val) => setState(() => selectedMachineId = val),
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Sample Size",
                value: selectedSampleSize,
                items: ["5", "10", "15"],
                onChanged: (val) => setState(() => selectedSampleSize = val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buttonOutlined("Previous", () {}),
            _buttonFilled("Next", () {
              setState(() {
                currentStep = 2;
              });
            }),
          ],
        ),
      ],
    );
  }

  // ---------- STEP 2 ----------
  Widget _buildStep2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Dimensional Inspection",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Add measurement details for each sample",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 12),

        // Samples
        for (int i = 0; i < samples.length; i++) _buildSampleCard(i),

        const SizedBox(height: 20),
        _buttonOutlined("+ Add Another Sample", () {
          setState(() {
            samples.add(Sample());
          });
        }, filled: true),

        const SizedBox(height: 25),
        _buildDropdown(
          label: "Overall Sample Status",
          value: null,
          items: ["Approved", "Rejected", "Pending"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Surface Finish",
          value: null,
          items: ["Good", "Average", "Poor"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Deformation",
          value: null,
          items: ["None", "Minor", "Major"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Final Status",
          value: null,
          items: ["OK", "Not OK"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Visual Check",
          value: null,
          items: ["Passed", "Failed"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),
        _buildTextField(
          "Remark",
          "Add any additional remarks",
          TextEditingController(),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        _uploadPhotoBox(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buttonOutlined("Previous", () {
              setState(() {
                currentStep = 1;
              });
            }),
            _buttonFilled("Submit", () {
              debugPrint("Form submitted");
            }, color: Colors.green),
          ],
        ),
      ],
    );
  }

  // ---------- BUILD SAMPLE ----------
  Widget _buildSampleCard(int sampleIndex) {
    final sample = samples[sampleIndex];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          for (int j = 0; j < sample.dimensions.length; j++)
            _buildDimensionBox(sample, j),
          const SizedBox(height: 8),
          _buttonOutlined("+ Add Dimension", () {
            setState(() {
              sample.dimensions.add(Dimension());
            });
          }, filled: true),
        ],
      ),
    );
  }

  Widget _buildDimensionBox(Sample sample, int index) {
    final dim = sample.dimensions[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildDropdown(
            label: "Parameter",
            value: dim.parameter,
            items: ["Length", "Width", "Height"],
            onChanged: (val) => setState(() => dim.parameter = val),
          ),
          const SizedBox(height: 8),
          _buildDropdown(
            label: "Measurement",
            value: dim.measurement,
            items: ["mm", "cm", "inch"],
            onChanged: (val) => setState(() => dim.measurement = val),
          ),
          const SizedBox(height: 8),
          _buildTextField(
            "Tolerance",
            "Enter the Tolerance",
            dim.toleranceController,
          ),
          const SizedBox(height: 8),
          _buildDropdown(
            label: "Status",
            value: dim.status,
            items: ["OK", "Not OK"],
            onChanged: (val) => setState(() => dim.status = val),
          ),
        ],
      ),
    );
  }

  // ---------- COMMON COMPONENTS ----------

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
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
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
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text("Select ${label.split(' ').first}"),
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

  Widget _buttonFilled(
    String text,
    VoidCallback onTap, {
    Color color = Colors.red,
  }) {
    return SizedBox(
      height: 50,
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buttonOutlined(
    String text,
    VoidCallback onTap, {
    bool filled = false,
  }) {
    return SizedBox(
      height: 45,
      width: filled ? double.infinity : 130,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? Colors.red.shade100 : Colors.white,
          side: BorderSide(color: filled ? Colors.red.shade100 : Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: filled ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _uploadPhotoBox() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.shade50,
      ),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.upload_rounded, color: Colors.red),
          SizedBox(height: 6),
          Text("Tap to upload photo", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

// ---------- DATA MODELS ----------
class Sample {
  List<Dimension> dimensions = [Dimension()];
}

class Dimension {
  String? parameter;
  String? measurement;
  String? status;
  final TextEditingController toleranceController = TextEditingController();
}
