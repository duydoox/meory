import 'package:core/core.dart';
import 'package:meory/data/data_source/remote/api_endpoints.dart';
import 'package:meory/data/data_source/remote/base_repository.dart';
import 'package:meory/data/models/splash/splash_resp.dart';
import 'package:meory/domain/entities/splash/splash.dart';
import 'package:meory/domain/repositories/splash/splash_repo.dart';

class SplashRepoImpl extends BaseRepository with SplashRepo {
  @override
  Future<Splash> init() async {
    final result = await Result.guardAsync(() => get(ApiEndpoints.title));

    Splash splash = const Splash(title: '');

    result.ifSuccess((data) {
      final resp = SplashResp.fromJson(data?.data ?? {});

      splash = Splash(
        title: resp.title ?? '',
      );
    });

    return splash;
  }
}
