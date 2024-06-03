isGuestUser({token}) {
  if (token != "null" &&
      token.toString().isNotEmpty &&
      token != "" &&
      token != null) {
    return false;
  } else {
    return true;
  }
}


