import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pproyecto/firebase_options.dart';
import 'package:pproyecto/DTO/User.dart';
import 'package:pproyecto/View/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

class HomeStart extends State<Home> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  User objUser = User();

  validarDatos() async {
    bool flag = false;
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        for (var cursor in usuario.docs) {
          if (correo.text == cursor.get('CorreoUsuario')) {
            if (pass.text == cursor.get('Password')) {
              print(cursor.get('NombreUsuario'));
              objUser.nombre = cursor.get('NombreUsuario');
              objUser.id=cursor.get('IdentidadUsuario');
              objUser.rol='Administrador';
              // objUser.estado=
            }
          }
          //print(cursor.get('User'));
        } //if (!flag)
        // mensajeGeneral('Mensaje', 'dato no encontrado');
      }
    } catch (e) {
      //mensajeGeneral('Error', e.toString());
      print('**************ERROR***********************' + e.toString());
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Línea 2'),
        ),
        body: Center(
          child: Padding(padding: EdgeInsets.all(40),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Login()));
              },
              child: Text('INGRESAR')
              ,
            ),
          ),
        ),
      ),
    );
  }
  void mensaje(String titulo, String contenido) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(contenido),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                },
                child:
                Text("OK", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }
}



