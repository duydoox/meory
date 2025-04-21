import 'package:core/core.dart';
import 'package:meory/domain/usecases/auth/login_usecase.dart';
import 'package:meory/presentations/modules/auth_service/sign_in/cubit/sign_in_state.dart';
import 'package:meory/presentations/routes.dart';
import 'package:meory/presentations/widgets/input_text/input_text.dart';

class SignInCubit extends CoreCubit<SignInState> {
  final LoginUseCase _useCase;
  SignInCubit(this._useCase) : super(const SignInState());

  final formInputText = FormInputText();

  Future<void> login() async {
    if (formInputText.validate() != true) {
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await _useCase.execute(
      username: state.username,
      password: state.password,
    );
    result.ifSuccess((data) async {
      await AppSecureStorage.setToken(data);
      emit(state.copyWith(isLoading: false));
      AppNavigator.go(Routes.home);
    });
    result.ifError((error, errorData) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error ?? 'Có lỗi xảy ra',
      ));
    });
  }

  void onChangeUsername(String value) {
    emit(state.copyWith(
      username: value,
    ));
  }

  void onChangePassword(String value) {
    emit(state.copyWith(
      password: value,
    ));
  }
}
