import 'package:flutter/material.dart';


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
      ),
    );

  }
}