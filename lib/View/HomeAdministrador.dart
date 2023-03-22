import 'package:flutter/material.dart';


class HomeAdministrador extends StatefulWidget {
  HomeAdministrador();
  @override
  HomeAdministradorApp createState() => HomeAdministradorApp();

}
class HomeAdministradorApp extends State<HomeAdministrador>{
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Adminsitrador'),
        backgroundColor: Colors.redAccent,
      ),
    );

  }
}