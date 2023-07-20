import 'package:get_it/get_it.dart';
import 'package:weatherappbgd/app/data/data_sources/remote/weather_repository.dart';
import 'package:weatherappbgd/app/domain/repositories/weather_repositry_impl.dart';
import 'package:weatherappbgd/app/presentation/ui/aboutus/aboutusviewmodel.dart';
import 'package:weatherappbgd/app/presentation/ui/main/mainviewmodel.dart';
import 'package:weatherappbgd/app/presentation/ui/splash/splashviewmodel.dart';

import '../../data/data_sources/local/preference_manager.dart';
import '../../shared/core/network/dio_helper.dart';

final GetIt getIt = GetIt.instance;

void setup(){
  getIt.registerLazySingleton(() => PreferenceManager());
  getIt.registerLazySingleton(() => DioHelper());
  setuprepo();
  setupViewModels();
}

void setupViewModels() {
  
  getIt.registerFactory(() => SplashViewModel(
    getIt.get<PreferenceManager>(),
    getIt.get<WeatherRepository>(),
  ));

  getIt.registerFactory(() => MainViewModel(
    getIt.get<PreferenceManager>(),
  ));

  getIt.registerFactory(() => AboutUsViewModel(
  ));
}

void setuprepo() {
  getIt.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      getIt.get<DioHelper>(),
    ),
  );
}