// import 'package:chatterhub/src/models/todo.dart';
// import 'package:chatterhub/src/services/firestore_service.dart';
// import 'package:chatterhub/src/ui/widgets/todo_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:chatterhub/src/services/authentication_service.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final User user = context.read<AuthenticationService>().currentUser;
//     final TextEditingController _todoController = TextEditingController();

//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: ListView(children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     "Add Todo Here:",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Card(
//                     margin: const EdgeInsets.all(20),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               key: const ValueKey("addField"),
//                               controller: _todoController,
//                             ),
//                           ),
//                           IconButton(
//                             key: const ValueKey("addButton"),
//                             icon: const Icon(Icons.add),
//                             onPressed: () {
//                               if (_todoController.text != "") {
//                                 context.read<FirestoreService>().addTodo(
//                                       uid: user.uid,
//                                       content: _todoController.text,
//                                     );
//                                 _todoController.clear();
//                               }
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text(
//                     "Your Todos",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 360.0,
//                     child: StreamBuilder(
//                       stream: context
//                           .read<FirestoreService>()
//                           .streamTodos(uid: user.uid),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<List<TodoModel>> snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.active) {
//                           if (snapshot.data.isEmpty) {
//                             return const Center(
//                               child:
//                                   Text("You don't have any unfinished Todos"),
//                             );
//                           } else
//                             return ListView.builder(
//                               itemCount: snapshot.data.length,
//                               itemBuilder: (_, index) {
//                                 return TodoCard(
//                                   uid: user.uid,
//                                   todo: snapshot.data[index],
//                                 );
//                               },
//                             );
//                         } else {
//                           return const Center(
//                             child: Text("loading..."),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   Text(user.email),
//                   RaisedButton(
//                     onPressed: () {
//                       context.read<AuthenticationService>().signOut();
//                     },
//                     child: Text("Sign out"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
