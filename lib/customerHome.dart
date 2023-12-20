import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

class customerPage extends StatefulWidget {
  final token;
  const customerPage({required this.token, Key? key}) : super(key: key);

  @override
  State<customerPage> createState() => _customerPageState();
}

class _customerPageState extends State<customerPage> {
  // late String userid;
  // @override
  // void initState() {
  //   super.initState();
  //   Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  //   userid = jwtDecodedToken['customerId'];
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome customer'
          )
        ],
      ),
    );
  }
}
