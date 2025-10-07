import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SurfaceCoatingInspection extends StatefulWidget {
  const SurfaceCoatingInspection({Key? key}) : super(key: key);

  @override
  State<SurfaceCoatingInspection> createState() =>
      _SurfaceCoatingInspectionState();
}

class _SurfaceCoatingInspectionState extends State<SurfaceCoatingInspection> {
  int currentStep = 1;

  // Step 1 fields
  final batchController = TextEditingController();
  final inspectionDateController = TextEditingController();
  final lotNumberController = TextEditingController();
  final certificateController = TextEditingController();
  final sampleSizeController = TextEditingController();

  String? selectedInspector;
  String? selectedShift;
  String? inspectionType;
  String? processType;

  // Step 2 dynamic
  List<CoatingSample> samples = [CoatingSample()];

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
          "Surface Coating\nInspection",
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
        child: currentStep == 1 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  // ---------------- STEP 1 ----------------
  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField("Batch Number *", "Enter number", batchController),
        const SizedBox(height: 16),
        _buildDropdown(
          label: "Inspector Name",
          value: selectedInspector,
          items: ["Inspector 1", "Inspector 2"],
          onChanged: (v) => setState(() => selectedInspector = v),
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
                items: ["Shift A", "Shift B"],
                onChanged: (v) => setState(() => selectedShift = v),
              ),
              const SizedBox(height: 12),
              _buildTextField(
                "Inspection Date",
                "DD/MM/YYYY",
                inspectionDateController,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Inspection Type",
                value: inspectionType,
                items: ["Type 1", "Type 2"],
                onChanged: (v) => setState(() => inspectionType = v),
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: "Process Type",
                value: processType,
                items: ["Manual", "Automatic"],
                onChanged: (v) => setState(() => processType = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField("Lot Number", "Enter number", lotNumberController),
        const SizedBox(height: 12),
        _buildTextField(
          "Incoming Certificate No",
          "Certificate No",
          certificateController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          "Sample Size",
          "Enter the sample size",
          sampleSizeController,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buttonOutlined("Previous", () {}),
            _buttonFilled("Next", () => setState(() => currentStep = 2)),
          ],
        ),
      ],
    );
  }

  // ---------------- STEP 2 ----------------
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Coating Thickness Measurement",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Measure thickness for each sample",
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 12),

        for (int i = 0; i < samples.length; i++) _buildSampleCard(i),

        _buttonOutlined("+ Add Another Sample", () {
          setState(() => samples.add(CoatingSample()));
        }, filled: true),

        const SizedBox(height: 25),
        _buildDropdown(
          label: "Visual Check",
          value: null,
          items: ["Passed", "Failed"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Adhesion Test",
          value: null,
          items: ["OK", "Not OK"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Color Consistency",
          value: null,
          items: ["Uniform", "Non-uniform"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Surface Defects",
          value: null,
          items: ["None", "Minor", "Major"],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        _buildDropdown(
          label: "Final Status",
          value: null,
          items: ["Approved", "Rejected"],
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
            _buttonOutlined("Previous", () => setState(() => currentStep = 1)),
            _buttonFilled("Submit", () {}, color: Colors.green),
          ],
        ),
      ],
    );
  }

  // ---------------- SAMPLE CARD ----------------
  Widget _buildSampleCard(int i) {
    final sample = samples[i];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTextField(
            "Minimum (microns)",
            "Enter minimum",
            sample.minController,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            "Maximum (microns)",
            "Enter maximum",
            sample.maxController,
          ),
          const SizedBox(height: 12),
          for (int j = 0; j < sample.dimensions.length; j++)
            _buildDimensionBox(sample, j),
          _buttonOutlined("+ Add Dimension", () {
            setState(() {
              sample.dimensions.add(CoatingDimension());
            });
          }, filled: true),
        ],
      ),
    );
  }

  // ---------------- DIMENSION BOX ----------------
  Widget _buildDimensionBox(CoatingSample sample, int index) {
    final dim = sample.dimensions[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Thickness (microns)",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    if (dim.thickness > 0) dim.thickness -= 0.1;
                  });
                },
              ),
              Text(
                dim.thickness.toStringAsFixed(1),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                onPressed: () {
                  setState(() {
                    dim.thickness += 0.1;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 🔽 Dropdown for Location
          Text(
            "Location",
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dim.selectedLocation,
                hint: const Text("Select location"),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: "Top Corner",
                    child: Text("Top Corner"),
                  ),
                  DropdownMenuItem(
                    value: "Bottom Corner",
                    child: Text("Bottom Corner"),
                  ),
                  DropdownMenuItem(
                    value: "Left Edge",
                    child: Text("Left Edge"),
                  ),
                  DropdownMenuItem(
                    value: "Right Edge",
                    child: Text("Right Edge"),
                  ),
                  DropdownMenuItem(value: "Center", child: Text("Center")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (val) {
                  setState(() {
                    dim.selectedLocation = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- COMMON WIDGETS ----------------
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
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: filled ? double.infinity : 130,
      height: 45,
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

// ---------------- DATA MODELS ----------------
class CoatingSample {
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  List<CoatingDimension> dimensions = [CoatingDimension()];
}

class CoatingDimension {
  double thickness = 0.0;
  String? selectedLocation;
}
