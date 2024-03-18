import 'package:get/get.dart';
import 'package:jdolh_brands/controller/auth/forget_password_controller.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/middleware/my_middleware.dart';
import 'package:jdolh_brands/test_screen.dart';

import 'package:jdolh_brands/view/screens/auth/login_screen.dart';
import 'package:jdolh_brands/view/screens/auth/reset_password_screen.dart';
import 'package:jdolh_brands/view/screens/auth/forget_password_screen.dart';

import 'package:jdolh_brands/view/screens/auth/signup_screen.dart';
import 'package:jdolh_brands/view/screens/auth/success_operation_screen.dart';
import 'package:jdolh_brands/view/screens/auth/verifycode_screen.dart';
import 'package:jdolh_brands/view/screens/bch/add_all_branch_content_screen.dart';
import 'package:jdolh_brands/view/screens/bch/bch_details_complete_screen.dart';
import 'package:jdolh_brands/view/screens/bch/create_bch_screen.dart';
import 'package:jdolh_brands/view/screens/bch/add_payment_methods_screen.dart';
import 'package:jdolh_brands/view/screens/bch/add_plicy_screen.dart';
import 'package:jdolh_brands/view/screens/bch/add_worktime_screen.dart';
import 'package:jdolh_brands/view/screens/bch/all_bchs_screen.dart';
import 'package:jdolh_brands/view/screens/bch/bch_manager_screen.dart';
import 'package:jdolh_brands/view/screens/bch/bch_details_screen.dart';
import 'package:jdolh_brands/view/screens/bch/create_branch_screen.dart';
import 'package:jdolh_brands/view/screens/bch/display/display_payment_methods_screen.dart';
import 'package:jdolh_brands/view/screens/bch/display/display_policy_screen.dart';
import 'package:jdolh_brands/view/screens/bch/res_details/display_res_detail_screen.dart';
import 'package:jdolh_brands/view/screens/items/diplay_item_screen.dart';
import 'package:jdolh_brands/view/screens/items/edit_items_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/display_res_option_screen.dart';
import 'package:jdolh_brands/view/screens/bch/display/display_worktime_screen.dart';
import 'package:jdolh_brands/view/screens/bch/res_details/add_edit_res_details_screen.dart';
import 'package:jdolh_brands/view/screens/brand/create_brand_screen.dart';
import 'package:jdolh_brands/view/screens/categories_screen.dart';

import 'package:jdolh_brands/view/screens/home_screen.dart';
import 'package:jdolh_brands/view/screens/items/add_ioption_element_screen.dart';
import 'package:jdolh_brands/view/screens/items/add_items_options_screen.dart';
import 'package:jdolh_brands/view/screens/items/additional_item_options_screen.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/screens/items/items_screen.dart';
import 'package:jdolh_brands/view/screens/legaldata/create_legaldata_screen.dart';
import 'package:jdolh_brands/view/screens/main_screen.dart';
import 'package:jdolh_brands/view/screens/more_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/create_res_option_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/res_options_screen.dart';
import 'package:jdolh_brands/view/screens/select_address_screen.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => const LoginScreen(),
    middlewares: [MyMiddleware()],
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.more,
    page: () => const MoreScreen(),
  ),
  GetPage(
      //name: '/',
      name: AppRouteName.additionalItemOptions,
      page: () => const AdditionalItemOptionsScreen(),
      popGesture: true),
  GetPage(
      //name: '/',
      name: AppRouteName.addItemOptions,
      page: () => const AddItemsOptionsScreen(),
      popGesture: true),
  GetPage(
      //name: '/',
      name: AppRouteName.addIoptionElement,
      page: () => const AddIoptionElementScreen(),
      popGesture: true),
  GetPage(
    //name: '/',
    name: AppRouteName.addPaymentMethod,
    page: () => const AddPaymentMethodsScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.addPolicy,
    page: () => const AddPolicyScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.createBch,
    page: () => const CreateBchScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.allBchs,
    page: () => const AllBchsScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.bchManager,
    page: () => const BchManagerScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.addWorktime,
    page: () => const AddWorktimeScreen(),
  ),
  GetPage(
    name: AppRouteName.addEditResDetails,
    page: () => const AddEditResDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.displayWorktime,
    page: () => const DisplayWorktimeScreen(),
  ),

  GetPage(
    name: AppRouteName.displayPolicy,
    page: () => const DisplayPolicyScreen(),
  ),
  GetPage(
    name: AppRouteName.displayPaymentMethods,
    page: () => const DisplayPaymentMethodsScreen(),
  ),
  GetPage(
    name: AppRouteName.displayResOptions,
    page: () => const DisplayResOptionScreen(),
  ),
  GetPage(
    name: AppRouteName.displayResDetails,
    page: () => const DisplayResDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.displayItem,
    page: () => const DisplayItemScreen(),
  ),

  GetPage(
    //name: '/',
    name: AppRouteName.createLegaldata,
    page: () => const CreateLegaldataScreen(),
  ),

  GetPage(
    name: AppRouteName.addAllBranchContent,
    page: () => const AddAllBranchContent(),
  ),
  GetPage(
      name: AppRouteName.items,
      page: () => const ItemsScreen(),
      popGesture: true),
  GetPage(
      name: AppRouteName.createItems,
      page: () => const CreateItemsScreen(),
      popGesture: true),
  GetPage(
      name: AppRouteName.editItem,
      page: () => const EditItemsScreen(),
      popGesture: true),
  GetPage(
    //name: '/',
    name: AppRouteName.resOptions,
    page: () => const ResOptionsScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.createResOptions,
    page: () => const CreateResOptionsScreen(),
  ),
  //GetPage(name: '/', page: () => TestScreen()),
  // GetPage(name: '/testScreen2', page: () => TestScreen2()),
  GetPage(
    //   name: '/',
    name: AppRouteName.createBrand,
    page: () => const CreateBrandScreen(),
  ),

  GetPage(
    name: AppRouteName.bchDetails,
    page: () => const BchDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.bchDetailsComplete,
    page: () => const BchDetailsCompleteScreen(),
  ),
  GetPage(
      name: AppRouteName.selectAddress,
      page: () => const SelectAddressScreen(),
      popGesture: true),
  GetPage(
    //name: '/',
    name: AppRouteName.categories,
    page: () => const CategoriesScreen(),
  ),
  GetPage(
    name: AppRouteName.home,
    page: () => const HomeScreen(),
  ),

  // =========== Auth =========//
  GetPage(name: AppRouteName.login, page: () => const LoginScreen()),
  GetPage(name: AppRouteName.signUp, page: () => const SignupScreen()),

  GetPage(
      name: AppRouteName.resetPassword,
      page: () => const ResetPasswordScreen()),
  GetPage(name: AppRouteName.verifyCode, page: () => const VerifycodeScreen()),
  GetPage(
      name: AppRouteName.forgetPassword,
      page: () => const ForgetPasswordScreen()),

  GetPage(
      name: AppRouteName.successOperation,
      page: () => const SuccessOperation()),
  GetPage(
    name: AppRouteName.mainScreen,
    page: () => const MainScreen(),
  ),

  GetPage(
    name: AppRouteName.createBranch,
    page: () => CreateBranchScreen(),
  ),
];
