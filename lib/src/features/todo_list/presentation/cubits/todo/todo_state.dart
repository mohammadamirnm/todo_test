part of 'todo_cubit.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  const factory TodoState.loading() = _Loading;
  const factory TodoState.error(String message) = _Error;
  const factory TodoState.loaded(List<Todo> todos) = _Loaded;
}
