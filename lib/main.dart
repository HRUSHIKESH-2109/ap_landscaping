import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './customerlogin.dart';
import './providerlogin.dart';
import './customersignup.dart';
import './providersignup.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AP Landscaping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routes: {
        '/home': (BuildContext ctx) => const MyHomePage(title: 'AP Landscaping'),
        '/customersignin': (BuildContext ctx) => const CustomerSignIn(),
        '/providersignin': (BuildContext ctx) => const ProviderSignIn(),
        '/customersignup': (BuildContext ctx) => const CustomerSignUp(),
        '/providersignup': (BuildContext ctx) => const ProviderSignUp(),
      },
      home: const MyHomePage(title: 'AP Landscaping'),
    );
    
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override 
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction:1, initialPage: 0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
             children: <Widget>[
              Expanded(
                child: PageView(controller: controller,
                  children: <Widget>[
                    Container(
                    color: Colors.green[100],
                  ),
                  Container(
                    color: Colors.green[100],
                  ),
                  Container(
                    color: Colors.green[100],
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          // backgroundColor: Colors.black87
                      ),
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/customersignin');
                      },
                      child: const Text('Customer', style :TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          // backgroundColor: Colors.black87
                      ),
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/providersignin');
                      },
                      child: const Text('Provider', style :TextStyle(fontSize: 18)),
                    ),
                    ]
                  ),
                  ),
                  ],
                  ),
        ),
        SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const WormEffect(),
          ),
      ]
          )

      ),
    );
  }
}
