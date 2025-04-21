import 'package:core/core.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/data/data_source/remote/error_handler.dart';
import 'package:meory/presentations/widgets/toast_widget.dart';

abstract class BaseWidget<C extends CoreCubit<S>, S extends CoreState>
    extends CoreWidget<C, S, AppCubit> {
  const BaseWidget({super.key});

  @override
  void onError(String errorMessage) {
    final locale = AppSP.get(AppSP.languageLocale);
    if (errorMessage.toUpperCase().startsWith(ErrorType.UNAUTHORIZED.type)) {
      Toast.showError(ErrorType.UNAUTHORIZED.getNameByLocale(locale));
      AppSecureStorage.resetToken();
      // AppNavigator.go(Routes.selfIdCreater);
      return;
    }
    for (var element in ErrorType.values) {
      if (errorMessage.toUpperCase().startsWith(element.type)) {
        Toast.showError(element.getNameByLocale(locale));
        return;
      }
    }
    Toast.showError(errorMessage);
  }
}
