import 'package:flutter/material.dart';
import '../widgets/app_input_field.dart';
import '../widgets/app_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Your reset logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppInputField(
                hint: 'Email',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v?.isEmpty ?? true) ? 'Enter email' : null,
              ),
              const SizedBox(height: 12),
              AppButton(label: 'Submit', onTap: _submit, isLoading: false,),
            ],
          ),
        ),
      ),
    );
  }
}
