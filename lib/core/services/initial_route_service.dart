import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/intro/presentation/views/intro_view.dart';
import 'package:tasky/constants.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/services/get_it_service.dart';
import 'package:tasky/core/services/shared_preferences_singleton.dart';

Future<String> determineInitialRoute() async {
  await setup();
  await Prefs.init();

  final sharedPreferences = await SharedPreferences.getInstance();
  final accessToken = sharedPreferences.getString(ApiKeys.accessToken);
  final isIntroSeen = Prefs.getBool(kIsIntroViewSeen);

  if (isIntroSeen == false || isIntroSeen == null) {
    return IntroView.routeName;
  } else if (accessToken != null && accessToken.isNotEmpty) {
    return HomeView.routeName;
  } else {
    return SignInView.routeName;
  }
}
