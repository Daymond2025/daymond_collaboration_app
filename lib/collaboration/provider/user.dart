
import 'package:daymond_collaboration_app/collaboration/models/userModel.dart';
import 'package:daymond_collaboration_app/collaboration/services/todo.dart';
import 'package:flutter/material.dart';


class UsersProvider extends ChangeNotifier {
  final _service = TodoService();
  bool isLoading = false;
  List<User> _todos = [];
  List<User> get todos => _todos;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }
}