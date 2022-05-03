import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/menuPage.dart';
import 'package:flutter_tutorial/services/customerService.dart';

class UserWidget extends StatelessWidget {
  final String customerName;
  final String fullName;
  final String email;
  final String passsword;

  UserWidget({
    required this.customerName, 
    required this.fullName, 
    required this.email,
    required this.passsword});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: const Icon(Icons.person),
              title: Text(fullName),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(customerName),
                  const SizedBox(width: 65),
                  Text(email)
                ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*
                TextButton(
                  child: const Text('INFO',
                  style: TextStyle(
                    color: Colors.green
                  ),),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                */
                TextButton(
                  child: const Text('DELETE', 
                  style: TextStyle(
                    color: Colors.red
                  ),),
                  onPressed: () async {
                    //await UserService().deleteCustomer(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MenuPage()),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
    
}
}

