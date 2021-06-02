import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/repositories/repositories.dart';
import 'package:instagram_bloc/screens/signup/cubit/signup_cubit.dart';
import 'package:instagram_bloc/widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
          create: (_) =>
              SignupCubit(authRepository: context.read<AuthRepository>()),
          child: SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.status == SignupStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Instagram',
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Username'),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .usernameChanged(value),
                              validator: (value) => value.trim().isEmpty
                                  ? 'Please Enter a valid username'
                                  : null,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Email'),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .emailChanged(value),
                              validator: (value) => !value.contains('@')
                                  ? 'Please Enter a valid email'
                                  : null,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(hintText: 'Password'),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .passwordChanged(value),
                              validator: (value) => value.length < 6
                                  ? 'Must at least  6 character'
                                  : null,
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            RaisedButton(
                              onPressed: () => _submitForm(context,
                                  state.status == SignupStatus.submitting),
                              color: Theme.of(context).primaryColor,
                              elevation: 1.0,
                              textColor: Colors.white,
                              child: Text('Sign Up'),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            RaisedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              color: Colors.grey[200],
                              elevation: 1.0,
                              textColor: Colors.black,
                              child: Text('Back to login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}
