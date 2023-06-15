import 'package:flutter_template/viewModel/events_view_model.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/viewModel/send_mail_view_model.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  GetIt.I.registerLazySingleton(() => UsersViewModel());
  GetIt.I.registerLazySingleton(() => ScheduleViewModel());
  GetIt.I.registerLazySingleton(() => SendMailViewModel());
  GetIt.I.registerLazySingleton(() => EventsViewModel());
}
