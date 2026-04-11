import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/faq_controller.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.faq),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: ListView.separated(           // ← Obx সরিয়ে দিলাম এখান থেকে
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.faqs.length,
            separatorBuilder: (_, __) => Divider(
              height: 1.h,
              color: ConstColor.outLineColor,
            ),
            itemBuilder: (context, index) {
              final faq = controller.faqs[index];

              return Obx(() => _FaqItem(       // ← Obx এখানে দিলাম (প্রত্যেক item এ)
                question: faq.question,
                answer: faq.answer,
                isExpanded: controller.expandedIndex.value == index,
                onTap: () => controller.toggleFaq(index),
                isFirst: index == 0,
                isLast: index == controller.faqs.length - 1,
              ));
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Single expandable FAQ item
// ─────────────────────────────────────────────────────
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _FaqItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: isFirst ? Radius.circular(14.r) : Radius.zero,
        topRight: isFirst ? Radius.circular(14.r) : Radius.zero,
        bottomLeft: isLast ? Radius.circular(14.r) : Radius.zero,
        bottomRight: isLast ? Radius.circular(14.r) : Radius.zero,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Question row ──────────────────
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      title: question,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 3,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ),
                ],
              ),

              // ─── Answer (visible when expanded) ─
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CustomText(
                    title: answer,
                    textColor: ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 10,
                    textHeight: 1.6,
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}