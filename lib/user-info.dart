import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/constants.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              const Image(
                image: AssetImage('assets/userInfo.jpg'),
              ),
              Text('What should we call you?',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
              TextField(
                controller: controller,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                maxLength: 5,
                decoration: InputDecoration(
                    hintText: 'Enter your name here.', focusColor: Colors.red),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      final localStorage = GetStorage();
                      localStorage.write(
                          AppConstants.user, controller.value.text);
                      context.go('/timer');
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.red[400],
                      size: 40,
                      weight: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
