import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pproyecto/View/Registro.dart';
import 'firebase_options.dart';
import 'package:pproyecto/View/Registro.dart';

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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Password',
                      hintText: 'digite contraseña de usuario'
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
              child: ElevatedButton(
                onPressed: (){
                  print('Boton presionado');

                },
                child: Text('Enviar'),
              ),
              ),

              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Registro()));
                    print('Boton presionado');

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

