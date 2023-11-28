import 'package:dog_breeds_app/helpers/myListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const platform = MethodChannel('platform_channel');

  Future<String> getOSVersion() async {
    String osVersion;
    try {
      osVersion = await platform.invokeMethod('getPlatformVersion');
    } on PlatformException catch (e) {
      osVersion = 'Failed to get OS version: ${e.message}';
    }
    return osVersion;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<String>(
          future: getOSVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  MyListTile(
                      icon: Icons.info_outline,
                      text: "Help",
                      icon2: Icons.north_east,
                      onTap: () {}),
                  Divider(height: 5,),
                  MyListTile(
                      icon: Icons.star_border,
                      text: "Rate Us",
                      icon2: Icons.north_east,
                      onTap: () {}),
                  Divider(height: 5,),
                  MyListTile(
                      icon: Icons.ios_share,
                      text: "Share with Friends",
                      icon2: Icons.north_east,
                      onTap: () {}),
                  Divider(height: 5,),
                  MyListTile(
                      icon: Icons.rule,
                      text: "Terms of Use",
                      icon2: Icons.north_east,
                      onTap: () {}),
                  Divider(height: 5,),
                  MyListTile(
                      icon: Icons.verified_user_outlined,
                      text: "Privacy Policy",
                      icon2: Icons.north_east,
                      onTap: () {}),
                  Divider(height: 5,),
                  ListTile(
                    leading: Icon(
                      Icons.account_tree_outlined,
                      size: 27,
                    ),
                    title: Text(
                      "OS Version",
                      style: TextStyle(fontSize: 22),
                    ),
                    trailing: Text(
                      "${snapshot.data ?? "Not available"}",
                      style: TextStyle(fontSize: 20,color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
