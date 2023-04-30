import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;

  //esta tarea sera cambiada constantemente esta variable
  final onTodoChanged;
  final onDeleteItem;

  //funcion para programar la funcion
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onTodoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //aqui creamos el pargin para separar las tareas que no se vean pegadas
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        //estos seran los iconos como cuadritos, en donde apareceran como chulitos
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

        tileColor: Colors.white,
        leading: Icon(
          todo.isDone == true ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),

        title: Text(
          todo.todoText!, //llamamos a todo
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone == true ? TextDecoration.lineThrough : null,
          ),
        ),

        // aca creamos los delete icon, iconos de eliminar
        //que aparezca como un circulo en sombre cuando movemos el mouse en delete
        //da el efecto
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(
            vertical: 9,
          ),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),

          //aca creamos el icon eliminar, con la caneca blanca o el tarro de basura blanco
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              //llamamos nuestra funcion que esta en home
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
