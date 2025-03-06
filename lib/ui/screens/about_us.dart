import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حول التطبيق'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text(
              'تمت برمجة هذا التطبيق من قبل شركة بوابة الهندسة للبحث والتطوير كجزء من مشروع "تحسين جودة المياه في شمال غرب سوريا"، والذي نفذته بالشراكة مع فيلد ريدي تركيا، ومهندسون بلا حدود - النرويج، وبتمويل من الوكالة النرويجية للابتكار.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'This application was programmed by Engineering Gate for Research and Development as part of the project “Enhancing Access to Safe Drinking Water in Northwest Syria”, which was implemented in partnership with Field Ready Türkiye and, Engineers Without Borders - Norway, and funded by the Innovation Norway.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/EngGate.png', width: 100, height: 100),
                    const SizedBox(width: 16),
                    Image.asset('assets/images/fieldReadyTurk.png', width: 100, height: 100),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/EngWithoutBord.png', width: 100, height: 100),
                    const SizedBox(width: 16),
                    Image.asset('assets/images/innov.png', width: 100, height: 100),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}