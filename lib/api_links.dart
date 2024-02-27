class ApiLinks {
  //Localhost ios emulator 127.0.0.1 or localhost
  //Localhost android emulator 10.0.2.2
  //Localhost on Real device mean
  //yousef devie: fe80::cf:baff:fe0a:fc4c
  //192.168.1.3
  static const String server = "http://10.0.2.2/jdolh";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String images = '$server/upload';
  static const String imagesCategories = '$images/categories';
  static const String imagesItems = '$images/items';

  //=============== Auth ===============//
  static const String signUp = '$server/jdolh_customers/auth/signup.php';
  static const String login = '$server/jdolh_customers/auth/login.php';
  static const String verifycode =
      '$server/jdolh_customers/auth/verifycode.php';
  static const String resendVerifycode =
      '$server/jdolh_customers/auth/resend_verifycode.php';
  static const String forgetPassword =
      '$server/jdolh_customers/auth/forget_password.php';
  static const String resetPassword =
      '$server/jdolh_customers/auth/reset_password.php';

  static const String searchPerson =
      '$server/jdolh_customers/search_person.php';
  static const String followUnfollow =
      '$server/jdolh_customers/follow_unfollow.php';

  static const String personProfile =
      '$server/jdolh_customers/profile/person_profile.php';
  static const String myProfile =
      '$server/jdolh_customers/profile/my_profile.php';

  static const String brandTypes = '$server/jdolh_brands/view_brand_types.php';
}
