import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pproyecto/DTO/User.dart';
import 'package:pproyecto/firebase_options.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Registro extends StatefulWidget {
  final User cadena;
  Registro(this.cadena);
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
        "PasswordUsuario":password.text,
        "Rol":'Invitado',
        "Estado":true,
      });
      print('envio correcto');
      mensaje('Información', 'Registro correcto');
    }catch(e){
      print('Error en insert ......  '+ e.toString());
    }
  }
  void mensaje(String titulo, String contenido){
    showDialog(context: context, builder: (buildcontext){
      return AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Aceptar', style: TextStyle(color: Colors.blueGrey),),
          )
        ],);
    });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios --->'+widget.cadena.nombre),
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
                  print('Enviando....');

                  if((correo.text.length!=0)&&(identidad.text.length!=0)&&(nombre.text.length!=0)&&(password.text.length!=0)&&(telefono.text.length!=0)){
                    var bytes = utf8.encode(password.text);
                    var encriptado = sha256.convert(bytes);
                    password.text = encriptado.toString();
                    print(encriptado);
                    insertarDatos();
                    correo.clear();
                    identidad.clear();
                    nombre.clear();
                    telefono.clear();
                    password.clear();

                  }else{
                    print('Todos los campos son olbigatorios');
                    print('Rellenar los campos en blanco');
                  }



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