import 'package:flutter/material.dart';

enum AppLanguage {
  english,
  romanUrdu,
}

class AppLanguageController extends ValueNotifier<AppLanguage> {
  AppLanguageController() : super(AppLanguage.english);

  Locale get locale {
    switch (value) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.romanUrdu:
        return const Locale('ur', 'PK');
    }
  }

  AppStrings get strings => AppStrings.fromLanguage(value);
}

final AppLanguageController appLanguageController =
    AppLanguageController();

class AppStrings {
  const AppStrings({
    required this.appTitle,
    required this.chooseLanguageTitle,
    required this.chooseLanguageSubtitle,
    required this.englishOption,
    required this.romanUrduOption,
    required this.continueButton,
    required this.homeTitle,
    required this.homeMessage,
    required this.homeAction,
    required this.emailTitle,
    required this.emailPlaceholder,
    required this.passwordPlaceholder,
    required this.namePlaceholder, // ✅ ADDED
    required this.alreadyHaveAccount,
    required this.signIn,
    required this.nextButton,
  });

  final String appTitle;
  final String chooseLanguageTitle;
  final String chooseLanguageSubtitle;
  final String englishOption;
  final String romanUrduOption;
  final String continueButton;
  final String homeTitle;
  final String homeMessage;
  final String homeAction;
  final String emailTitle;
  final String emailPlaceholder;
  final String passwordPlaceholder;
  final String namePlaceholder; // ✅ ADDED
  final String alreadyHaveAccount;
  final String signIn;
  final String nextButton;

  static AppStrings fromLanguage(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return const AppStrings(
          appTitle: 'Yahya & Co',
          chooseLanguageTitle: 'Choose Language',
          chooseLanguageSubtitle:
              'Select the language you want to use in the app.',
          englishOption: 'English',
          romanUrduOption: 'Roman Urdu',
          continueButton: 'Continue',
          homeTitle: 'Home',
          homeMessage: 'You are now using the app in English.',
          homeAction: 'Start using the app',
          emailTitle: 'Create Account',
          emailPlaceholder: 'Enter Email Address',
          passwordPlaceholder: 'Enter Password',
          namePlaceholder: 'Enter Your Name', // ✅ ADDED
          alreadyHaveAccount: 'Already have an account?',
          signIn: 'Sign In',
          nextButton: 'Next',
        );

      case AppLanguage.romanUrdu:
        return const AppStrings(
          appTitle: 'Yahya & Co',
          chooseLanguageTitle: 'Zaban muntakhib karein',
          chooseLanguageSubtitle:
              'App ke liye apni zaban select karein.',
          englishOption: 'English',
          romanUrduOption: 'Roman Urdu',
          continueButton: 'Aagay barhein',
          homeTitle: 'Markazi Safha',
          homeMessage:
              'Aap ab app ko Roman Urdu mein istemal kar rahe hain.',
          homeAction: 'App istemal karna shuru karein',
          emailTitle: 'Account Banayein',
          emailPlaceholder: 'Email Address Darj Karein',
          passwordPlaceholder: 'Password Darj Karein',
          namePlaceholder: 'Apna naam likhein', // ✅ ADDED
          alreadyHaveAccount: 'Pehle se account hai?',
          signIn: 'Log In Karein',
          nextButton: 'Aagay',
        );
    }
  }
}