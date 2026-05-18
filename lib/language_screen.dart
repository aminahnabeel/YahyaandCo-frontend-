import 'package:flutter/material.dart';

import 'app_language.dart';
import 'email_screen.dart';
import 'splash_screen.dart';
import 'widgets/appbar.dart';
import 'widgets/button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  AppLanguage? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = appLanguageController.value;
  }

  void _selectLanguage(AppLanguage language) {
    setState(() {
      _selectedLanguage = language;
    });
    appLanguageController.value = language;
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;

    return Scaffold(
      appBar: CustomAppBar(
        showTitle: false,
        onBackPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const IntroScreen()),
          );
        },
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  strings.chooseLanguageTitle,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF101828),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  strings.chooseLanguageSubtitle,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF667085),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _LanguageCard(
                        flag: '🇺🇸',
                        name: strings.englishOption,
                        isSelected: _selectedLanguage == AppLanguage.english,
                        onTap: () => _selectLanguage(AppLanguage.english),
                      ),
                      const SizedBox(height: 14),
                      _LanguageCard(
                        flag: '🇵🇰',
                        name: strings.romanUrduOption,
                        isSelected: _selectedLanguage == AppLanguage.romanUrdu,
                        onTap: () => _selectLanguage(AppLanguage.romanUrdu),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SafeArea(
                  top: false,
                  child: RoundedPrimaryButton(
                    label: strings.continueButton,
                    icon: Icons.arrow_forward_rounded,
                    fullWidth: false,
                    height: 52,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const EmailScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.flag,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String flag;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF3F7FF) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? primary : const Color(0xFFE5E7EB),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? primary.withOpacity(0.08)
                    : Colors.black.withOpacity(0.04),
                blurRadius: isSelected ? 16 : 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                alignment: Alignment.center,
                child: Text(flag, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF101828),
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 24,
                height: 24,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: isSelected ? 1 : 0,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: primary,
                    size: 24,
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