import 'package:flutter/material.dart';
import 'package:password_validator/password_validator_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordValidatorProvider>(
          create: (_) => PasswordValidatorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PasswordValidatorProvider passwordValidatorProvider(
            {required bool renderUI}) =>
        Provider.of<PasswordValidatorProvider>(context, listen: renderUI);

    bool isValid =
        passwordValidatorProvider(renderUI: true).hasPasswordOneNumber &&
            passwordValidatorProvider(renderUI: true).isPasswordEightCharacters;

    bool hasEightChars =
        passwordValidatorProvider(renderUI: true).isPasswordEightCharacters;

    bool hasOneNumber =
        passwordValidatorProvider(renderUI: true).hasPasswordOneNumber;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Passowrd'),
              onChanged: (password) {
                passwordValidatorProvider(renderUI: false)
                    .onPasswordChanged(password);
              },
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            validatorBox(
              boxColor: hasEightChars ? Colors.green : Colors.transparent,
              borderColor:
                  hasEightChars ? Colors.transparent : Colors.grey.shade400,
              title: 'Contains 8 characters',
            ),
            const SizedBox(
              height: 10,
            ),
            validatorBox(
              boxColor: hasOneNumber ? Colors.green : Colors.transparent,
              borderColor:
                  hasOneNumber ? Colors.transparent : Colors.grey.shade400,
              title: 'Contains 1 number',
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              opacity: isValid ? 1 : 0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget validatorBox(
      {required Color boxColor,
      required Color borderColor,
      required String title}) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title),
      ],
    );
  }
}
