import 'package:app/api/users.dart';
import 'package:app/members_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  User user;
  ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(user.img),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.email,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.flat,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.account_box),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        title: const Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user.username),
                      ),
                      ListTile(
                        title: const Text(
                          'Phone',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user.phone),
                      ),
                      ListTile(
                        title: const Text(
                          'Member Since',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user.memberSince),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MembersPage()));
                    },
                    icon: const Icon(Icons.people),
                    label: const Text('View Other Members'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
