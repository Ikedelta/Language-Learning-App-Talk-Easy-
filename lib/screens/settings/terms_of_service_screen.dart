import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Easy Talk: Terms of Service and Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Effective Date: 2025',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Easy Talk! We are excited to support your language learning journey.\n'
              'Before you start using our app, please read these Terms of Service ("Terms") and Privacy Policy ("Policy") carefully.\n'
              'By accessing or using Easy Talk, you agree to be bound by these Terms and this Policy. If you do not agree, please do not use our Services.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '1. Use of Easy Talk',
              content:
                  'You must be at least 13 years old to use Easy Talk. By using the app, you affirm that you meet this age requirement. You are granted a limited, non-exclusive, non-transferable, and revocable license to use Easy Talk for personal, non-commercial, educational purposes only. You agree to use the app lawfully and responsibly.',
            ),
            _buildSection(
              title: '2. User Accounts',
              content:
                  'Some features require you to create an account. You must provide accurate, current information and maintain the confidentiality of your account credentials. You are responsible for all activities that occur under your account. We reserve the right to suspend or terminate your account if we suspect misuse or violation of these Terms.',
            ),
            _buildSection(
              title: '3. Content and Intellectual Property',
              content:
                  'All materials in Easy Talk—including lessons, texts, graphics, audio clips, videos, and software—are owned or licensed by us and are protected by intellectual property laws. You may not reproduce, distribute, modify, or publicly display any materials without our written permission, except for personal educational use.',
            ),
            _buildSection(
              title: '4. User-Generated Content',
              content:
                  'By submitting any content (such as voice recordings, text responses, or feedback), you grant us a non-exclusive, worldwide, royalty-free license to use, modify, adapt, publish, and display your content solely to operate and improve Easy Talk. You are responsible for ensuring that your content does not violate the rights of others or any applicable law.',
            ),
            _buildSection(
              title: '5. Prohibited Conduct',
              content:
                  'You agree not to misuse the app, upload malicious content, attempt unauthorized access, violate any law, or harass other users. Violations may result in immediate termination of your account.',
            ),
            _buildSection(
              title: '6. Modifications to the Service',
              content:
                  'We may change or discontinue any part of Easy Talk at any time without notice. We are not liable for any such modifications.',
            ),
            _buildSection(
              title: '7. Disclaimer of Warranties',
              content:
                  'Easy Talk is provided "as is" and "as available," without warranties of any kind. We do not guarantee uninterrupted or error-free service.',
            ),
            _buildSection(
              title: '8. Limitation of Liability',
              content:
                  'To the fullest extent permitted by law, Easy Talk and its affiliates will not be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the Service.',
            ),
            _buildSection(
              title: '9. Indemnification',
              content:
                  'You agree to indemnify and hold harmless Easy Talk, its owners, affiliates, and service providers against any claims arising out of your use of the Service, your violation of these Terms, or your infringement of any rights.',
            ),
            _buildSection(
              title: '10. Termination',
              content:
                  'We may suspend or terminate your access to Easy Talk at any time, without notice, for any reason, including violation of these Terms.',
            ),
            _buildSection(
              title: '11. Governing Law',
              content:
                  'These Terms shall be governed by the laws of Ghana. Any disputes shall be resolved exclusively in the courts located in Ghana.',
            ),
            _buildSection(
              title: '12. Changes to These Terms',
              content:
                  'We may revise these Terms at any time. Updated Terms will be posted with the revised "Effective Date." Continued use of Easy Talk constitutes your acceptance of the revised Terms.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}
