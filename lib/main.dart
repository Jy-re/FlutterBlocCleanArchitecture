import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_clean_architecture/app/bloc/todo_bloc.dart';
import 'package:todo_bloc_clean_architecture/app/screens/todo_screen.dart';
import 'package:todo_bloc_clean_architecture/app/core/injection.dart' as gi;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  gi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToDoBloc>(
          create: (_) => gi.serviceLocator<ToDoBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: ToDoScreen(),
      ),
    );
  }
}
