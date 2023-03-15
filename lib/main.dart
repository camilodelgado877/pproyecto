import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pproyecto/View/Registro.dart';
import 'firebase_options.dart';
import 'package:pproyecto/View/Registro.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'DTO/User.dart';

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

class HomeStart extends State<Home>{
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  User objUser = User();

  validarDatos() async{
    try{
      CollectionReference ref= FirebaseFirestore.instance.collection('Usuarios');
      QuerySnapshot usuario = await ref.get();


      if(usuario.docs.length !=0){
        for(var cursor in usuario.docs){
          if(cursor.get('CorreoUsuario')==correo.text){
            print('Usuario encontrado');
            print(cursor.get('IdentidadUsuario'));
            if(cursor.get('PasswordUsuario')==password.text){
              print('*************Acceso aceptado****************');
              objUser.nombre= cursor.get('NombreUsuario');

              correo.clear();
              password.clear();
            }
          }
        }

      }else{
        print('no hay documentos en la colección');
      }

    }catch(e){
      print('Error....'+e.toString());
    }
  }

  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Bienvenidos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Linea 2 '),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10, left: 10, right:10),
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/login.png'),
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Email User',
                  hintText: 'digite email de usuario'
                ), 
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Password',
                      hintText: 'digite contraseña de usuario'
                  ),
                  obscureText: true,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
              child: ElevatedButton(
                onPressed: (){

                  if((correo.text.length!=0)&&(password.text.length!=0)){
                    var bytes = utf8.encode(password.text);
                    var encriptado = sha256.convert(bytes);
                    password.text = encriptado.toString();
                    print(encriptado);
                    print('Ingresando.....');
                    validarDatos();



                  }else{

                    print('Todos los campos son obligatorios');
                    print('Rellenar los campos vacios');
                  }

                },
                child: Text('Enviar'),
              ),
              ),

              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Registro(objUser)));
                  },
                  child: Text('Registrar  '),
                ),
              ),
            ]
          ),

        ),
      ),
    );
  }
}

