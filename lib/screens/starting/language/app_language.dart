import 'package:flutter/material.dart';

enum AppLanguage { english, romanUrdu }

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

  String tr(String text) {
    if (value == AppLanguage.english) return text;
    return _romanUrduFallback[text] ?? text;
  }

  static const Map<String, String> _romanUrduFallback = {
    'Reports': 'Reports',
    'Cash Book': 'Cash Book',
    'View account-wise transactions and running balance':
        'Account wise transactions aur running balance dekhein',
    'Summary of all account debit and credit balances':
        'Tamam accounts ke debit aur credit balance ka khulasa',
    'Track all cash inflows and outflows with running balance':
        'Running balance ke sath tamam cash aamad aur kharch track karein',
    'Calculator': 'Calculator',
    'Search accounts, vouchers, transactions, notes':
        'Accounts, vouchers, transactions, notes search karein',
    'Accounts': 'Accounts',
    'Vouchers': 'Vouchers',
    'Transactions': 'Transactions',
    'Notes': 'Notes',
    'No results for': 'Koi result nahi mila',
    'Delete entry': 'Entry delete karein',
    'Are you sure you want to delete this journal entry?':
        'Kya aap waqai is journal entry ko delete karna chahte hain?',
    'Delete': 'Delete',
    'No journal entries': 'Koi journal entries nahi hain',
    'Tap to choose': 'Select karne ke liye tap karein',
    'Selected': 'Selected',
    'Say goodbye to messy records.': 'Bikhre huay records ko alvida kahen.',
    'With our smart ledger app, easily track your daily expenses, monitor your income, and stay financially organized without any hassle.':
        'Hamari smart ledger app se apne rozana kharch track karein, income monitor karein, aur asani se financial tor par munazzam rahein.',
    'Login': 'Log In Karein',
    'Account': 'Account',
    'Date': 'Tareekh',
    'As on': 'Bataur tareekh',
    'Description': 'Wazahat',
    'Balance': 'Balance',
    'Inflow': 'Aamad',
    'Outflow': 'Kharch',
    'Total Inflow': 'Kul Aamad',
    'Total Outflow': 'Kul Kharch',
    'Total Debit': 'Kul Debit',
    'Total Credit': 'Kul Credit',
    'Closing Balance': 'Ikhtitami Balance',
    'Trial Balance Not Balanced': 'Trial Balance barabar nahi hai',
    'Completed': 'Mukammal',
    'Voucher': 'Voucher',
    'N/A': 'Maujood nahi',
    'dd/mm/yyyy': 'dd/mm/yyyy',
    'Add notes...': 'Notes likhein...',
    'Enter description': 'Wazahat likhein',
    'Journal Voucher': 'Journal Voucher',
    'Cash Payment': 'Cash Payment',
    'Profit & Loss': 'Munafa aur Nuqsan',
    'Balance Sheet': 'Balance Sheet',
    'Revenue, expenses, and net profit calculation':
        'Aamad, kharch, aur khulis munafa ki gushmulhaa',
    'Assets, liabilities, and equity snapshot':
        'Zail, Zimadari, aur Hissay ka snapshot',
    'Profit': 'Munafa',
    'Loss': 'Nuqsan',
    'Total Income': 'Kul Aamad',
    'Total Expenses': 'Kul Kharch',
    'Net Profit': 'Khulis Munafa',
    'Net Loss': 'Khulis Nuqsan',
    'Assets': 'Zail',
    'Liabilities': 'Zimadari',
    'Total Assets': 'Kul Zail',
    'Total Liabilities': 'Kul Zimadari',
    'Balance Sheet Balanced': 'Balance Sheet Barabar hai',
    'Balance Sheet Not Balanced': 'Balance Sheet Barabar nahi hai',
  };
}

