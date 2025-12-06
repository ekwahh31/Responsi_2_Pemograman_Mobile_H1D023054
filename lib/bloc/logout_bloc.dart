import 'package:responsi2_mobile_paket1_h1d023054/helpers/user_info.dart';

class LogoutBloc {
  static Future<void> logout() async {
    await UserInfo().logout();
  }
}
