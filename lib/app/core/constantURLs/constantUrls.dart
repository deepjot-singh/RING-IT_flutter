class ConstantUrls {
  static var wsBaseUrl =
      // "http://44.192.61.153/api/";
      "https://foodservice.codeoptimalsolutions.com/api/";
  // "https://codeoptimalsolutions.com/test/zoom-zoom/public/api/";

  static var wsRegister = "${wsBaseUrl}auth/register";
  static var wsForgotPass = "${wsBaseUrl}auth/forgot-password";
  static var wsLogin = "${wsBaseUrl}auth/login";
  static var wsLogOut = "${wsBaseUrl}logout";
  static var wsUpdateToken =
      "${wsBaseUrl}user/update-device-token"; // UPDATE TOKEN
  static var wsAppleLogin = "${wsBaseUrl}apple-login";
  static var wsDeleteAccount = "${wsBaseUrl}user/delete-account";
  static var wsChangePass = "${wsBaseUrl}user/update-password";
  static var wsVrifyOtp = "${wsBaseUrl}auth/verify-otp";
  static var wsOtherInformationPage = "${wsBaseUrl}setting/get-app-setting";
  static var wsCategory = "${wsBaseUrl}category/get-category";
  static var wsGetAddress = "${wsBaseUrl}useraddress/get-user-address";
  static var wsHomeScreenSubcategory =
      "${wsBaseUrl}subcategory/random-subcategory";
  static var wsSetDefaultAddress =
      "${wsBaseUrl}useraddress/set-default-address";
  static var wsDeleteAddress =
      "${wsBaseUrl}useraddress/delete-user-address?address_id=";
  static var wsGetSubCategory =
      "${wsBaseUrl}subcategory/get-subcategory?category_id=";
  static var wsProfile = "${wsBaseUrl}user/get-profile";
  static var wsUpdateAddress =
      "${wsBaseUrl}useraddress/update-user-address"; // UPDATE ADDRESS
  static var wsAddAddress =
      "${wsBaseUrl}useraddress/add-user-address"; // ADD ADDRESS
  static var wsProductList = "${wsBaseUrl}product/get-products";
  static var wsUpdateProfile = "${wsBaseUrl}user/update-profile";
  static var wsUpdateNotificationStatus =
      "${wsBaseUrl}user/notification-status?type=";
  static var wsGetNotificationStatus = "${wsBaseUrl}user/get-notification";
  static var wsVerifyPhoneNo = "${wsBaseUrl}auth/phone-no-verify-send-otp";
  static var wsOtpVerifyPhoneNumber = "${wsBaseUrl}auth/verify-phone-number";
  static var wsResendOtp = "${wsBaseUrl}auth/resend-auth-otp";
  static var wsNotificationList = "${wsBaseUrl}notification/get-listing";
  static var wsUpdatePhoneNumber = "${wsBaseUrl}user/change-phone-number";

  static var wsResetPassword = "${wsBaseUrl}auth/reset-password";
  static var wsOrderHistory = "${wsBaseUrl}order/get-order-history";

  //cart apis
  static var wsAddToCart = "${wsBaseUrl}cart/add-to-cart";
  static var wsRemoveToCart = "${wsBaseUrl}cart/remove-from-cart";
  static var wsGetCartItemPrice = "${wsBaseUrl}cart/get-cart-item-price";
  static var wsGetCartItems = "${wsBaseUrl}cart/get-cart";
  static var wsPlaceOrder = "${wsBaseUrl}order/place-order";
  static var wsPopularItems = "${wsBaseUrl}product/get-popular-items";

  static var wsGoogleLogin = "${wsBaseUrl}google-login";
  static var wsAddPhone = "${wsBaseUrl}add-phone-number";
  static var wsContactApi="${wsBaseUrl}setting/admin-phone-number";

//  static var wsVrifyOtp = "auth/verify-otp";
}
