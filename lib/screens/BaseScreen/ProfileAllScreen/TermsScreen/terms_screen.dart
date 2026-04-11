import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  // ─── Terms sections data ──────────────────────────
  static const _sections = [
    _TermsSection(
      title: '1. Acceptance of Terms',
      body:
      'By accessing and using Gift Moment, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
    ),
    _TermsSection(
      title: '2. Use License',
      body:
      'Permission is granted to temporarily download one copy of Gift Moment for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
    ),
    _TermsSection(
      title: '3. Subscription & Payments',
      body:
      'VIP subscriptions are billed monthly at €4.99. Premium cards and VIP videos are one-time purchases. All payments are processed securely. Subscriptions auto-renew unless cancelled 24 hours before the renewal date.',
    ),
    _TermsSection(
      title: '4. User Accounts',
      body:
      'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account or password.',
    ),
    _TermsSection(
      title: '5. Content Guidelines',
      body:
      'Users must not send cards containing offensive, abusive, or illegal content. Gift Moment reserves the right to remove any content that violates these terms and suspend or terminate accounts.',
    ),
    _TermsSection(
      title: '6. Intellectual Property',
      body:
      'All cards, designs, animations, music, and other content provided by Gift Moment are protected by copyright and intellectual property laws. Users may not reproduce, distribute, or create derivative works.',
    ),
    _TermsSection(
      title: '7. Refund Policy',
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
      appBar: GlobalAppBar(title: 'Terms & Conditions'),
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
                textSize: 11.sp,
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

// ─────────────────────────────────────────────────────
// Data class for each terms section
// ─────────────────────────────────────────────────────
class _TermsSection {
  final String title;
  final String body;

  const _TermsSection({required this.title, required this.body});
}

// ─────────────────────────────────────────────────────
// UI widget for each terms section
// ─────────────────────────────────────────────────────
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
            textSize: 13.sp,
            fontWeight: FontWeight.w700,
            maxLine: 2,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: section.body,
            textColor: ConstColor.bodyColor,
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