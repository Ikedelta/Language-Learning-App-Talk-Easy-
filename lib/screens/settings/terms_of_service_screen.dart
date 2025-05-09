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
              'Terms of Service for Easy Talk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Effective Date: March 15, 2024',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Easy Talk!\n\n'
              'These Terms of Service ("Terms") govern your use of the Easy Talk mobile application ("App," "Service," or "Services"). By accessing or using Easy Talk, you agree to these Terms. If you do not agree, please do not use our Services.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Use of Easy Talk',
              'You must be at least 13 years old to use Easy Talk. By using the app, you affirm that you meet this age requirement. You agree to use Easy Talk only for lawful purposes and in accordance with these Terms.\n\n'
                  'We grant you a limited, non-exclusive, non-transferable, and revocable license to use Easy Talk for personal, non-commercial educational purposes only.',
            ),
            _buildSection(
              '2. User Accounts',
              'To access certain features, you may be required to create an account. You agree to provide accurate, complete, and up-to-date information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.\n\n'
                  'We reserve the right to suspend or terminate your account if we suspect any unauthorized use or violation of these Terms.',
            ),
            _buildSection(
              '3. Content and Intellectual Property',
              'All materials in Easy Talk—including text, graphics, audio clips, video lessons, and software—are owned or licensed by us and are protected by intellectual property laws.\n\n'
                  'You may not reproduce, distribute, modify, create derivative works of, publicly display, publicly perform, republish, download, store, or transmit any material from Easy Talk without our prior written permission, except for personal and educational use.',
            ),
            _buildSection(
              '4. User-Generated Content',
              'Easy Talk may allow you to submit content, such as voice recordings, text responses, or feedback.\n\n'
                  'By submitting content, you grant us a non-exclusive, worldwide, royalty-free license to use, reproduce, modify, adapt, publish, and display such content for the purpose of operating and improving Easy Talk.\n\n'
                  'You are responsible for the content you submit and must ensure it does not violate any third-party rights, applicable laws, or these Terms.',
            ),
            _buildSection(
              '5. Prohibited Conduct',
              'You agree not to:\n\n'
                  '• Use the Service for any unlawful or unauthorized purpose\n'
                  '• Violate any local, state, national, or international law\n'
                  '• Interfere with the security or functionality of Easy Talk\n'
                  '• Upload viruses, malicious code, or attempt to gain unauthorized access to the Service\n'
                  '• Harass, abuse, or harm other users\n\n'
                  'Violation of these rules may result in immediate termination of your account.',
            ),
            _buildSection(
              '6. Modifications to the Service',
              'We may update, change, or discontinue any aspect of Easy Talk at any time without notice.\n\n'
                  'We are not liable to you or any third party for any modification, suspension, or discontinuation of the Service.',
            ),
            _buildSection(
              '7. Disclaimer of Warranties',
              'Easy Talk is provided "as is" and "as available" without warranties of any kind, either express or implied.\n\n'
                  'We do not guarantee that Easy Talk will always be available, secure, error-free, or that it will meet your expectations.\n\n'
                  'Use the Service at your own risk.',
            ),
            _buildSection(
              '8. Limitation of Liability',
              'To the fullest extent permitted by law, Easy Talk and its affiliates shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, arising from your use of the Service.\n\n'
                  'If we are found liable despite these limitations, our liability will not exceed the amount you paid us (if any) to use Easy Talk.',
            ),
            _buildSection(
              '9. Indemnification',
              'You agree to indemnify, defend, and hold harmless Easy Talk, its owners, affiliates, and service providers from and against any claims, damages, obligations, losses, liabilities, and expenses arising from your use of the Service, your violation of these Terms, or your violation of any rights of another.',
            ),
            _buildSection(
              '10. Termination',
              'We may terminate or suspend your access to Easy Talk at any time, without notice or liability, for any reason, including if you violate these Terms.\n\n'
                  'Upon termination, your right to use the Service will immediately cease.',
            ),
            _buildSection(
              '11. Governing Law',
              'These Terms shall be governed and interpreted in accordance with the laws of the Republic of Ghana, without regard to its conflict of laws principles.\n\n'
                  'Any disputes shall be resolved exclusively in the courts located in Ghana.',
            ),
            _buildSection(
              '12. Changes to These Terms',
              'We reserve the right to update or modify these Terms at any time.\n\n'
                  'When changes are made, we will update the "Effective Date" above and may provide additional notice (such as an in-app notification).\n\n'
                  'By continuing to use Easy Talk after any revisions, you agree to be bound by the updated Terms.',
            ),
            _buildSection(
              '13. Contact Us',
              'If you have any questions or concerns about these Terms, please contact us at:\n\n'
                  '📧 Email: easytalk@gmail.com\n'
                  '🌐 Website: easygroup.com',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 24),
      ],
    );
  }
}
