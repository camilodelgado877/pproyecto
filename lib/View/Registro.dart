import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pproyecto/firebase_options.dart';

class Registro extends StatefulWidget {
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<Registro>{
  TextEditingController nombre = TextEditingController();
  TextEditingController identidad = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController password = TextEditingController();
  final firebase = FirebaseFirestore.instance; // Instancia de firebase

  insertarDatos() async{
    try{
      //await cargara solo si esta completa la instrucción
      await firebase.collection('Usuarios').doc().set({
        "NombreUsuario":nombre.text,
        "IdentidadUsuario":identidad.text,
        "CorreoUsuario":correo.text,
        "TelefonoUsuario":telefono.text,
        "ContraseñaUsuario":password.text,
      });
      print('envio correcto');
    }catch(e){
      print('Error en insert ......  '+ e.toString());
    }
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10, left: 10, right:10),
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/registro.png'),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
            child: TextField(
              controller: nombre,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre'
              ),
              style: TextStyle(
                  color: Color(0xFF0097ff),
                  fontSize: 30
              ),
            ),
            ),
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: TextField(
                controller: identidad,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Identidad',
                  hintText: 'Digite el numero de identificación'
                ),
                style: TextStyle(
                  color: Color(0xFF0097ff),
                    fontSize: 30
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Correo',
                  hintText: 'Ingrese el correo electronico'
                ),
                style: TextStyle(
                    color: Color(0xFF0097ff),
                    fontSize: 30
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: TextField(
                controller: telefono,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Telefono',
                  hintText: 'Digite el numero de contacto'
                ),
                style: TextStyle(
                    color: Color(0xFF0097ff),
                  fontSize: 30
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Digite la contraseña'
                ),
                style: TextStyle(
                    color: Color(0xFF0097ff),
                    fontSize: 30
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
              child: ElevatedButton(
                onPressed: (){
                  print(nombre.text);
                  print(identidad.text);
                  print(correo.text);
                  print(telefono.text);
                  //correo.text='boton presionado';
                  insertarDatos();

                },
                child: Text('Registrar',
                style: TextStyle(
                  fontSize: 40
                ),),
              ),
            ),
          ],
        ),
      ),
    );

  }
}