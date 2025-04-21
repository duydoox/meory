import 'package:meory/domain/entities/splash/splash.dart';
import 'package:meory/domain/repositories/splash/splash_repo.dart';

class SplashUseCase {
  final SplashRepo _repo;

  const SplashUseCase(this._repo);

  Future<Splash> init() async => _repo.init();
}
