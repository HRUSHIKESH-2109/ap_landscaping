import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

class providerPage extends StatefulWidget {
  final token;
  const providerPage({required this.token, Key? key}) : super(key: key);

  @override
  State<providerPage> createState() => _providerPageState();
}

class _providerPageState extends State<providerPage> {
  // late String userid;
  // @override
  // void initState() {
  //   super.initState();
  //   Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  //   userid = jwtDecodedToken['providerId'];
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Provider'
          )
        ],
      ),
    );
  }
}
