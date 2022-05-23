import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();
  String _errorMessage = '';
  bool buttonEnabled = false;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Error",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(translate('empty')),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('email_page.title')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(translate('email_page.write')),
            const SizedBox(height: 20),
            buildTextField(
              labelText: translate('email_page.to'), 
              hintText: "example@mail.com",
              controller: controllerTo,
            ),
            const SizedBox(height: 20),
            buildTextField(
              labelText: translate('email_page.subject'), 
              hintText: translate('email_page.my_subject'),
              controller: controllerSubject,
            ),
            const SizedBox(height: 20),
            buildTextField(
              labelText: translate('email_page.message'),
              hintText: translate('email_page.my_message'),
              maxLines: 16,
              controller: controllerMessage,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Text(translate('email_page.send').toUpperCase()),
              onPressed: () => launchEmail(
                toEmail: controllerTo.text,
                subject: controllerSubject.text,
                message: controllerMessage.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    if (buttonEnabled) {
      final Uri params = Uri(
        scheme: 'mailto',
        path: toEmail,
        query: 'subject=$subject&body=$message',
      );

      if (await canLaunchUrl(params)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(translate('email_page.sent')),
          backgroundColor: Colors.green,
        ));
        await launchUrl(params);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(translate('email_page.failed')),
          backgroundColor: Colors.red,
        ));
      }
    }
    else {
      showAlertDialog(context);
    }
  }

  Widget buildTextField({
    required String hintText,
    required String labelText,
    required TextEditingController controller,
    int maxLines = 1,
    }) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText,
          ),
          onChanged: (val) {
            validation(val);
          },
        )
      ],
    );

  void validation(String val) {
    if((controllerTo.text.isNotEmpty) && 
       (controllerSubject.text.isNotEmpty) && 
       (controllerMessage.text.isNotEmpty)) {
        setState(() {
          buttonEnabled = true;
        });
    }

    if (val.isEmpty) {
      setState(() {
        _errorMessage = translate('empty');
        buttonEnabled = false;
        print(buttonEnabled);
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}