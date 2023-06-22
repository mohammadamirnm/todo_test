import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/config/theme.dart';
import 'package:todo_app/src/features/todo_list/presentation/cubits/todo/todo_cubit.dart';
import 'package:todo_app/src/features/todo_list/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<TodoCubit>(create: (_) => TodoCubit()),
        ],
        child: child ?? Container(),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const HomePage(),
    );
  }
}
