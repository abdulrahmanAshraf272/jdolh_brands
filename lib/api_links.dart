class ApiLinks {
  //Localhost ios emulator 127.0.0.1 or localhost
  //Localhost android emulator 10.0.2.2
  //Localhost on Real device mean
  //yousef devie: fe80::cf:baff:fe0a:fc4c
  //192.168.1.3
  static const String server = "http://10.0.2.2/jdolh";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String imagesBrands = '$server/jdolh_brands/upload';
  static const String logoImage = '$imagesBrands/logo';
  static const String branchImage = '$imagesBrands/branches';
  static const String itemsImage = '$imagesBrands/items';

  //=============== Auth ===============//
  static const String signUp = '$server/jdolh_brands/auth/signup.php';
  static const String login = '$server/jdolh_brands/auth/login.php';
  static const String verifycode = '$server/jdolh_brands/auth/verifycode.php';
  static const String resendVerifycode =
      '$server/jdolh_brands/auth/resend_verifycode.php';
  static const String forgetPassword =
      '$server/jdolh_brands/auth/forget_password.php';
  static const String resetPassword =
      '$server/jdolh_brands/auth/reset_password.php';

  static const String searchPerson = '$server/jdolh_brands/search_person.php';
  static const String followUnfollow =
      '$server/jdolh_brands/follow_unfollow.php';

  static const String personProfile =
      '$server/jdolh_brands/profile/person_profile.php';
  static const String myProfile = '$server/jdolh_brands/profile/my_profile.php';

  static const String brandTypes = '$server/jdolh_brands/view_brand_types.php';
  static const String subtypes = '$server/jdolh_brands/view_subtypes.php';

  static const brandTypesAndsubtypes =
      '$server/jdolh_brands/view_types_and_subtypes.php';

  static const String createBrand =
      '$server/jdolh_brands/brand/create_brand.php';

  static const String createLegaldata =
      '$server/jdolh_brands/legaldata/create_legaldata.php';

  //Bch
  static const String createBch = '$server/jdolh_brands/bch/create_bch.php';
  static const String addWorktimeBch =
      '$server/jdolh_brands/bch/add_worktime.php';
  static const String getAllBchs = '$server/jdolh_brands/bch/get_all_bchs.php';
  static const String getWorktime = '$server/jdolh_brands/bch/get_worktime.php';

  static const String getSelectedPolicy =
      '$server/jdolh_brands/bch/get_policy_selected.php';

  static const String getSelectedPaymentMethods =
      '$server/jdolh_brands/bch/get_selected_payment_methods.php';
  static const String bchComplete = '$server/jdolh_brands/bch/bch_complete.php';

  //Bch Manager
  static const String addBchManager =
      '$server/jdolh_brands/bch/bchManager/add_bch_manager.php';
  static const String getBchManager =
      '$server/jdolh_brands/bch/bchManager/get_bch_manager.php';
  static const String deleteBchManager =
      '$server/jdolh_brands/bch/bchManager/delete_bch_manager.php';

  static const String switchEnableBchManager =
      '$server/jdolh_brands/bch/bchManager/switch_enable_bch_manager.php';

  static const String changePasswordBchManager =
      '$server/jdolh_brands/bch/bchManager/change_password_bch_manager.php';

  static const String getBillResPolicy =
      '$server/jdolh_brands/bch/get_bill_res_policies.php';
  static const String getPaymentMethods =
      '$server/jdolh_brands/bch/get_payment_methods.php';
  static const String addPaymentMethods =
      '$server/jdolh_brands/bch/add_payment_methods.php';
  static const String addResDetails =
      '$server/jdolh_brands/bch/add_resdetails.php';
  static const String addEditPolicy =
      '$server/jdolh_brands/bch/add_edit_policy.php';
//Categories
  static const String addCategories =
      '$server/jdolh_brands/bch/categories/add_categories.php';
  static const String getCategories =
      '$server/jdolh_brands/bch/categories/get_categories.php';
  static const String deleteCategories =
      '$server/jdolh_brands/bch/categories/delete_categories.php';

//ResOptions
  static const String addResOptions =
      '$server/jdolh_brands/bch/resOptions/add_resOptions.php';
  static const String getResOptions =
      '$server/jdolh_brands/bch/resOptions/get_resOptions.php';
  static const String deleteResOption =
      '$server/jdolh_brands/bch/resOptions/delete_resOption.php';
  static const String getSelectedResOptionIds =
      '$server/jdolh_brands/bch/resOptions/get_selected_resOptionIds.php';
  //Items
  static const String addItems = '$server/jdolh_brands/bch/items/add_items.php';
  static const String addItemOption =
      '$server/jdolh_brands/bch/items/add_itemsoption.php';
  static const String addItemOptionElement =
      '$server/jdolh_brands/bch/items/add_ioption_element.php';
  static const String deleteItemOptionElement =
      '$server/jdolh_brands/bch/items/delete_ioption_element.php';
  static const String getItemOptionWithElement =
      '$server/jdolh_brands/bch/items/get_itemsoption_with_elements.php';
  static const String getItems = '$server/jdolh_brands/bch/items/get_items.php';
  static const String getItemDetails =
      '$server/jdolh_brands/bch/items/get_item_details.php';
  static const String getOptionElements =
      '$server/jdolh_brands/bch/items/get_option_elements.php';
  static const String editItemOption =
      '$server/jdolh_brands/bch/items/edit_itemoption.php';
  static const String editItem =
      '$server/jdolh_brands/bch/items/edit_items.php';
  static const String editItemImage =
      '$server/jdolh_brands/bch/items/edit_items_image.php';
  static const String getSelectedItemOptions =
      '$server/jdolh_brands/bch/items/get_selected_itemoptions.php';

  //ResDetails
  static const String addEditResDetails =
      '$server/jdolh_brands/bch/add_edit_resdetails.php';
  static const String getResDetails =
      '$server/jdolh_brands/bch/get_resdetails.php';

  //General
  static const String getBchDataGeneral =
      '$server/jdolh_brands/bch/get_bch_data_general.php';
  static const String deleteDataGenereal =
      '$server/jdolh_brands/delete_element_general.php';
}
