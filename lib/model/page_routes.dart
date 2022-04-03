class PageRoutes {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String signupRoute = "/signup";
  static String profileRoute = "/profile";
  static String chooseLocRoute = "/chooseLoc";
  static String url = "http://172.17.1.120";
  //static String url = "http://192.168.1.70";
  //static String url = "http://localhost:3306";
  static String loginUrl = url+"/park/login.php";
  static String signupUrl = url+"/park/signup.php";
  static String updateUrl = url+"/park/update.php";
  static String getLatLng = url+"/park/getLatLng.php";
  static String getProfileFromId = url+"/park/profileFromId.php";
}