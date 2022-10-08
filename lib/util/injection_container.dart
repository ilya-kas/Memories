import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:memories/data/repository/images_repository_impl.dart';
import 'package:memories/data/repository/memories_repository_impl.dart';
import 'package:memories/data/source/images_provider.dart';
import 'package:memories/data/source/memories_storage.dart';
import 'package:memories/domain/repository/images_repository.dart';
import 'package:memories/domain/repository/memories_repository.dart';
import 'package:memories/domain/use_case/add_memory_usecase.dart';
import 'package:memories/domain/use_case/get_stored_memories_usecase.dart';
import 'package:memories/domain/use_case/pick_an_image_usecase.dart';
import 'package:memories/presentation/bloc/gallery_bloc/gallery_bloc.dart';
import 'package:memories/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:memories/domain/entity/bundle.dart';
import 'package:memories/util/network_checker.dart';

final sl = GetIt.instance;

void init(){
  //util
  sl.registerLazySingleton<NetworkChecker>(() => NetworkCheckerImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Bundle());

  //Blocs
  sl.registerFactory(() => MapBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => GalleryBloc(sl(), sl()));

  //use cases
  sl.registerLazySingleton(() => AddMemoryUseCase(sl()));
  sl.registerLazySingleton(() => GetStoredMemoriesUseCase(sl()));
  sl.registerLazySingleton(() => PickAnImageUseCase(sl()));

  //repos
  sl.registerLazySingleton<ImagesRepository>(() => ImagesRepositoryImpl(sl()));
  sl.registerLazySingleton<MemoriesRepository>(() => MemoriesRepositoryImpl(sl()));

  //source
  sl.registerLazySingleton<ImagesProvider>(() => ImagesProviderImpl());
  sl.registerSingleton<MemoriesStorage>(MemoriesStorageImpl(sl()));
}