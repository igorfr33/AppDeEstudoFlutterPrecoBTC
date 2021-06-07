import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _valorDeCompra = "Valor de Compra:";
  String _valorDeVenda = "Valor de Venda:";

  _buscaPrecoBRL () async{
    String url = "https://blockchain.info/ticker";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valorDeCompra = "Valor de Compra BRL:" +retorno["BRL"]["buy"].toString();
    });

    setState(() {
      _valorDeVenda = "Valor de Venda BRL:" + retorno["BRL"]["sell"].toString();
    });
  }

  _buscaPrecoUSD () async{
    String url = "https://blockchain.info/ticker";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valorDeCompra = "Valor de Compra USD:" +retorno["USD"]["buy"].toString();
    });

    setState(() {
      _valorDeVenda = "Valor de Venda USD:" + retorno["USD"]["sell"].toString();
    });
  }

  void _limparCampo (){
    setState(() {
      _valorDeCompra = "Valor de Compra: ";
    });

    setState(() {
      _valorDeVenda = "Valor de Venda:";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preço Da Bitcoin"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/bitcoin.png"),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              _valorDeCompra,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              Text(
                _valorDeVenda,
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              RaisedButton(
              color: Colors.orange,
              child: Text("Atualizar BRL"),
              onPressed: _buscaPrecoBRL,
            ),
            RaisedButton(
              color: Colors.orange,
              child: Text("Atualizar USD"),
              onPressed: _buscaPrecoUSD,
            ),
                ],
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange,
                child: Text("Limpar Campos"),
                onPressed: _limparCampo,
                ),
                ],
              )
          ],
        ),
      ),
  );
  }
}