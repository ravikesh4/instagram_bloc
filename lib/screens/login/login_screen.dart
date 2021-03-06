import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/repositories/repositories.dart';
import 'package:instagram_bloc/screens/login/cubit/login_cubit.dart';
import 'package:instagram_bloc/screens/screens.dart';
import 'package:instagram_bloc/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
          create: (_) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
          child: LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(content: state.failure.message),
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
                              decoration: InputDecoration(hintText: 'Email'),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
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
                                  .read<LoginCubit>()
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
                                  state.status == LoginStatus.submitting),
                              color: Theme.of(context).primaryColor,
                              elevation: 1.0,
                              textColor: Colors.white,
                              child: Text('Log In'),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            RaisedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignupScreen.routeName),
                              color: Colors.grey[200],
                              elevation: 1.0,
                              textColor: Colors.black,
                              child: Text('No account? Sign up'),
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
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
