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
  String? _selectedLanguageId;

  @override
  void initState() {
    super.initState();

    _selectedLanguageId =
        appLanguageController.value == AppLanguage.romanUrdu
            ? 'romanUrdu'
            : 'english';
  }

  void _selectLanguage(String languageId) {
    setState(() {
      _selectedLanguageId = languageId;
    });

    appLanguageController.value =
        languageId == 'romanUrdu'
            ? AppLanguage.romanUrdu
            : AppLanguage.english;
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;

    final options = <_LanguageOption>[
      _LanguageOption(
        id: 'english',
        label: strings.englishOption,
        flag: '🇬🇧',
        accentColor: const Color(0xFF2563EB),
      ),
      _LanguageOption(
        id: 'romanUrdu',
        label: strings.romanUrduOption,
        flag: '🇵🇰',
        accentColor: const Color(0xFF0F766E),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: CustomAppBar(
        title: strings.chooseLanguageTitle,
        showTitle: true,
        onBackPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const IntroScreen(),
            ),
          );
        },
      ),

      body: SafeArea(
        child: Stack(
          children: [
            const _LanguageBackdrop(),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: options.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 22,
                          crossAxisSpacing: 22,
                          childAspectRatio: 0.92,
                        ),
                        itemBuilder: (context, index) {
                          final option = options[index];
                          final isSelected =
                              _selectedLanguageId == option.id;

                          return AnimatedScale(
                            duration: const Duration(milliseconds: 220),
                            scale: isSelected ? 1.02 : 1.0,
                            child: _LanguageOptionCard(
                              option: option,
                              isSelected: isSelected,
                              onTap: () => _selectLanguage(option.id),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  RoundedPrimaryButton(
                    label: strings.continueButton,
                    icon: null,
                    fullWidth: false,
                    height: 52,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EmailScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.id,
    required this.label,
    required this.flag,
    required this.accentColor,
  });

  final String id;
  final String label;
  final String flag;
  final Color accentColor;
}

class _LanguageOptionCard extends StatelessWidget {
  const _LanguageOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),

          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    option.accentColor.withValues(alpha: 0.20),
                    Colors.white,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    const Color(0xFFF8FAFC),
                  ],
                ),

          border: Border.all(
            color: isSelected
                ? option.accentColor.withValues(alpha: 0.55)
                : const Color(0xFFE5E7EB),
            width: 1.2,
          ),

          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? option.accentColor.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 78,
                width: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: isSelected
                      ? option.accentColor.withValues(alpha: 0.14)
                      : const Color(0xFFF1F5F9),
                ),
                child: Center(
                  child: Text(
                    option.flag,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                option.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
              ),

              const SizedBox(height: 10),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isSelected
                      ? option.accentColor.withValues(alpha: 0.12)
                      : const Color(0xFFF3F4F6),
                ),
                child: Text(
                  isSelected ? 'Selected' : 'Tap to choose',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? option.accentColor
                        : const Color(0xFF6B7280),
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

class _LanguageBackdrop extends StatelessWidget {
  const _LanguageBackdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -70,
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2563EB).withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -90,
            right: -70,
            child: Container(
              height: 260,
              width: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0F766E).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}