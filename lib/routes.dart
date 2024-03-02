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
import 'package:jdolh_brands/view/screens/bch/branch_details_screen.dart';
import 'package:jdolh_brands/view/screens/bch/create_branch_screen.dart';
import 'package:jdolh_brands/view/screens/brand/create_brand_screen.dart';
import 'package:jdolh_brands/view/screens/categories_screen.dart';

import 'package:jdolh_brands/view/screens/home_screen.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/screens/items/items_screen.dart';
import 'package:jdolh_brands/view/screens/legaldata/create_legaldata_screen.dart';
import 'package:jdolh_brands/view/screens/main_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/create_res_option_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/res_options_screen.dart';

List<GetPage> routes = [
  // GetPage(
  //   name: '/',
  //   page: () => const LoginScreen(),
  //   middlewares: [MyMiddleware()],
  // ),

  GetPage(
    //name: '/',
    name: AppRouteName.createLegaldata,
    page: () => const CreateLegaldataScreen(),
  ),

  GetPage(
    //name: '/',
    name: AppRouteName.addAllBranchContent,
    page: () => const AddAllBranchContent(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.items,
    page: () => const ItemsScreen(),
  ),
  GetPage(
    name: AppRouteName.createItems,
    page: () => const CreateItemsScreen(),
  ),
  GetPage(
    //name: '/',
    name: AppRouteName.resOptions,
    page: () => const ResOptionsScreen(),
  ),
  GetPage(
    name: AppRouteName.createResOptions,
    page: () => const CreateResOptionsScreen(),
  ),
  //GetPage(name: '/', page: () => TestScreen()),
  // GetPage(name: '/testScreen2', page: () => TestScreen2()),
  GetPage(
    name: '/',
    //name: AppRouteName.createBrand,
    page: () => const CreateBrandScreen(),
  ),
  GetPage(
    name: AppRouteName.branchDetails,
    page: () => const BranchDetailsScreen(),
  ),
  GetPage(
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
