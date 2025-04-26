import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy for Easy Talk',
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
              'Thank you for choosing Easy Talk! We are committed to protecting your privacy and ensuring that your personal information is handled securely and responsibly. This Privacy Policy explains how we collect, use, and safeguard your information when you use our language learning app.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'When you use Easy Talk, we may collect the following types of information:\n\n'
              '• Personal Information such as your name, email address, and any details you provide when creating an account\n'
              '• Profile Data including language preferences and optional profile photos\n'
              '• Usage Data such as lessons completed, time spent learning, features used, and crash logs\n'
              '• Device Information like device model, operating system, app version, and unique device identifiers\n'
              '• Voice and Text Data when you use speech recognition or chat features, though voice recordings are not stored unless explicitly stated and consented to',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We use the information we collect to:\n\n'
              '• Provide, personalize, and improve your learning experience\n'
              '• Communicate with you about updates, features, and offers\n'
              '• Monitor and analyze trends and usage to improve our services\n'
              '• Ensure the security and functionality of the app\n'
              '• Comply with legal obligations\n\n'
              'We do not sell your personal information to third parties.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Information Sharing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may share your information with:\n\n'
              '• Trusted Service Providers who help us operate Easy Talk (e.g., hosting, analytics)\n'
              '• When required by Legal Requirements\n'
              '• In Business Transfers in the case of a merger, acquisition, or sale of assets\n\n'
              'All service providers are required to protect your information in accordance with this policy.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Rights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You have the right to:\n\n'
              '• Access, correct, or delete your personal information\n'
              '• Withdraw consent where applicable\n'
              '• Opt out of non-essential communications\n\n'
              'To exercise these rights, please contact us at easytalk@gmail.com',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We implement industry-standard security measures to protect your data from unauthorized access, alteration, or destruction. However, no method of transmission over the internet or method of electronic storage is completely secure.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Children\'s Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Easy Talk is intended for users aged 13 years and older. We do not knowingly collect personal information from children under 13 without verifiable parental consent. If you believe we have collected such information, please contact us immediately.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Changes to This Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We may update this Privacy Policy from time to time. Significant changes will be communicated through the app, and the "Effective Date" will be revised accordingly. Continued use of Easy Talk after updates means you accept the changes.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you have any questions or concerns about this Privacy Policy or our practices, please contact us at:\n\n'
              '📧 Email: easytalk@gmail.com\n'
              '🌐 Website: easygroup.com\n\n'
              'At Easy Talk, your privacy matters. We only collect what we need to help you learn better and keep your data safe. We don\'t sell your information. You control your data, and you can contact us anytime with questions.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
