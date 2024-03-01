import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/bloc/to_do_bloc.dart';
import 'package:todo_app/presentation/widgets/floating_button.dart';
import 'package:todo_app/presentation/widgets/todo_list.dart';

class HomeScreenToDo extends StatelessWidget {
  const HomeScreenToDo({Key? key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ToDoBloc>().add(FetachInitialToDoListEvent());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "To Do",
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ToDoBloc, ToDoState>(
          listener: (context, state) {
            if (state is ErrorToDoState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingToDoState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedTODo) {
              return ToDoList(toDoList: state.todoList);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: const Stack(
        children: [
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingButton(),
          ),
        ],
      ),
    );
  }
}
