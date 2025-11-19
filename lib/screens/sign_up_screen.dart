import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/widgets/auth_text_field.dart';
import 'package:finbuddy_ai/widgets/auth_button.dart';
import 'package:finbuddy_ai/widgets/google_sign_in_button.dart';
import 'package:finbuddy_ai/widgets/error_view.dart';
import 'package:finbuddy_ai/utils/constants.dart';
import 'package:finbuddy_ai/utils/validators.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isGoogleSignInLoading = false;
  String? _errorMessage;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSignUp() async {
    setState(() {
      _errorMessage = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToTerms) {
      setState(() {
        _errorMessage =
            'Please agree to the Terms of Service and Privacy Policy';
      });
      return;
    }

    try {
      await ref.read(authActionsProvider.notifier).signUpWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
          );

      final authState = ref.read(authActionsProvider);
      if (authState.hasError && mounted) {
        setState(() {
          _errorMessage = authState.error.toString();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isGoogleSignInLoading = true;
      _errorMessage = null;
    });

    if (!_agreedToTerms) {
      setState(() {
        _isGoogleSignInLoading = false;
        _errorMessage =
            'Please agree to the Terms of Service and Privacy Policy';
      });
      return;
    }

    try {
      await ref.read(authActionsProvider.notifier).signInWithGoogle();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSignInLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authActionsProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                // Title
                Text(
                  'Create Account',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to get started with FinBuddy AI',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                // Error Message
                if (_errorMessage != null) ...[
                  InlineErrorView(
                    message: _errorMessage!,
                    onDismiss: () {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                // Name Field
                AuthTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  keyboardType: TextInputType.name,
                  validator: Validators.validateDisplayName,
                  enabled: !isLoading,
                  prefixIcon: const Icon(Icons.person_outlined),
                ),
                const SizedBox(height: 16),
                // Email Field
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  enabled: !isLoading,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 16),
                // Password Field
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Create a password',
                  isPassword: true,
                  validator: Validators.validatePassword,
                  enabled: !isLoading,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                AuthTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  isPassword: true,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  enabled: !isLoading,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                const SizedBox(height: 16),
                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _agreedToTerms = value ?? false;
                              });
                            },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                                setState(() {
                                  _agreedToTerms = !_agreedToTerms;
                                });
                              },
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: theme.textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Sign Up Button
                AuthButton(
                  text: 'Sign Up',
                  onPressed: _handleEmailSignUp,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),
                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: theme.colorScheme.outlineVariant),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.orDivider,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: theme.colorScheme.outlineVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Google Sign In Button
                GoogleSignInButton(
                  onPressed: _handleGoogleSignIn,
                  isLoading: _isGoogleSignInLoading,
                ),
                const SizedBox(height: 24),
                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed:
                          isLoading ? null : () => context.go('/sign-in'),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
