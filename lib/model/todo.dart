class ToDo {
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todoText, //este es el texto que mostraremos
    this.isDone =
        false, // boolean para saber si es true o false y saber si se completo la tarea o no
  });

  // las que no estan en true es por que no se han realizado, y se marcaran con una linea en el centro
  //el static se utiliza para declarar un miembro de clase atributo o metodo que pertenece a la misma clase en si, en lugar de cada
  //instancia individual de la clase
  //lista de tareas pendientes
  //si el texto esta entrue solo los que tengan texto true aparecen con la linea
  //si aparece la linea es por que ya realizaron las tareas
  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '01',
          todoText: 'Ejercicios de biceps en la mañana',
          isDone: true),
      ToDo(
          id: '02', todoText: 'Reunion de marketing a las 10 pm', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Almuerzo con Daniel a las 2 pm',
      ),
      ToDo(id: '04', todoText: 'Ejercicios de espalda dia 12-4', isDone: true),
      ToDo(
        id: '05',
        todoText: 'Ejercicios  en la mañana',
      ),
      ToDo(
        id: '06',
        todoText: 'Ejercicios  en la mañana',
      ),
      ToDo(
          id: '07', todoText: 'Ejercicios  en la tarde dia 3-04', isDone: true),
      ToDo(
        id: '08',
        todoText: 'Viajar a santamarta',
      ),
      ToDo(
        id: '09',
        todoText: 'Cumleaños Mama',
      ),
    ];
  }
}
