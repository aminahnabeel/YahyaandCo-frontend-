import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  int _passwordScore(String s) {
    var score = 0;
    if (s.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(s)) score++;
    if (RegExp(r'[0-9]').hasMatch(s)) score++;
    if (RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]').hasMatch(s)) score++;
    return score;
  }

  Color _strengthColor(int score, ThemeData theme) {
    switch (score) {
      case 0:
      case 1:
        return theme.colorScheme.error;
      case 2:
        return Colors.orange;
      case 3:
      case 4:
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.primary;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change password: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final score = _passwordScore(_newCtrl.text);

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Secure your account', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text('Update your password regularly and use a strong, unique password.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7))),
                      const SizedBox(height: 12),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _currentCtrl,
                              obscureText: _obscureCurrent,
                              decoration: InputDecoration(
                                labelText: 'Current password',
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureCurrent ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Enter current password';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _newCtrl,
                              obscureText: _obscureNew,
                              onChanged: (_) => setState(() {}),
                              decoration: InputDecoration(
                                labelText: 'New password',
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureNew ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Enter new password';
                                if (v.trim().length < 8) return 'Password must be at least 8 characters';
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (score / 4).clamp(0, 1),
                                    color: _strengthColor(score, theme),
                                    backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  ['Very weak', 'Weak', 'Okay', 'Strong', 'Very strong'][score],
                                  style: theme.textTheme.bodySmall?.copyWith(color: _strengthColor(score, theme)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _confirmCtrl,
                              obscureText: _obscureConfirm,
                              decoration: InputDecoration(
                                labelText: 'Confirm password',
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Confirm your password';
                                if (v != _newCtrl.text) return 'Passwords do not match';
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _submit,
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                child: _loading
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                    : const Text('Change password'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
