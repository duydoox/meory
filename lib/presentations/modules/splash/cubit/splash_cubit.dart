import 'package:core/core.dart';
import 'package:meory/domain/usecases/splash/splash_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends CoreCubit<SplashState> {
  final SplashUseCase _useCase;

  SplashCubit(this._useCase) : super(const SplashState());

  Future<void> init() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final result = await _useCase.init();
    emit(state.copyWith(
      title: result.title,
      isLoading: false,
    ));
  }
}
