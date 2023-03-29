import 'package:flutter/material.dart';
import 'package:pproyecto/View/Geoposition.dart';


class HomeInvitado extends StatefulWidget {
  HomeInvitado();
  @override
  HomeInvitadoApp createState() => HomeInvitadoApp();

}
class HomeInvitadoApp extends State<HomeInvitado>{
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Invitado'),
        backgroundColor: Colors.lightBlueAccent,
      ),body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Geoposition()));

                    },
                    child: Text('Enviar'),
                  ),
                ),
        ],
      )
    );

  }
}