final AppLanguageController appLanguageController = AppLanguageController();

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
    required this.signInTitle,
    required this.signInSubtitle,
    required this.emailTitle,
    required this.nameLabel,
    required this.emailLabel,
    required this.passwordLabel,
    required this.emailPlaceholder,
    required this.passwordPlaceholder,
    required this.namePlaceholder, // ✅ ADDED
    required this.signUp,
    required this.alreadyHaveAccount,
    required this.signIn,
    required this.nextButton,
    required this.selectBusinessTitle,
    required this.selectBusinessSubtitle,
    required this.addBusinessTitle,
    required this.businessNameLabel,
    required this.businessTypeLabel,
    required this.saveBusiness,
    required this.enterBusinessFieldsError,
    required this.homeTabTitle,
    required this.transactionsTabTitle,
    required this.accountsTabTitle,
    required this.ledgerTabTitle,
    required this.settingsTabTitle,
    required this.totalBalance,
    required this.cashInHand,
    required this.receivables,
    required this.payables,
    required this.addTransaction,
    required this.addAccount,
    required this.journalEntry,
    required this.ledger,
    required this.recentTransactions,
    required this.officeRent,
    required this.clientPayment,
    required this.utilities,
    required this.salesRevenue,
    required this.today,
    required this.yesterday,
    required this.transactionsTitle,
    required this.searchTransactions,
    required this.allFilter,
    required this.creditFilter,
    required this.debitFilter,
    required this.addAccountTitle,
    required this.accountNameLabel,
    required this.accountNameHint,
    required this.accountTypeLabel,
    required this.accountCodeLabel,
    required this.accountCodeHint,
    required this.currencyLabel,
    required this.openingBalanceLabel,
    required this.createAccount,
    required this.cancel,
    required this.addTransactionTitle,
    required this.amountLabel,
    required this.typeLabel,
    required this.debitLabel,
    required this.creditLabel,
    required this.paymentMethodLabel,
    required this.dateLabel,
    required this.notesLabel,
    required this.saveTransaction,
    required this.ledgerAccountsTitle,
    required this.searchAccountHint,
    required this.journalListTitle,
    required this.preferencesSection,
    required this.accountSection,
    required this.informationSection,
    required this.notificationsLabel,
    required this.darkModeLabel,
    required this.twoFactorLabel,
    required this.changePasswordLabel,
    required this.emailPreferencesLabel,
    required this.manageBusinessesLabel,
    required this.aboutLedgerAppLabel,
    required this.termsConditionsLabel,
    required this.privacyPolicyLabel,
    required this.logoutLabel,
    required this.profileName,
    required this.profileEmail,
    required this.journalVoucherLabel,
    required this.journalDateLabel,
    required this.journalDescriptionLabel,
    required this.journalAccountLabel,
    required this.journalDebitLabel,
    required this.journalCreditLabel,
    required this.addLineButton,
    required this.removeLineButton,
    required this.saveEntryButton,
    required this.debitCreditMismatchError,
    required this.voucherTypeLabel,
    required this.voucherNumberLabel,
    required this.journalEntriesLabel,
    required this.journalEntryPageTitle,
    required this.trialBalanceTitle,
    required this.ledgerSummaryTitle,
    required this.totalLabel,
    required this.totalCreditsLabel,
    required this.totalDebitsLabel,
    required this.closingBalanceLabel,
    required this.profitAndLossTitle,
    required this.balanceSheetTitle,
    required this.profitAndLossDescription,
    required this.balanceSheetDescription,
    required this.profitLabel,
    required this.lossLabel,
    required this.totalIncomeLabel,
    required this.totalExpensesLabel,
    required this.netProfitLabel,
    required this.netLossLabel,
    required this.assetsLabel,
    required this.liabilitiesLabel,
    required this.totalAssetsLabel,
    required this.totalLiabilitiesLabel,
    required this.balanceSheetBalancedLabel,
    required this.balanceSheetNotBalancedLabel,
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
  final String signInTitle;
  final String signInSubtitle;
  final String emailTitle;
  final String nameLabel;
  final String emailLabel;
  final String passwordLabel;
  final String emailPlaceholder;
  final String passwordPlaceholder;
  final String namePlaceholder; // ✅ ADDED
  final String signUp;
  final String alreadyHaveAccount;
  final String signIn;
  final String nextButton;
  final String selectBusinessTitle;
  final String selectBusinessSubtitle;
  final String addBusinessTitle;
  final String businessNameLabel;
  final String businessTypeLabel;
  final String saveBusiness;
  final String enterBusinessFieldsError;
  final String homeTabTitle;
  final String transactionsTabTitle;
  final String accountsTabTitle;
  final String ledgerTabTitle;
  final String settingsTabTitle;
  final String totalBalance;
  final String cashInHand;
  final String receivables;
  final String payables;
  final String addTransaction;
  final String addAccount;
  final String journalEntry;
  final String ledger;
  final String recentTransactions;
  final String officeRent;
  final String clientPayment;
  final String utilities;
  final String salesRevenue;
  final String today;
  final String yesterday;
  final String transactionsTitle;
  final String searchTransactions;
  final String allFilter;
  final String creditFilter;
  final String debitFilter;
  final String addAccountTitle;
  final String accountNameLabel;
  final String accountNameHint;
  final String accountTypeLabel;
  final String accountCodeLabel;
  final String accountCodeHint;
  final String currencyLabel;
  final String openingBalanceLabel;
  final String createAccount;
  final String cancel;
  final String addTransactionTitle;
  final String amountLabel;
  final String typeLabel;
  final String debitLabel;
  final String creditLabel;
  final String paymentMethodLabel;
  final String dateLabel;
  final String notesLabel;
  final String saveTransaction;
  final String ledgerAccountsTitle;
  final String searchAccountHint;
  final String journalListTitle;
  final String preferencesSection;
  final String accountSection;
  final String informationSection;
  final String notificationsLabel;
  final String darkModeLabel;
  final String twoFactorLabel;
  final String changePasswordLabel;
  final String emailPreferencesLabel;
  final String manageBusinessesLabel;
  final String aboutLedgerAppLabel;
  final String termsConditionsLabel;
  final String privacyPolicyLabel;
  final String logoutLabel;
  final String profileName;
  final String profileEmail;
  final String journalVoucherLabel;
  final String journalDateLabel;
  final String journalDescriptionLabel;
  final String journalAccountLabel;
  final String journalDebitLabel;
  final String journalCreditLabel;
  final String addLineButton;
  final String removeLineButton;
  final String saveEntryButton;
  final String debitCreditMismatchError;
  final String voucherTypeLabel;
  final String voucherNumberLabel;
  final String journalEntriesLabel;
  final String journalEntryPageTitle;
  final String trialBalanceTitle;
  final String ledgerSummaryTitle;
  final String totalLabel;
  final String totalCreditsLabel;
  final String totalDebitsLabel;
  final String closingBalanceLabel;
  final String profitAndLossTitle;
  final String balanceSheetTitle;
  final String profitAndLossDescription;
  final String balanceSheetDescription;
  final String profitLabel;
  final String lossLabel;
  final String totalIncomeLabel;
  final String totalExpensesLabel;
  final String netProfitLabel;
  final String netLossLabel;
  final String assetsLabel;
  final String liabilitiesLabel;
  final String totalAssetsLabel;
  final String totalLiabilitiesLabel;
  final String balanceSheetBalancedLabel;
  final String balanceSheetNotBalancedLabel;

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
          signInTitle: 'Welcome back',
          signInSubtitle:
              'Log in to manage your businesses and ledger entries.',
          emailTitle: 'Create Account',
          nameLabel: 'Name',
          emailLabel: 'Email',
          passwordLabel: 'Password',
          emailPlaceholder: 'Enter Email Address',
          passwordPlaceholder: 'Enter Password',
          namePlaceholder: 'Enter Your Name', // ✅ ADDED
          signUp: 'Sign Up',
          alreadyHaveAccount: 'Already have an account?',
          signIn: 'Sign In',
          nextButton: 'Next',
          selectBusinessTitle: 'Select Business',
          selectBusinessSubtitle: 'Choose a business to manage',
          addBusinessTitle: 'Add Business',
          businessNameLabel: 'Business name',
          businessTypeLabel: 'Business type',
          saveBusiness: 'Save Business',
          enterBusinessFieldsError: 'Enter both name and business type.',
          homeTabTitle: 'Home',
          transactionsTabTitle: 'Transactions',
          accountsTabTitle: 'Accounts',
          ledgerTabTitle: 'Ledger',
          settingsTabTitle: 'Settings',
          totalBalance: 'Total Balance',
          cashInHand: 'Cash in Hand',
          receivables: 'Receivables',
          payables: 'Payables',
          addTransaction: 'Add Transaction',
          addAccount: 'Add Account',
          journalEntry: 'Journal Entry',
          ledger: 'Ledger',
          recentTransactions: 'Recent Transactions',
          officeRent: 'Office Rent',
          clientPayment: 'Client Payment',
          utilities: 'Utilities',
          salesRevenue: 'Sales Revenue',
          today: 'Today',
          yesterday: 'Yesterday',
          transactionsTitle: 'Transactions',
          searchTransactions: 'Search transactions',
          allFilter: 'All',
          creditFilter: 'Credit',
          debitFilter: 'Debit',
          addAccountTitle: 'Add Account',
          accountNameLabel: 'Account Name',
          accountNameHint: 'e.g., Main Bank Account',
          accountTypeLabel: 'Account Type',
          accountCodeLabel: 'Account Code',
          accountCodeHint: 'e.g., ACC-001',
          currencyLabel: 'Currency',
          openingBalanceLabel: 'Opening Balance',
          createAccount: 'Create Account',
          cancel: 'Cancel',
          addTransactionTitle: 'Add Transaction',
          amountLabel: 'Amount',
          typeLabel: 'Type',
          debitLabel: 'Debit',
          creditLabel: 'Credit',
          paymentMethodLabel: 'Payment Method',
          dateLabel: 'Date',
          notesLabel: 'Notes',
          saveTransaction: 'Save Transaction',
          ledgerAccountsTitle: 'Ledger Accounts',
          searchAccountHint: 'Search account name or code...',
          journalListTitle: 'Journal',
          preferencesSection: 'Preferences',
          accountSection: 'Account',
          informationSection: 'Information',
          notificationsLabel: 'Notifications',
          darkModeLabel: 'Dark Mode',
          twoFactorLabel: 'Two-Factor Auth',
          changePasswordLabel: 'Change Password',
          emailPreferencesLabel: 'Email Preferences',
          manageBusinessesLabel: 'Manage Businesses',
          aboutLedgerAppLabel: 'About Ledger App',
          termsConditionsLabel: 'Terms & Conditions',
          privacyPolicyLabel: 'Privacy Policy',
          logoutLabel: 'Logout',
          profileName: 'John Doe',
          profileEmail: 'john@example.com',
          journalVoucherLabel: 'Voucher',
          journalDateLabel: 'Date',
          journalDescriptionLabel: 'Description',
          journalAccountLabel: 'Account',
          journalDebitLabel: 'Debit',
          journalCreditLabel: 'Credit',
          addLineButton: 'Add Line',
          removeLineButton: 'Remove',
          saveEntryButton: 'Save Entry',
          debitCreditMismatchError: 'Debit and Credit totals must match',
          voucherTypeLabel: 'Voucher Type',
          voucherNumberLabel: 'Voucher Number',
          journalEntriesLabel: 'Journal Entries',
          journalEntryPageTitle: 'Create Journal Entry',
          trialBalanceTitle: 'Trial Balance',
          ledgerSummaryTitle: 'Ledger Summary',
          totalLabel: 'Total',
          totalCreditsLabel: 'Total Credits',
          totalDebitsLabel: 'Total Debits',
          closingBalanceLabel: 'Closing Balance',
          profitAndLossTitle: 'Profit & Loss',
          balanceSheetTitle: 'Balance Sheet',
          profitAndLossDescription:
              'Revenue, expenses, and net profit calculation',
          balanceSheetDescription: 'Assets, liabilities, and equity snapshot',
          profitLabel: 'Profit',
          lossLabel: 'Loss',
          totalIncomeLabel: 'Total Income',
          totalExpensesLabel: 'Total Expenses',
          netProfitLabel: 'Net Profit',
          netLossLabel: 'Net Loss',
          assetsLabel: 'Assets',
          liabilitiesLabel: 'Liabilities',
          totalAssetsLabel: 'Total Assets',
          totalLiabilitiesLabel: 'Total Liabilities',
          balanceSheetBalancedLabel: 'Balance Sheet Balanced',
          balanceSheetNotBalancedLabel: 'Balance Sheet Not Balanced',
        );

      case AppLanguage.romanUrdu:
        return const AppStrings(
          appTitle: 'Yahya & Co',
          chooseLanguageTitle: 'Zaban muntakhib karein',
          chooseLanguageSubtitle: 'App ke liye apni zaban select karein.',
          englishOption: 'English',
          romanUrduOption: 'Roman Urdu',
          continueButton: 'Aagay barhein',
          homeTitle: 'Markazi Safha',
          homeMessage: 'Aap ab app ko Roman Urdu mein istemal kar rahe hain.',
          homeAction: 'App istemal karna shuru karein',
          signInTitle: 'Khush aamdeed',
          signInSubtitle:
              'Apne businesses aur ledger entries manage karne ke liye login karein.',
          emailTitle: 'Account Banayein',
          nameLabel: 'Naam',
          emailLabel: 'Email',
          passwordLabel: 'Password',
          emailPlaceholder: 'Email Address Darj Karein',
          passwordPlaceholder: 'Password Darj Karein',
          namePlaceholder: 'Apna naam likhein', // ✅ ADDED
          signUp: 'Register Karein',
          alreadyHaveAccount: 'Pehle se account hai?',
          signIn: 'Log In Karein',
          nextButton: 'Aagay',
          selectBusinessTitle: 'Business muntakhib karein',
          selectBusinessSubtitle: 'Manage karne ke liye business chunein',
          addBusinessTitle: 'Business add karein',
          businessNameLabel: 'Business ka naam',
          businessTypeLabel: 'Business ki qism',
          saveBusiness: 'Business save karein',
          enterBusinessFieldsError:
              'Meharbani karke naam aur business type dono daalein.',
          homeTabTitle: 'Home',
          transactionsTabTitle: 'Transactions',
          accountsTabTitle: 'Accounts',
          ledgerTabTitle: 'Ledger',
          settingsTabTitle: 'Settings',
          totalBalance: 'Kul Balance',
          cashInHand: 'Cash Maujood',
          receivables: 'Wusooli',
          payables: 'Daini',
          addTransaction: 'Transaction add karein',
          addAccount: 'Account add karein',
          journalEntry: 'Journal Entry',
          ledger: 'Ledger',
          recentTransactions: 'Haal ki Transactions',
          officeRent: 'Office Kiraya',
          clientPayment: 'Client ki Adaigi',
          utilities: 'Utility Bills',
          salesRevenue: 'Sale ki Aamdani',
          today: 'Aaj',
          yesterday: 'Kal',
          transactionsTitle: 'Transactions',
          searchTransactions: 'Transactions dhoondein',
          allFilter: 'Sab',
          creditFilter: 'Credit',
          debitFilter: 'Debit',
          addAccountTitle: 'Account add karein',
          accountNameLabel: 'Account ka naam',
          accountNameHint: 'Misal: Main Bank Account',
          accountTypeLabel: 'Account ki qism',
          accountCodeLabel: 'Account code',
          accountCodeHint: 'Misal: ACC-001',
          currencyLabel: 'Currency',
          openingBalanceLabel: 'Ibtidai balance',
          createAccount: 'Account banayein',
          cancel: 'Cancel',
          addTransactionTitle: 'Transaction add karein',
          amountLabel: 'Raqam',
          typeLabel: 'Type',
          debitLabel: 'Debit',
          creditLabel: 'Credit',
          paymentMethodLabel: 'Adaigi ka tareeqa',
          dateLabel: 'Tareekh',
          notesLabel: 'Notes',
          saveTransaction: 'Transaction save karein',
          ledgerAccountsTitle: 'Ledger Accounts',
          searchAccountHint: 'Account ka naam ya code dhoondein...',
          journalListTitle: 'Journal',
          preferencesSection: 'Tarjeehat',
          accountSection: 'Account',
          informationSection: 'Maloomat',
          notificationsLabel: 'Notifications',
          darkModeLabel: 'Dark Mode',
          twoFactorLabel: 'Two-Factor Auth',
          changePasswordLabel: 'Password badlein',
          emailPreferencesLabel: 'Email tarjeehat',
          manageBusinessesLabel: 'Businesses manage karein',
          aboutLedgerAppLabel: 'Ledger App ke bare me',
          termsConditionsLabel: 'Terms & Conditions',
          privacyPolicyLabel: 'Privacy Policy',
          logoutLabel: 'Logout',
          profileName: 'John Doe',
          profileEmail: 'john@example.com',
          journalVoucherLabel: 'Voucher',
          journalDateLabel: 'Date',
          journalDescriptionLabel: 'Wazahat',
          journalAccountLabel: 'Account',
          journalDebitLabel: 'Debit',
          journalCreditLabel: 'Credit',
          addLineButton: 'Line add karein',
          removeLineButton: 'Hatayein',
          saveEntryButton: 'Entry save karein',
          debitCreditMismatchError:
              'Debit aur Credit ka total barabar hona chahiye',
          voucherTypeLabel: 'Voucher ki qism',
          voucherNumberLabel: 'Voucher number',
          journalEntriesLabel: 'Journal Entries',
          journalEntryPageTitle: 'Journal Entry banayein',
          trialBalanceTitle: 'Trial Balance',
          ledgerSummaryTitle: 'Ledger Summary',
          totalLabel: 'Total',
          totalCreditsLabel: 'Kul Credits',
          totalDebitsLabel: 'Kul Debits',
          closingBalanceLabel: 'Ikhtitami Balance',
          profitAndLossTitle: 'Munafa aur Nuqsan',
          balanceSheetTitle: 'Balance Sheet',
          profitAndLossDescription:
              'Aamad, kharch, aur khulis munafa ki gushmulhaa',
          balanceSheetDescription: 'Zail, Zimadari, aur Hissay ka snapshot',
          profitLabel: 'Munafa',
          lossLabel: 'Nuqsan',
          totalIncomeLabel: 'Kul Aamad',
          totalExpensesLabel: 'Kul Kharch',
          netProfitLabel: 'Khulis Munafa',
          netLossLabel: 'Khulis Nuqsan',
          assetsLabel: 'Zail',
          liabilitiesLabel: 'Zimadari',
          totalAssetsLabel: 'Kul Zail',
          totalLiabilitiesLabel: 'Kul Zimadari',
          balanceSheetBalancedLabel: 'Balance Sheet Barabar hai',
          balanceSheetNotBalancedLabel: 'Balance Sheet Barabar nahi hai',
        );
    }
  }
}
