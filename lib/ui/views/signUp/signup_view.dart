import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:Classmate/ui/widgets/export.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              //verticalSpaceLarge,
              // TODO: Add additional user data here to save (episode 2)
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 10.0),
              InputField(
                placeholder: 'Password',
                password: true,
                controller: passwordController,
                additionalNote: 'Password has to be a minimum of 6 characters.',
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //TODO: DEV wegmachen
                  FlatButton(
                    onPressed: model.logOut,
                    child: Text('signOut'),
                  ),

                  FlatButton(
                    onPressed: model.logIn,
                    child: Text('Login'),
                  ),
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.isBusy,
                    onPressed: () {
                      model.signUp(
                        type: 'email',
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(6.0),
                child: AppleSignInButton(
                  type: ButtonType.signIn, // style as needed
                  onPressed: () => model.signUp(type: 'apple'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
