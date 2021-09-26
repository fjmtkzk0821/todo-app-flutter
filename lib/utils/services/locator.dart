import 'package:get_it/get_it.dart';
import 'package:todo_app/models/config_model.dart';
import 'package:todo_app/models/todo_list_storage_model.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<ConfigModel>(() => ConfigModel());
  locator.registerLazySingleton<TodoListStorageModel>(() => TodoListStorageModel());
}