import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/log_print.dart';

class StorageKey {
  StorageKey._privateConstructor();
  static final StorageKey _instance = StorageKey._privateConstructor();
  static StorageKey get instance => _instance;

  final String storageContainerKey = "storageContainerKey";
  final String loginDataStore = "loginDataStore";
  final String token = "token";
  final String refreshToken = "refreshToken";
  final String user = "user";
  final String language = "language";
  final String isDarkMode = "isDarkMode";
  final String appFirstTime = "appFirstTime";
  final String appUserRollData = "appUserRollData";
  final String selectedRole = "selectedRole";
}

class StorageServices {
  StorageServices._privateConstructor();
  static final StorageServices _instance = StorageServices._privateConstructor();
  static StorageServices get instance => _instance;

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  // ==================== Login Data ====================
  Future<void> setLogDedData(Map<String, dynamic> data) async {
    try {
      final pref = await _pref;
      var formateData = jsonEncode(data);
      await pref.setString(StorageKey.instance.loginDataStore, formateData);
    } catch (e) {
      errorLog("setLogDedData data", e);
    }
  }

  Future<Map<String, dynamic>> getLogDedData() async {
    try {
      final pref = await _pref;
      var response = pref.getString(StorageKey.instance.loginDataStore) ?? "";
      if (response.isEmpty) return {};
      return jsonDecode(response);
    } catch (e) {
      errorLog("getLogDedData", e);
      return {};
    }
  }

  // ==================== Token ====================
  Future<void> setToken(String value) async {
    final pref = await _pref;
    await pref.setString(StorageKey.instance.token, value);
  }

  Future<String> getToken() async {
    try {
      final pref = await _pref;
      return pref.getString(StorageKey.instance.token) ?? "";
    } catch (e) {
      errorLog("get token", e);
      return "";
    }
  }

  // ==================== Refresh Token ====================
  Future<void> setRefreshToken(String value) async {
    final pref = await _pref;
    await pref.setString(StorageKey.instance.refreshToken, value);
  }

  Future<String> getRefreshToken() async {
    try {
      final pref = await _pref;
      return pref.getString(StorageKey.instance.refreshToken) ?? "";
    } catch (e) {
      errorLog("get refreshToken", e);
      return "";
    }
  }

  // ==================== User Role (Existing - Keep as is) ====================
  Future<String> getAppRoll() async {
    final pref = await _pref;
    return pref.getString(StorageKey.instance.appUserRollData) ?? "";
  }

  Future<void> setAppRoll(String value) async {
    final pref = await _pref;
    await pref.setString(StorageKey.instance.appUserRollData, value);
  }

  // ==================== Selected Role (NEW - For Role Selection) ====================
  /// ✅ Save selected role from Role Selection Screen
  Future<void> saveSelectedRole(String role) async {
    try {
      final pref = await _pref;
      await pref.setString(StorageKey.instance.selectedRole, role);
    } catch (e) {
      errorLog("saveSelectedRole", e);
    }
  }

  /// ✅ Get selected role
  Future<String?> getSelectedRole() async {
    try {
      final pref = await _pref;
      return pref.getString(StorageKey.instance.selectedRole);
    } catch (e) {
      errorLog("getSelectedRole", e);
      return null;
    }
  }

  /// ✅ Clear selected role
  Future<void> clearSelectedRole() async {
    try {
      final pref = await _pref;
      await pref.remove(StorageKey.instance.selectedRole);
    } catch (e) {
      errorLog("clearSelectedRole", e);
    }
  }

  // ==================== Logout ====================
  Future<void> logout() async {
    try {
      final pref = await _pref;
      await pref.remove(StorageKey.instance.refreshToken);
      await pref.remove(StorageKey.instance.token);
      await pref.remove(StorageKey.instance.appUserRollData);
      await pref.remove(StorageKey.instance.loginDataStore);
      await pref.remove(StorageKey.instance.selectedRole);
    } catch (e) {
      errorLog("logout", e);
    }
  }

  // ==================== Language ====================
  Future<String> getLanguage() async {
    final pref = await _pref;
    return pref.getString(StorageKey.instance.language) ?? "";
  }

  Future<void> setLanguage(String value) async {
    final pref = await _pref;
    await pref.setString(StorageKey.instance.language, value);
  }

  // ==================== First Time Flag ====================
  Future<bool> getAppFirstTime() async {
    final pref = await _pref;
    return pref.getBool(StorageKey.instance.appFirstTime) ?? true;
  }

  Future<void> setAppFirstTime() async {
    try {
      final pref = await _pref;
      await pref.setBool(StorageKey.instance.appFirstTime, false);
    } catch (e) {
      errorLog("setAppFirstTime", e);
    }
  }

  // ==================== Dark Mode ====================
  Future<bool> isDarkMode() async {
    final pref = await _pref;
    return pref.getBool(StorageKey.instance.isDarkMode) ?? true;
  }

  Future<void> setDarkMode(bool value) async {
    final pref = await _pref;
    await pref.setBool(StorageKey.instance.isDarkMode, value);
  }
}