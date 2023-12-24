import 'dart:convert';
import 'package:ap_landscaping/providerHome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';

class ProviderSignIn extends StatefulWidget {
  const ProviderSignIn({super.key});
  @override
  State<ProviderSignIn> createState() => _ProviderSignInState();
}

class _ProviderSignInState extends State<ProviderSignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void pLogin() async {
    var pBody = {
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await http.post(Uri.parse(providerLogin),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(pBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      prefs.setString('userOrProvider', 'provider');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => providerPage(token: myToken)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              // content: Text(err.message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('AP Landscaping'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
        ),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            const SizedBox(height: 50),
            const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Provider SignIn',
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Enter Email Address",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email Address';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  }
                  // else if (value.length < 6) {
                  //   return 'Password must be atleast 6 characters!';
                  // }
                  return null;
                },
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     //forgot password screen
            //   },
            //   child: const Text(
            //     'Forgot Password',
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      // style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<
                      //         Color>(Colors.black87)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          //auth
                          pLogin();
                        }
                      },
                      child: const Text('SignIn'),
                    ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // google + apple sign in buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button
                InkWell(
                  onTap: () {
                    // auth
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: const Image(
                      image: AssetImage('lib/assets/images/google.png'),
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // apple button
                InkWell(
                  onTap: () {
                    // auth
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: const Image(
                      image: AssetImage('lib/assets/images/apple.png'),
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 75),
            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/providersignup');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove padding
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Minimize the tap target size
                  ),
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ]))),
    );
  }
}
