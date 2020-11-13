import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:Classmate/ui/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InputField(
              placeholder: 'Email',
              controller: emailController,
            ),
            SizedBox(height: 10.0),
            InputField(
              placeholder: 'Password',
              password: true,
              controller: passwordController,
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BusyButton(
                  title: 'Login',
                  busy: model.isBusy,
                  onPressed: () {
                    model.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 25.0),
            FlatButton(
              child: Text(
                'Create an Account if you\'re new.',
              ),
              onPressed: () {
                // TODO: Handle navigation
              },
            )
          ],
        ),
      )),
    );
  }
}
