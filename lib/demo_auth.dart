class DemoAuth {
  static String? registeredUsername;
  static String? registeredPassword;
  static String? currentUser;

  static bool login(String username, String password) {
    final isAdmin = username == 'admin' && password == 'admin123';
    final isRegistered =
        registeredUsername != null &&
        username == registeredUsername &&
        password == registeredPassword;
    if (isAdmin || isRegistered) {
      currentUser = username;
      return true;
    }
    return false;
  }

  static void register(String username, String password) {
    registeredUsername = username;
    registeredPassword = password;
  }

  static void logout() {
    currentUser = null;
  }
}
