import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/domain/todo_api_functions.dart';
import 'package:todo_app/model/to_do_Model.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoApiFunctions toDoApiFunctions = ToDoApiFunctions();
  ToDoBloc(this.toDoApiFunctions) : super(InitialToDoState()) {
    on<FetachInitialToDoListEvent>(fetachInitialToDoListEvent);
    on<AddToDoEvents>(addToDoEvent);
    on<UpdateToDoEvent>(updateToDoEvent);
    on<DeleteTodo>(deleteToDoEvent);
  }

  Future<void> fetachInitialToDoListEvent(
      FetachInitialToDoListEvent event, Emitter<ToDoState> emit) async {
    try {
      final toDoList = await toDoApiFunctions.fetchtodoList();
      emit(LoadedTODo(toDoList));
    } catch (e) {
      emit(ErrorToDoState('Fetching Data'));
    }
  }

  Future<void> addToDoEvent(
      AddToDoEvents event, Emitter<ToDoState> emit) async {
    try {
      await toDoApiFunctions.addToDoModel(toDo: event.toDo);
      final updatedList = await toDoApiFunctions.fetchtodoList();
      emit(LoadedTODo(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }

  Future<void> updateToDoEvent(
      UpdateToDoEvent event, Emitter<ToDoState> emit) async {
    emit(LoadingToDoState());
    try {
      await toDoApiFunctions.updateToDoModel(updateTodo: event.updateTodo);
      final updatedList = await toDoApiFunctions.fetchtodoList();
      emit(LoadedTODo(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }

  Future<void> deleteToDoEvent(
      DeleteTodo event, Emitter<ToDoState> emit) async {
    emit(LoadingToDoState());
    try {
      await toDoApiFunctions.deleteToDoModel(todoId: event.todoId);
      final updatedList = await toDoApiFunctions.fetchtodoList();
      emit(LoadedTODo(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }
}
