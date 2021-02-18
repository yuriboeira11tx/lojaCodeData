import "package:flutter/material.dart";
import 'package:loja_codedata/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome",
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido";
                    return null;
                  },
                ),

                SizedBox(height: 16.0,),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    return null;
                  },
                ),

                SizedBox(height: 16.0,),

                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) return "Senha inválida";
                    return null;
                  },
                ),

                SizedBox(height: 16.0,),

                TextFormField(
                  controller: _adressController,
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido";
                    return null;
                  },
                ),

                SizedBox(height: 16.0,),

                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text("Criar Conta", style: TextStyle(fontSize: 18.0, color: Colors.white),),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _adressController.text,
                        };

                        print(userData);

                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    print("Criação de Usuário - Sucesso");

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário Criado com Sucesso"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    print("Criação de Usuário - Falha");

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha Ao Criar Usuário"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
