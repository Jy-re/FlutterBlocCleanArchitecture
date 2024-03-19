import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_clean_architecture/data/repositories/todo_repository_impl.dart';
import './todo_event.dart';
import './todo_state.dart';
import '../../domain/usecases/todo_usecases.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final GetToDoUseCase getToDoUseCase;
  final AddToDoUseCase addToDoUseCase;
  final DeleteTodoUseCase deleteToDoUseCase;
  final UpdateToDoUseCase updateTodoUseCase;

  ToDoBloc(this.addToDoUseCase, this.getToDoUseCase, this.deleteToDoUseCase,
      this.updateTodoUseCase, ToDoRepositoryImpl toDoRepository)
      : super(ToDoInitialState()) {
    on<AddToDoEvent>(onAddToDoEvent);
    on<GetToDoEvent>(onGetToDoEvent);
    on<DeleteTodoEvent>(onDeleteToDoEvent);
    on<UpdateToDoEvent>(onUpdateToDoEvent);
  }

  Future<void> onAddToDoEvent(
      AddToDoEvent event, Emitter<ToDoState> emit) async {
    await addToDoUseCase(event.todo);
    final toDos = await getToDoUseCase();
    emit(ToDoListState(toDos));
  }

  Future<void> onGetToDoEvent(
      GetToDoEvent event, Emitter<ToDoState> emit) async {
    final toDos = await getToDoUseCase();
    emit(ToDoListState(toDos));
  }

  Future<void> onDeleteToDoEvent(
      DeleteTodoEvent event, Emitter<ToDoState> emit) async {
    await deleteToDoUseCase(event.todo);
    final toDos = await getToDoUseCase();
    emit(ToDoListState(toDos));
  }

  Future<void> onUpdateToDoEvent(
      UpdateToDoEvent event, Emitter<ToDoState> emit) async {
    await updateTodoUseCase(event.todo);
    final toDos = await getToDoUseCase();
    emit(ToDoListState(toDos));
  }
}
