import 'package:core/core.dart';
import 'package:meory/presentations/routes.dart';

part 'sign_up_completed_state.dart';

class SignUpCompletedCubit extends CoreCubit<SignUpCompletedState> {
  SignUpCompletedCubit({required this.email, required this.password})
      : super(const SignUpCompletedState());

  final String email;
  final String password;

  Future<void> onTapGotoHome() async {
    final tokenData = await AppSecureStorage.getToken();
    if (tokenData?.accessToken == null) {
      AppNavigator.go(Routes.signIn);
    } else {
      AppNavigator.go(Routes.home);
    }
  }
}
