import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/customerinfo.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({super.key});
  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  final _formKey = GlobalKey<FormState>();
  customerInfo customer_info = customerInfo();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/customersignin'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => customer_info.username = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a username' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => customer_info.email = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an email' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => customer_info.mobile_number = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a mobile number' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => customer_info.password = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a password' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) => value != _passwordController.text
                      ? 'Password does not match'
                      : null,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetailsPage(
                                customer_info: customer_info)),
                      );
                    }
                  },
                  child: const Text('Next'))
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDetailsPage extends StatefulWidget {
  final customerInfo customer_info;
  const PaymentDetailsPage({super.key, required this.customer_info});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  void cSignup(customerInfo customer_info) async {
    var regBody = {
        "username" : customer_info.username,
        "email" : customer_info.email,
        "mobilenumber": customer_info.mobile_number,
        "address": customer_info.address,
        "carddetails": customer_info.card_details,
        "cvv": customer_info.cvv,
        "paypalid": customer_info.paypal_id,
        "aectransfer": customer_info.aec_transfer,
        "cardtype": customer_info.card_type,
        "cardholdersname": customer_info.card_holders_name,
        "cardnumber": customer_info.card_number,
        "password": customer_info.password,
      };
      var response = await http.post(Uri.parse(customerRegister),
      headers: {
          "Content-Type": "application/json"  
        },
      body: jsonEncode(regBody)
      );
      // var jsonResponse = jsonDecode(response.body);
      if(response.statusCode == 201){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CongratsPage()),
                      );
      }else{
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.address = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an address' : null,
                ),
              ),
              // Padding(
              //       padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              //       child:
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Name of the Bank',
              //                         enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),),
              //   onSaved: (value) =>
              //       widget.customer_info.bank_name = value ?? '',
              //   validator: (value) =>
              //       value!.isEmpty ? 'Please enter the bank name' : null,
              // ),),
              // Padding(
              //       padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              //       child:
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Account number',
              //                         enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),),
              //   onSaved: (value) =>
              //       widget.customer_info.account_nummber = value ?? '',
              //   validator: (value) =>
              //       value!.isEmpty ? 'Please enter your Account number' : null,
              // ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Paypal ID',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.paypal_id = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your Paypal ID' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Card Details',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.card_details = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the card details' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'AEC Transfer',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.aec_transfer = value ?? '',
                  validator: (value) => value!.isEmpty ? 'AEC Transfer' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Type of card',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.card_type = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your card type' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Card Holder Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.card_holders_name = value ?? '',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter the card holder name'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.customer_info.card_number = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the card number' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => widget.customer_info.cvv =
                      int.tryParse(value ?? '0') ?? 0,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter cvv'
                      : null,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // save the details
                      cSignup(widget.customer_info);
                    }
                  },
                  child: const Text('Next'))
            ],
          ),
        ),
      ),
    );
  }
}

class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});
  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 250),
          const Text(
              'Congratulations you have been successfully registered!!\nPlease verify your email before logging in\nTo do so an email is sent to you,Click the verify button on it.'),
          const SizedBox(height: 75),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/customersignin');
            },
            child:
                const Text('Go to Login Page', style: TextStyle(fontSize: 18)),
          )
        ]),
      ),
    );
  }
}
