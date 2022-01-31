import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart'; //WebView.

void main(){
  runApp(Browser());
}

class Browser extends StatefulWidget{
  Browser({Key? key}) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();

}

class _BrowserState extends State<Browser>{

  @override
  void initState(){
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged webState){
      print(webState.type);
    });
    super.initState();
  }

  //Método para buscar páginas y palabras, texto.
  void webviewProcess(){
    setState(() {
       if(control.text.contains('.')){
        urlBrowser = 'https://'+control.text;
      }else{
        urlBrowser = 'https://www.google.com/search?q='+control.text;
      }
      flutterWebviewPlugin.reloadUrl(urlBrowser);
    });
  }

  //Atributos.
  FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  var urlBrowser = 'https://www.google.com'; //Será asignado como url inicial.
  var control = TextEditingController(); //Texto obtenido.

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: WebviewScaffold(url: urlBrowser, withJavascript: true, withLocalStorage: true, withZoom: false, enableAppScheme: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFDBC9C5),
        shadowColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFFDBC9C5),
        ),
        
        //Botones: Buscar, volver, adelante, actualizar.
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: ()=> webviewProcess()), //Se ejecuta el método buscar cuando pulse la lupa.
          IconButton(onPressed: () => flutterWebviewPlugin.goBack(), icon: Icon(Icons.arrow_left)),
          IconButton(onPressed: () => flutterWebviewPlugin.goForward(), icon: Icon(Icons.arrow_right)),
          IconButton(onPressed: () => flutterWebviewPlugin.reload(), icon: Icon(Icons.refresh))
        ],

        //Barra buscadora.
        title: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.white.withOpacity(0.89)),
          padding: EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            textInputAction: TextInputAction.go,
            controller: control, //Recogemos texto para buscar.
            onSubmitted: (url)=>webviewProcess(), //Se ejecuta el método buscar cuando se busca desde teclado.
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: 'Buscar',
              hintStyle: TextStyle(
                color: Color(0xFFDBC9C5),
              )
            ),
          ),
        ),
      ),)
    );
  }



}