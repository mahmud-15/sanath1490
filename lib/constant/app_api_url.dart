import 'package:flutter/foundation.dart';
import '../utils/log_print.dart';

class AppApiUrl {
  AppApiUrl._privateConstructor();
  static final AppApiUrl _instance = AppApiUrl._privateConstructor();
  static AppApiUrl get instance => _instance;

  // Domain configuration
  static final String domain = _getDomain();
  static final String socket = _getDomain();
  final String baseUrl = "$domain/api/v1";
  final String imgBaseUrl = domain;

  // ==================== Auth ====================
  String register       = "/users";

  // ==================== Profile ====================
  String userProfile       = "/users/profile";
  String refreshToken      = "/refreshToken";
  // ==================== USER ====================
  String banner              = "/banners";


}

String _getDomain() {
  // const String liveServer  = "https://api.gogreenmatrix.my";
  const String localServer = "http://10.10.7.41:5005";

  try {
    if (kDebugMode) {
      return localServer;
    }
  } catch (e) {
    errorLog("_getDomain", e);
  }
  return localServer;
}