import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.red.shade400,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button + Profile Image
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Color.fromRGBO(239, 70, 55, 0.1),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              'https://www.istockphoto.com/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online-gm1300972574-393136108',
                            ), // Replace with your image
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Swati Jha",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 4, color: Colors.red),
                  const SizedBox(width: 16),
                  // Right-side details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _detailRow("Employee ID", "EMP-2023-001"),
                        _detailRow("User Name", "johndoe1_69"),
                        _detailRow("Full Name", "Swati kumari jha"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Status",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: const [
                                Switch(
                                  value: true,
                                  onChanged: null,
                                  activeColor: Colors.green,
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Details Card
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.red.shade400,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile(
                        Icons.email_outlined,
                        "Email",
                        "swatijhakumari@gmail.com",
                      ),
                      _infoTile(Icons.lock_outline, "Role", "Quality Head"),
                      _infoTile(
                        Icons.apartment_outlined,
                        "Department",
                        "Quality Control",
                      ),
                      _infoTile(Icons.calendar_today, "Shifts", "Day"),
                      _infoTile(
                        Icons.assignment,
                        "Assigned Processes",
                        "Incoming",
                      ),
                      _infoTile(
                        Icons.access_time,
                        "Last Login",
                        "2023-10-25 14:30:25",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Logout Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.go('/editprofile');
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for right-side details
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for info tiles inside white card
  Widget _infoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
