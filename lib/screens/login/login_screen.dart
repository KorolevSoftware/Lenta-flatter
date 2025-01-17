import 'package:artstation/repositories/repositories.dart';
import 'package:artstation/screens/login/cubit/login_cubit.dart';
import 'package:artstation/screens/screens.dart';
import 'package:artstation/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(
                      content: state.failure.message
                  ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
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
                            const SizedBox(height: 12.0),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(hintText: 'Email'),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .emailChanged(value),
                              validator: (value) => !value.contains('@')
                                  ? 'Введите валидный email.'
                                  : null,
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .passwordChanged(value),
                              validator: (value) => value.length < 6
                                  ? 'Минимум 6 символов.'
                                  : null,
                            ),
                            const SizedBox(height: 28.0),
                            RaisedButton(
                              elevation: 1.0,
                              color: Colors.grey[850],
                              textColor: Colors.white,
                              onPressed: () => _submitForm(
                                context,
                                state.status == LoginStatus.submitting,
                              ),
                              child: const Text('Вход'),
                            ),
                            const SizedBox(height: 12.0),
                            RaisedButton(
                              elevation: 1.0,
                              color: Colors.grey[850],
                              textColor: Colors.white,
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignupScreen.routeName),
                              child: const Text('Регистрация'),
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