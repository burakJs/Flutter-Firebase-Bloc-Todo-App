import 'ITodo_repository.dart';
import '../../models/todo.dart';

class TodoRepository extends ITodoRepository {
  final String _collectionPath = 'todos';
  final String _orderField = 'createdAt';
  @override
  Future<List<Todo>> getAllTodos() async {
    List<Todo> todos = [];
    final results = await firestore.collection(_collectionPath).orderBy(_orderField).get();
    for (var snapshot in results.docs) {
      Todo newTodo = Todo.fromJson(snapshot.data());
      newTodo.id = snapshot.id;
      todos.add(newTodo);
    }
    return todos;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await firestore.collection(_collectionPath).add(todo.toJson());
  }

  @override
  Future<void> removeTodo(Todo todo) async {
    await firestore.collection(_collectionPath).doc(todo.id).delete();
  }
}
