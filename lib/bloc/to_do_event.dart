part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

class FetachInitialToDoListEvent extends ToDoEvent {}

class AddToDoEvents extends ToDoEvent {
  final ToDoModel toDo;

  AddToDoEvents({required this.toDo});
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDoModel updateTodo;

  UpdateToDoEvent({required this.updateTodo});
}

class DeleteTodo extends ToDoEvent {
  final String todoId;
  DeleteTodo({required this.todoId});
}
