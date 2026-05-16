import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AppLoader/app_loader.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/contact_agent_controller.dart';

class ContactAgentScreen extends StatelessWidget {
  const ContactAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactAgentController>();

    return Scaffold(
      appBar: GlobalAppBar(title: 'Email Agent'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PropertyCard(controller: controller),
                      SizedBox(height: 20.h),

                      CustomTextFormField(
                        hintText: const CustomText(title: ConstString.yourName, textColor: ConstColor.bodyColor, textSize: 13),
                        textController: controller.nameController,
                        backgroundColor: ConstColor.white,
                        textInputAction: TextInputAction.next,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                      ),
                      CustomTextFormField(
                        hintText: const CustomText(title: ConstString.yourEmail, textColor: ConstColor.bodyColor, textSize: 13),
                        textController: controller.emailController,
                        backgroundColor: ConstColor.white,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Email is required';
                          if (!v.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hintText: const CustomText(title: ConstString.phoneNumber, textColor: ConstColor.bodyColor, textSize: 13),
                        textController: controller.phoneController,
                        backgroundColor: ConstColor.white,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Phone is required' : null,
                      ),
                      CustomTextFormField(
                        hintText: const CustomText(title: AutofillHints.postalCode, textColor: ConstColor.bodyColor, textSize: 13),
                        textController: controller.postalCodeController,
                        backgroundColor: ConstColor.white,
                        textInputAction: TextInputAction.next,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Postal code is required' : null,
                      ),

                      _CountryDropdown(controller: controller),
                      SizedBox(height: 8.h),

                      _MessageField(controller: controller),
                      SizedBox(height: 20.h),

                      _AgentCard(controller: controller),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),

            _SendButton(controller: controller),
          ],
        ),
      ),
    );
  }
}

// ─── Property Card ────────────────────────────────────
class _PropertyCard extends StatelessWidget {
  final ContactAgentController controller;

  const _PropertyCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.outLineColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: controller.propertyImage.value.isNotEmpty
                ? AppImage(
              url: controller.propertyImage.value,
              width: 72.w,
              height: 60.h,
              fit: BoxFit.cover,
            )
                : AppImage(
              path: 'assets/images/property_img.png',
              width: 72.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: controller.propertyPrice.value,
                  textColor: ConstColor.titleColor,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: controller.propertyAddress.value,
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

// ─── Country Dropdown ─────────────────────────────────
class _CountryDropdown extends StatelessWidget {
  final ContactAgentController controller;

  const _CountryDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.outLineColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            canvasColor: Colors.white,
          ),

          child: DropdownButton<String>(
            value: controller.selectedCountry.value,
            isExpanded: true,
            hint: CustomText(
              title: 'Country',
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              maxLine: 1,
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: ConstColor.bodyColor, size: 20.sp),
            style: TextStyle(
              fontSize: 13.sp,
              color: ConstColor.titleColor,
              fontFamily: 'Roboto',
            ),
            items: controller.countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: controller.onCountryChanged,
          ),
        ),
      ),
    ));
  }
}

// ─── Message Field ────────────────────────────────────
class _MessageField extends StatelessWidget {
  final ContactAgentController controller;

  const _MessageField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ConstColor.outLineColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: controller.messageController,
            maxLines: 6,
            maxLength: controller.maxMessageLength,
            onChanged: controller.onMessageChanged,
            style: TextStyle(
              fontSize: 13.sp,
              color: ConstColor.titleColor,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.all(14.w),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Obx(() => CustomText(
          title: '${controller.messageLength.value}/${controller.maxMessageLength} characters',
          textColor: ConstColor.bodyColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        )),
      ],
    );
  }
}

// ─── Agent Card ───────────────────────────────────────
class _AgentCard extends StatelessWidget {
  final ContactAgentController controller;

  const _AgentCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: [
        Container(
          width: 47.w,
          height: 47.h,
          decoration: BoxDecoration(
            color: ConstColor.titleColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: CustomText(
            title: controller.agentName.value.isNotEmpty
                ? controller.agentName.value.substring(0, 1).toUpperCase()
                : 'A',
            textColor: Colors.white,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: controller.agentName.value,
              textColor: ConstColor.titleColor,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            CustomText(
              title: controller.agentEmail.value,
              textColor: ConstColor.bodyColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ],
        ),
      ],
    ));
  }
}

// ─── Send Button ──────────────────────────────────────
class _SendButton extends StatelessWidget {
  final ContactAgentController controller;

  const _SendButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Obx(() => CustomElevatedButton(
        onPressed: controller.isLoading.value ? () {} : controller.onSend,
        color: ConstColor.primaryColor,
        height: 48,
        top: 0,
        left: 0,
        right: 0,
        child: controller.isLoading.value
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : CustomText(
          title: ConstString.send,
          textColor: Colors.white,
          textSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }
}