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
    final url = 
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
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
        )
      ],
    );
}