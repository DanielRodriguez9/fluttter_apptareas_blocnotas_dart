import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

/*En Flutter, la diferencia entre usar rutas absolutas y rutas relativas en tus importaciones de paquetes o archivos depende
 de la ubicación de tu archivo actual en el árbol de directorios de tu proyecto.

Cuando usas una ruta absoluta, como "package:flutter/material.dart",
 le estás diciendo al compilador que busque el paquete "material.dart" en el paquete
  "flutter". Esto es útil si estás importando un paquete que se encuentra en un lugar específico de 
  tu proyecto y quieres asegurarte de que estás importando el archivo correcto.

Por otro lado, cuando usas una ruta relativa, como "../constants/colors.dart", 
estás indicando que el archivo que estás importando se encuentra en una ubicación relativa a tu archivo actual. En este caso,
 ".." indica que el archivo está un nivel hacia arriba en el árbol de directorios, y luego se accede a la carpeta "constants" y al archivo "colors.dart".
  Esto es útil cuando estás importando un archivo que se encuentra en una ubicación específica en relación con tu archivo actual.

En resumen, la principal diferencia entre usar rutas absolutas y rutas relativas en Flutter es la forma en que se especifica la ubicación de los archivos que se están importando. 
Ambas formas pueden ser útiles dependiendo de la situación y la estructura de tu proyecto.
*/

//la clase home la llamaremos en main dart home :(Home)

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();

  //creare la lista de busqueda de search
  List<ToDo> _foundToDo = [];

  //controlador para agregar los elementos, las tareas o items

  final _todoController = TextEditingController();

  @override
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //color d fondo
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical:
                      15), //este es el espacio izquiera y derecha del cilindro de search
              //haremos la lupa de busqueda el search con su barra
              child: Column(
                children: [
                  searchBox(),

                  //crearemos la el titulo My Tasks de tareas con el widget Expanded para la letra

                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: Text(
                            'My Tasks',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        //despues de container crearemos la lista de tareas

                        //llamamos a ToDo item  cque la creamos en todo_item.darty recorremos la lista de tareas
                        for (ToDo todoo in _foundToDo
                            .reversed) //el reversed es para que cuando creamos una nueva tarea se muestre en las primeras
                          ToDoItem(
                            todo: todoo,
                            onTodoChanged:
                                _handleToDoChange, //llamamos nuestra funcion
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //aca crearemos el boton de añadir nueva tarea o nuevo item

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),

                    //texto de añadir nuevo item

                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: "Añade un nuevo item o tarea ",
                          border: InputBorder.none),
                    ),
                  ),
                ),

                // aca crearemos el icono del +

                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                      //obtendremos el texto que ha sido proporcionado por el usuario
                      //llamamos la funcion o metodo
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }

  //manipular  los estados de true a false en las tareas

  /**Sí, con el código que te proporcioné, si todo es nulo, todo?.isDone se evaluará como nulo y !(todo?.isDone ?? false) se evaluará como true. 
   * Si todo no es nulo y su propiedad isDone es verdadera, entonces !(todo?.isDone ?? false) se evaluará como false, y si su propiedad isDone 
   * es falsa, entonces !(todo?.isDone ?? false)
   *  se evaluará como true. En resumen, el código establecerá la propiedad isDone de todo como el valor opuesto al que tenía previamente. */

  void _handleToDoChange(ToDo? todo) {
    setState(() {
      todo?.isDone = !(todo.isDone ?? false);
    });
  }

  //ahor crearemos la funcion para activar la accion de eliminar lo aceptaremos con la identificado id que creamos en todo.dart

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  //funcion para agregar tareas a la lista

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });

    //para limpiar el textfield
    _todoController.clear();
  }

  //creamos la funcion de search buscar las tareas

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  //aca creamos las acciones para searchbox que llamamos arriba
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),

      //spacios

      //aqui ire la barra como cilindro
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        //esto es para que cuando escribamos en el campo de texto se filtre y llame a runfuilter y busque nuestra tarea....
        onChanged: (value) => _runFilter(value),
        //controller: _todoController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  //esta principal de arriba en donde va las tres lineas o el navbar y el logo de tareas

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor:
          tdBGColor, //aca llamamos el color que creamos en colors e importamos
      elevation: 0,
      title: Row(
        //con mainAxisAligent separaremos el appbar las tres lineas con el logo de tareas cada uno en una esquina
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            //ire la imagen
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                    'assets/images/icontareas.png') //este es el logo de tareas que va en la parte superior
                ),
          )
        ],
      ),
    );
  }
}
