import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:pproyecto/View/HomeAdministrador.dart';
import 'package:pproyecto/View/Invitado.dart';
import 'package:pproyecto/View/Registro.dart';
import 'firebase_options.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'DTO/User.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

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
  final LocalAuthentication auth = LocalAuthentication();


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
              mensaje('Información',('Bienvenido '+cursor.get('Rol')), objUser);
              objUser.nombre= cursor.get('NombreUsuario');
              objUser.id= cursor.get('IdentidadUsuario');
              objUser.rol=cursor.get("Rol");
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
  void mensaje(String titulo, String contenido, objUser){
    showDialog(context: context, builder: (buildcontext){
      return AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
              if(objUser.rol=='Administrador'){
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeAdministrador()));
              }else if(objUser.rol=='Invitado'){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeInvitado()));
                }

            },
            child: Text('Aceptar', style: TextStyle(color: Colors.blueGrey),),
          )
        ],);
    });
  }
  //future ------> la respuesta se dara solo cuando este todo renderizado
  Future<bool> biometrico() async {
    //print("biométrico");

    // bool flag = true;
    bool authenticated = false;

    const androidString = const AndroidAuthMessages(
      cancelButton: "Cancelar",
      goToSettingsButton: "Ajustes",
      signInTitle: "Ingrese",
      //fingerprintNotRecognized: 'Error de reconocimiento de huella digital',
      goToSettingsDescription: "Confirme su huella",
      //fingerprintSuccess: 'Reconocimiento de huella digital exitoso',
      biometricHint: "Toque el sensor",
      //signInTitle: 'Verificación de huellas digitales',
      biometricNotRecognized: "Huella no reconocida",
      biometricRequiredTitle: "Required Title",
      biometricSuccess: "Huella reconocida",
      //fingerprintRequiredTitle: '¡Ingrese primero la huella digital!',
    );
    bool canCheckBiometrics = await auth.canCheckBiometrics;  //verificar si el biometrico esta disponible en el dispositivo
    // bool isBiometricSupported = await auth.();
    bool isBiometricSupported = await auth.isDeviceSupported();

    List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();
    print(canCheckBiometrics); //Returns trueB
    // print("support -->" + isBiometricSupported.toString());
    print(availableBiometrics.toString()); //Returns [BiometricType.fingerprint]
    try {
      authenticated = await auth.authenticate(
          localizedReason: "Autentíquese para acceder",
          useErrorDialogs: true,
          stickyAuth: true,
          //biometricOnly: true,
          androidAuthStrings: androidString);
      if (!authenticated) {
        authenticated = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }
    /* if (!mounted) {
        return;
      }*/

    return authenticated;
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
                    password.text = (sha256.convert(bytes)).toString();
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
              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(50, 50),
                  backgroundColor: Colors.black45),
                  onPressed: ()async{
                    if(await biometrico()){
                      mensaje('Huella', 'Huella encontrada', objUser);

                    }
                  },
                  child: Icon(Icons.fingerprint, size: 80,),
                ),
              ),
            ]
          ),

        ),
      ),
    );
  }
}

