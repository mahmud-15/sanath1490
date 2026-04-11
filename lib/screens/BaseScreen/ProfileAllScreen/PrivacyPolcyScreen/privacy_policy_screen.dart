import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  // ─── Terms sections data ──────────────────────────
  static const _sections = [
    _TermsSection(
      title: '1. Information We Collect',
      body:
      'We collect information you provide directly to us, including your name, email address, phone number, and payment information. We also collect information about your usage of the app, such as cards sent and received.',
    ),
    _TermsSection(
      title: '2. How We Use Your Information',
      body:
      'We use the information we collect to provide, maintain, and improve our services, process transactions, send you technical notices and support messages, and communicate with you about products, services, and events.',
    ),
    _TermsSection(
      title: '3. Data Security',
      body:
      'We implement appropriate security measures to protect your personal information. All payment data is encrypted using SSL technology. However, no method of transmission over the internet is 100% secure.',
    ),
    _TermsSection(
      title: '4. Information Sharing',
      body:
      'We do not sell, trade, or rent your personal information to third parties. We may share information with service providers who assist us in operating our app, conducting business, or serving users.',
    ),
    _TermsSection(
      title: '5.Your Rights',
      body:
      'You have the right to access, update, or delete your personal information at any time. You can also opt-out of marketing communications and request a copy of your data.',
    ),
    _TermsSection(
      title: '6. Intellectual Property',
      body:
      'All cards, designs, animations, music, and other content provided by Gift Moment are protected by copyright and intellectual property laws. Users may not reproduce, distribute, or create derivative works.',
    ),
    _TermsSection(
      title: '7. Data We Collect',
      body:
      'Refunds for digital card purchases are available within 24 hours of purchase if the card has not been sent. VIP subscriptions can be cancelled anytime, but refunds are not provided for partial months.',
    ),
    _TermsSection(
      title: '8. Service Modifications',
      body:
      'Gift Moment reserves the right to modify or discontinue the service at any time, with or without notice. We shall not be liable to you or any third party for any modification or discontinuance.',
    ),
    _TermsSection(
      title: '9. Privacy',
      body:
      'Your use of Gift Moment is also governed by our Privacy Policy. Please review our Privacy Policy to understand our practices regarding your personal data.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.privacyPolicy),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Last updated ──────────────────
              CustomText(
                title: 'Last updated: December 30, 2025',
                textColor: ConstColor.bodyColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
              SizedBox(height: 14.h),

              // ─── Sections ──────────────────────
              ..._sections.map((s) => _TermsSectionWidget(section: s)),
            ],
          ),
        ),
      ),
    );
  }
}


class _TermsSection {
  final String title;
  final String body;

  const _TermsSection({required this.title, required this.body});
}

class _TermsSectionWidget extends StatelessWidget {
  final _TermsSection section;

  const _TermsSectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: section.title,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLine: 2,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: section.body,
            textColor: ConstColor.titleColor,
            textSize: 12.sp,
            fontWeight: FontWeight.w400,
            maxLine: 20,
            textHeight: 1.6,
          ),
        ],
      ),
    );
  }
}