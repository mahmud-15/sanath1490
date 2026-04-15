import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';

class BillingHistoryScreen extends StatelessWidget {
  const BillingHistoryScreen({super.key});

  static const _invoices = [
    _InvoiceModel(id: 'INV-2024-003', plan: 'Professional', period: 'March 2024',    amount: '£99.00', date: '2024-03-10'),
    _InvoiceModel(id: 'INV-2024-002', plan: 'Professional', period: 'February 2024', amount: '£99.00', date: '2024-02-10'),
    _InvoiceModel(id: 'INV-2024-001', plan: 'Professional', period: 'January 2024',  amount: '£99.00', date: '2024-01-10'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.billingHistory),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ConstColor.iconColor.withAlpha(80), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Invoice header ───────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 6.h),
                child: CustomText(
                  title: ConstString.invoice,
                  textColor: ConstColor.titleColor,
                  textSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),

              // ─── Invoice rows ─────────────────
              ...List.generate(_invoices.length, (index) {
                final item = _invoices[index];
                final isLast = index == _invoices.length - 1;
                return _InvoiceRow(item: item, showDivider: !isLast);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Single invoice row
class _InvoiceRow extends StatelessWidget {
  final _InvoiceModel item;
  final bool showDivider;

  const _InvoiceRow({required this.item, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // ─── ID + Plan/Period ──────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: item.id,
                      textColor: ConstColor.titleColor,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 3.h),
                    CustomText(
                      title: '${item.plan} • ${item.period}',
                      textColor: ConstColor.bodyColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              // ─── Amount + Date ─────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    title: item.amount,
                    textColor: ConstColor.titleColor,
                    textSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 3.h),
                  CustomText(
                    title: item.date,
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),

              SizedBox(width: 12.w),

              // ─── Download button ───────────────
              GestureDetector(
                onTap: () {
                  // TODO: download invoice PDF
                },
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: ConstColor.outLineColor,width: 1.5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/download_icon.svg',
                      width: 16.w,
                      colorFilter: ColorFilter.mode(ConstColor.titleColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1.h, indent: 16.w, endIndent: 16.w, color: ConstColor.outLineColor),
      ],
    );
  }
}

// Invoice data model
class _InvoiceModel {
  final String id;
  final String plan;
  final String period;
  final String amount;
  final String date;

  const _InvoiceModel({
    required this.id,
    required this.plan,
    required this.period,
    required this.amount,
    required this.date,
  });
}