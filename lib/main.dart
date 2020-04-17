import 'package:flutter/material.dart';
import './controller/form_controller.dart';
import './model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNoController = TextEditingController();

  _showSnackbar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        emailController.text,
        mobileNoController.text,
      );

      FormController formController = FormController((String res) {
        print('Response = $res');
        if (res == FormController.STATUS_SUCCESS) {
          _showSnackbar('Feedback Submitted');
        } else {
          _showSnackbar('Error Occured!');
        }
      });
      _showSnackbar('Submitting Feedback');

      formController.submitForm(feedbackForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Spreadsheet App',
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Valid Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (val) {
                        if (!val.contains('@')) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: mobileNoController,
                      validator: (val) {
                        if (val.isEmpty || val.trim().length != 10) {
                          return 'Enter 10 Digit Proper Mobile Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: _submitForm,
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
