import 'package:get_it/get_it.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../data/datasource/local_data_provider.dart';
import '../../domain/usecases/todo_usecases.dart';
import '../bloc/todo_bloc.dart';
import '../../domain/repository/todo_repository.dart';
// import '../../data/in_memory_data_provider.dart';

final serviceLocator = GetIt.instance;

void init() {
  serviceLocator.registerLazySingleton<ToDoRepository>(
      () => ToDoRepositoryImpl(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ToDoRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ToDoBloc(
        serviceLocator<AddToDoUseCase>(),
        serviceLocator<GetToDoUseCase>(),
        serviceLocator<DeleteTodoUseCase>(),
        serviceLocator<ToDoRepositoryImpl>(),
      ));
  serviceLocator.registerLazySingleton(() => SharedPreferenceDataProvider());
  // serviceLocator.registerLazySingleton(() => InMemoryToDoDataProvider());

  serviceLocator.registerLazySingleton(() => AddToDoUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetToDoUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => DeleteTodoUseCase(serviceLocator()));
}
