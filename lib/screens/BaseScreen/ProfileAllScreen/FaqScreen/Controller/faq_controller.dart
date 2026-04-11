import 'package:get/get.dart';

class FaqController extends GetxController {
  // ─── Currently expanded FAQ index (-1 = none) ────
  final expandedIndex = (-1).obs;

  // ─── Toggle expand/collapse ───────────────────────
  void toggleFaq(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }

  // ─── FAQ data ─────────────────────────────────────
  final faqs = [
    FaqModel(
      question: 'How do I add a new property listing?',
      answer:
      'Go to the Listings tab and tap "Add New Listing". Fill in all property details, upload photos, and tap Publish.',
    ),
    FaqModel(
      question: 'How do featured listings work?',
      answer:
      'Featured listings appear at the top of search results and are highlighted with a badge. You can upgrade any listing to featured from your dashboard.',
    ),
    FaqModel(
      question: 'When will I receive enquiry notifications?',
      answer:
      'You will receive a push notification and email immediately when someone sends an enquiry on one of your listings.',
    ),
    FaqModel(
      question: 'How do I change my subscription plan?',
      answer:
      'Go to Profile > Subscription to view and change your current plan. Changes take effect at the start of your next billing cycle.',
    ),
    FaqModel(
      question: 'Can I export my payment history?',
      answer:
      'Yes. Go to Profile > Subscription > Payment History and tap Export to download a PDF of your invoices.',
    ),
    FaqModel(
      question: 'How do I get my listings approved faster?',
      answer:
      'Ensure all required fields are filled, photos are high quality, and the property address is verified. Complete listings are typically approved within 2 hours.',
    ),
  ];
}

// ─────────────────────────────────────────────────────
class FaqModel {
  final String question;
  final String answer;

  FaqModel({required this.question, required this.answer});
}