import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/to_do_bloc.dart';
import 'package:todo_app/domain/todo_api_functions.dart';
import 'package:todo_app/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(ToDoApiFunctions()),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        home: const HomeScreenToDo(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
