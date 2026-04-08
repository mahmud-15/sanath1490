import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/ForgotPasswordScreen/forgot_password_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/SignInScreen/sign_in_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/OnboardScreen/onboarding_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../../screens/BaseScreen/AuthScreen/AccountVerifyOtpScreen/account_verify_otp_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ChooseRoleScreen/choose_role_screen.dart';
import '../../screens/BaseScreen/AuthScreen/CreateAccountScreen/create_account_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ResetPassword/reset_password.dart';
import '../../screens/BaseScreen/AuthScreen/ResetVerifyOtpScreen/reset_verify_otp_screen.dart';
import '../bindings/authBindings.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[

  GetPage(name: AppRoutes.splashScreen,        page: () => SplashScreen()),
  GetPage(name: AppRoutes.onboardingScreen,    page: () => OnboardScreen()),
  GetPage(name: AppRoutes.signInScreen,        page: () => SignInScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.forgotPasswordScreen,page: () => ForgotPasswordScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.resetVerifyOtpScreen,     page: () => ResetVerifyOtpScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.resetPasswordScreen,     page: () => ResetPasswordScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.chooseRoleScreen,     page: () => ChooseRoleScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.createAccountScreen,     page: () => CreateAccountScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.accountVerifyOtpScreen,     page: () => AccountVerifyOtpScreen(),binding: AuthBindings()),

];