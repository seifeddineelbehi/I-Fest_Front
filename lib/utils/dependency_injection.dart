import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  GetIt.I.registerLazySingleton(() => UsersViewModel());
  GetIt.I.registerLazySingleton(() => ScheduleViewModel());
}
