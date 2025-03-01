import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/ui/screens/complaint_screen.dart';
import 'package:water_azaz_project/ui/screens/water_quality_screen.dart';
import 'package:water_azaz_project/ui/screens/water_supply_screen.dart';

// Main Feedback Screen
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('بماذا نتسطيع مساعدتكم اليوم'), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconButton(
              icon: Icons.water_drop,
              label: 'تقييم جودة المياه',
              onPressed: () => Get.to(() => WaterQualityScreen()),
            ),
            _buildIconButton(
              icon: Icons.access_time,
              label: 'تقييم مدة الضخ',
              onPressed: () => Get.to(() => WaterSupplyScreen()),
            ),
            _buildIconButton(
              icon: Icons.report_problem,
              label: 'إرسال شكوى',
              onPressed: () => Get.to(() => ComplaintScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
      ),
    );
  }
}