import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/ForgotPasswordScreen/forgot_password_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/AuthScreen/SignInScreen/sign_in_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/NavBar/nav_bar.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/OnboardScreen/onboarding_screen.dart';
import 'package:sanath1490_flutter_app/screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../../screens/AgentScreen/EnquiriesTabScreen/EnquiriesScreen/enquiries_screen.dart';
import '../../screens/AgentScreen/MyListingTabScreen/MyListingScreen/my_listing_screen.dart';
import '../../screens/AgentScreen/OverViewTabScreen/AddNewListingScreen/add_new_listing_screen.dart';
import '../../screens/AgentScreen/OverViewTabScreen/BillingHistoryScreen/billing_history_screen.dart';
import '../../screens/AgentScreen/OverViewTabScreen/OverViewHomeScreen/overviewHomeScreen.dart';
import '../../screens/AgentScreen/OverViewTabScreen/SubscriptionScreen/subscriptionScreen.dart' hide Overviewhomescreen;
import '../../screens/BaseScreen/AuthScreen/AccountVerifyOtpScreen/account_verify_otp_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ChooseRoleScreen/choose_role_screen.dart';
import '../../screens/BaseScreen/AuthScreen/CreateAccountScreen/create_account_screen.dart';
import '../../screens/BaseScreen/AuthScreen/ResetPassword/reset_password.dart';
import '../../screens/BaseScreen/AuthScreen/ResetVerifyOtpScreen/reset_verify_otp_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/AboutUsScreen/about_us_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/ChangePasswordScreen/change_password_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/DeleteAccountBottomSheet/Widget/account_deleted_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/FaqScreen/faq_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/NotificationSettingsScreen/notification_settings_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/PersonalInfoScreen/personal_info_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/PrivacyPolcyScreen/privacy_policy_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/ProfileScreen/profile_screen.dart';
import '../../screens/BaseScreen/ProfileAllScreen/TermsScreen/terms_screen.dart';
import '../../screens/UserScreen/EnquiriesScreen/enquiries_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ContactAgentScreen/contact_agent_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/DegreeTourScreen/degree_tour_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FilterScreen/filter_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/GalleryDetailsScreen/gallery_details_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyDetailsScreen/property_details_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/PropertyListScreen/property_list_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/SearchScreen/search_screen.dart';
import '../../screens/UserScreen/SavedTabScreen/SavedPropertiesScreen/saved_properties_screen.dart';
import '../bindings/authBindings.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[


  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen,        page: () => SplashScreen()),
  GetPage(name: AppRoutes.onboardingScreen,    page: () => OnboardScreen()),
  GetPage(name: AppRoutes.signInScreen,        page: () => SignInScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.forgotPasswordScreen,page: () => ForgotPasswordScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.resetVerifyOtpScreen,     page: () => ResetVerifyOtpScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.resetPasswordScreen,     page: () => ResetPasswordScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.chooseRoleScreen,     page: () => ChooseRoleScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.createAccountScreen,     page: () => CreateAccountScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.accountVerifyOtpScreen,     page: () => AccountVerifyOtpScreen(),binding: AuthBindings()),





  ///////////////NavBar////////////////
  GetPage(name: AppRoutes.navBar,     page: () => NavBar(),binding: AuthBindings()),



  ///////////////Home Screen Part////////////////
  GetPage(name: AppRoutes.homeScreen,     page: () => HomeScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.filterScreen,     page: () => FilterScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.searchScreen,     page: () => SearchScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.propertyListScreen,     page: () => PropertyListScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.propertyDetails,     page: () => PropertyDetailsScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.galleryDetailsScreen,     page: () => GalleryDetailsScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.degreeTourScreen,     page: () => DegreeTourScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.contactAgentScreen,     page: () => ContactAgentScreen(),binding: AuthBindings()),


  ///////////////Saved Screen Part////////////////
  GetPage(name: AppRoutes.savedPropertiesScreen,     page: () => SavedPropertiesScreen(),binding: AuthBindings()),


  ///////////////Enquiries Screen Part////////////////
  GetPage(name: AppRoutes.enquiriesScreen,     page: () => EnquiriesScreen(),binding: AuthBindings()),

  ///////////////Profile Screen Part////////////////
  GetPage(name: AppRoutes.profileScreen,     page: () => ProfileScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.personalInfoScreen,     page: () => PersonalInfoScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.changePasswordScreen,     page: () => ChangePasswordScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.notificationSettingsScreen,     page: () => NotificationSettingsScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.aboutUsScreen,     page: () => AboutUsScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.termsScreen,     page: () => TermsScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.privacyPolicyScreen,     page: () => PrivacyPolicyScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.faqScreen,     page: () => FaqScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.accountDeletedScreen,     page: () => AccountDeletedScreen(),binding: AuthBindings()),




  ///////////////Agent OverView Screen Part////////////////
  GetPage(name: AppRoutes.overViewHomescreen,     page: () => Overviewhomescreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.subscriptionScreen,     page: () => SubscriptionScreen(),binding: AuthBindings()),

  ///////////////Agent MyListing Screen Part////////////////
  GetPage(name: AppRoutes.myListingScreen,     page: () => MyListingScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.billingHistoryScreen,     page: () => BillingHistoryScreen(),binding: AuthBindings()),
  GetPage(name: AppRoutes.addNewListingScreen,     page: () => AddNewListingScreen(),binding: AuthBindings()),


  ///////////////Agent Enquiries Screen Part////////////////
  GetPage(name: AppRoutes.agentEnquiriesScreen,     page: () => AgentEnquiriesScreen(),binding: AuthBindings()),

];