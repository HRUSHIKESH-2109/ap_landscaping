import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/providerinfo.dart';
import 'package:multiselect/multiselect.dart';

class ProviderSignUp extends StatefulWidget {
  const ProviderSignUp({super.key});
  @override
  State<ProviderSignUp> createState() => _ProviderSignUpState();
}

class _ProviderSignUpState extends State<ProviderSignUp> {
  final _formKey = GlobalKey<FormState>();
  providerInfo provider_info = providerInfo();
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
              Navigator.of(context).pushReplacementNamed('/providersignin'),
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
                  onSaved: (value) => provider_info.username = value ?? '',
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
                  onSaved: (value) => provider_info.email = value ?? '',
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
                  onSaved: (value) => provider_info.mobile_number = value ?? '',
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
                  onSaved: (value) => provider_info.password = value ?? '',
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
                  // validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
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
                            builder: (context) => QualificationsPage(
                                provider_info: provider_info)),
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

class QualificationsPage extends StatefulWidget {
  final providerInfo provider_info;
  QualificationsPage({super.key, required this.provider_info});
  @override
  _QualificationsPageState createState() => _QualificationsPageState();
}

class _QualificationsPageState extends State<QualificationsPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> Services = ['Apple', 'Banana', 'Grapes', 'Orange', 'Mango'];
  // Modify this list with the actual list of services
  List<String> selectedServices = [];
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
                      widget.provider_info.address = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an address' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Qualifications',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.provider_info.qualifications = value ?? '',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your Qualifications'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Years of Experience',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => widget.provider_info.years_of_experience =
                      int.tryParse(value ?? '0') ?? 0,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your years of experience'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => widget.provider_info.bio = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Let customers know you' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black), // Border color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropDownMultiSelect(
                    options: Services,
                    selectedValues: selectedServices,
                    onChanged: (value) {
                      setState(() {
                        selectedServices = value;
                        widget.provider_info.services = value;
                      });
                    },
                    whenEmpty: 'Select the services you can provide.',
                  ),
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
                                provider_info: widget.provider_info)),
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
  final providerInfo provider_info;
  const PaymentDetailsPage({super.key, required this.provider_info});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
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
                    labelText: 'Name of the Bank',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.provider_info.bank_name = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the bank name' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Account number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.provider_info.account_nummber = value ?? '',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your Account number'
                      : null,
                ),
              ),
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
                      widget.provider_info.paypal_id = value ?? '',
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
                      widget.provider_info.card_details = value ?? '',
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
                      widget.provider_info.aec_transfer = value ?? '',
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
                      widget.provider_info.card_type = value ?? '',
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
                      widget.provider_info.card_holders_name = value ?? '',
                  validator: (value) => value!.isEmpty
                      ? 'Please enter the card holder name'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) =>
                      widget.provider_info.card_number = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the card number' : null,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // save the details

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CongratsPage()),
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
              Navigator.of(context).pushReplacementNamed('/providersignin');
            },
            child:
                const Text('Go to Login Page', style: TextStyle(fontSize: 18)),
          )
        ]),
      ),
    );
  }
}
