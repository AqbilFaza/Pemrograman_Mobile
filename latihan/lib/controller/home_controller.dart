import 'package:get/get.dart';
import 'package:latihan/model/todos.dart';
import 'package:latihan/service/api_service.dart';

class HomeController extends GetxController {
  final isLoading = true.obs;
  final todo = Todo(
    userId: 0,
    id: 0,
    title: '',
    completed: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodo();
  }

  void fetchTodo() async {
    try {
      isLoading(true);
      var fetchedTodo = await ApiService.getTodo();
      todo.value = fetchedTodo;
    } finally {
      isLoading(false);
    }
  }
}