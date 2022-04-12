import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/usersPage.dart';
import 'package:flutter_tutorial/services/userService.dart';

class UserWidget extends StatelessWidget {
  final String name;
  final String age;
  final String passsword;

  UserWidget({
    required this.name, 
    required this.age, 
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
              title: Text(name),
              subtitle: Text(age + ' years old'),
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
                    await UserService().deleteUser(name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UsersPage()),
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

