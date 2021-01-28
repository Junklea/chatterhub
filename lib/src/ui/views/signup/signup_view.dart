import 'package:chatterhub/src/ui/shared/ui_helpers.dart';
import 'package:chatterhub/src/ui/widgets/busy_button.dart';
import 'package:chatterhub/src/ui/widgets/input_field.dart';
import 'package:chatterhub/src/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceLarge,
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                    verticalSpaceLarge,
                    InputField(
                      placeholder: 'Full Name',
                      controller: fullNameController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Email',
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                      additionalNote:
                          'Password has to be a minimum of 6 characters.',
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                          title: 'Sign Up',
                          busy: model.isBusy,
                          onPressed: () {
                            model.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text,
                            );
                          },
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      'Log in if you already have an account',
                      onPressed: () {
                        model.navigateToLogin();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
