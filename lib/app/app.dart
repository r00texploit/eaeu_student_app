import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:student/cubits/PaymentsDetailsCubit.dart';
import 'package:student/cubits/paymentsCubit.dart';
import 'package:student/cubits/resultsOnlineCubit.dart';
import 'package:student/cubits/studentPaidDetailsCubit.dart';
import 'package:student/cubits/studentPayDetailsCubit.dart';
import 'package:student/data/repositories/paidRepository.dart';
import 'package:student/data/repositories/paymentDetailsRepository.dart';
import 'package:student/data/repositories/paymentRepository.dart';

import 'package:student/data/repositories/resultRepository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:student/app/appLocalization.dart';
import 'package:student/app/routes.dart';

import 'package:student/cubits/appConfigurationCubit.dart';
import 'package:student/cubits/appLocalizationCubit.dart';
import 'package:student/cubits/authCubit.dart';
import 'package:student/cubits/examDetailsCubit.dart';
import 'package:student/cubits/examsOnlineCubit.dart';
import 'package:student/cubits/feesPaymentCubit.dart';
import 'package:student/cubits/feesReceiptCubit.dart';
import 'package:student/cubits/noticeBoardCubit.dart';
import 'package:student/cubits/notificationSettingsCubit.dart';
import 'package:student/cubits/postFeesPaymentCubit.dart';
import 'package:student/cubits/reportTabSelectionCubit.dart';
import 'package:student/cubits/resultTabSelectionCubit.dart';
import 'package:student/cubits/studentFeesCubit.dart';
import 'package:student/cubits/studentSubjectAndSlidersCubit.dart';
import 'package:student/cubits/examTabSelectionCubit.dart';

import 'package:student/data/repositories/announcementRepository.dart';
import 'package:student/data/repositories/authRepository.dart';
import 'package:student/data/repositories/examRepository.dart';
import 'package:student/data/repositories/settingsRepository.dart';
import 'package:student/data/repositories/studentRepository.dart';
import 'package:student/data/repositories/systemInfoRepository.dart';

import 'package:student/ui/screens/exam/onlineExam/cubits/examOnlineCubit.dart';
import 'package:student/ui/screens/home/cubits/paymentsTabSelectionCubit.dart';
import 'package:student/ui/screens/reports/cubits/onlineExamReportCubit.dart';
import 'package:student/ui/screens/reports/cubits/assignmentReportCubit.dart';
import 'package:student/ui/screens/reports/repositories/reportRepository.dart';
import 'package:student/ui/styles/colors.dart';

import 'package:student/utils/appLanguages.dart';
import 'package:student/utils/hiveBoxKeys.dart';
import 'package:student/utils/notificationUtility.dart';
import 'package:student/utils/uiUtils.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Register the licence of font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  await NotificationUtility.initializeAwesomeNotification();

  await Hive.initFlutter();
  await Hive.openBox(showCaseBoxKey);
  await Hive.openBox(authBoxKey);

  await Hive.openBox(settingsBoxKey);
  await Hive.openBox(studentSubjectsBoxKey);

  runApp(const MyApp());
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationUtility.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationUtility.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationUtility.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationUtility.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //preloading some of the imaegs
    precacheImage(
      AssetImage(UiUtils.getImagePath("upper_pattern.png")),
      context,
    );

    precacheImage(
      AssetImage(UiUtils.getImagePath("lower_pattern.png")),
      context,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLocalizationCubit>(
          create: (_) => AppLocalizationCubit(SettingsRepository()),
        ),
        BlocProvider<NotificationSettingsCubit>(
          create: (_) => NotificationSettingsCubit(SettingsRepository()),
        ),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider<StudentSubjectsAndSlidersCubit>(
          create: (_) => StudentSubjectsAndSlidersCubit(
            studentRepository: StudentRepository(),
            systemRepository: SystemRepository(),
          ),
        ),
        BlocProvider<NoticeBoardCubit>(
          create: (context) => NoticeBoardCubit(AnnouncementRepository()),
        ),
        BlocProvider<AppConfigurationCubit>(
          create: (context) => AppConfigurationCubit(SystemRepository()),
        ),
        BlocProvider<ExamDetailsCubit>(
          create: (context) => ExamDetailsCubit(StudentRepository()),
        ),

        //
        BlocProvider<StudentFeesCubit>(
          create: (context) => StudentFeesCubit(StudentRepository()),
        ),
        BlocProvider<FeesPaymentCubit>(
          create: (context) => FeesPaymentCubit(StudentRepository()),
        ),
        BlocProvider<PostFeesPaymentCubit>(
          create: (context) => PostFeesPaymentCubit(StudentRepository()),
        ),
        BlocProvider<FeesReceiptCubit>(
          create: (context) => FeesReceiptCubit(StudentRepository()),
        ),

        BlocProvider<ResultTabSelectionCubit>(
          create: (_) => ResultTabSelectionCubit(),
        ),
        BlocProvider<ReportTabSelectionCubit>(
          create: (_) => ReportTabSelectionCubit(),
        ),

        BlocProvider<OnlineExamReportCubit>(
          create: (_) => OnlineExamReportCubit(ReportRepository()),
        ),
        BlocProvider<AssignmentReportCubit>(
          create: (_) => AssignmentReportCubit(ReportRepository()),
        ),

        BlocProvider<ExamTabSelectionCubit>(
          create: (_) => ExamTabSelectionCubit(),
        ),
        BlocProvider<ExamOnlineCubit>(
          create: (_) => ExamOnlineCubit(ExamOnlineRepository()),
        ),
        BlocProvider<ExamsOnlineCubit>(
          create: (_) => ExamsOnlineCubit(ExamOnlineRepository()),
        ),
        BlocProvider<StudentPayDetailsCubit>(
          create: (_) => StudentPayDetailsCubit(PaymentRepository()),
        ),
        BlocProvider<PaymentsTabSelectionCubit>(
          create: (_) => PaymentsTabSelectionCubit(),
        ),
        BlocProvider<PaymentsCubit>(
          create: (_) => PaymentsCubit(PaymentRepository()),
        ),
        BlocProvider<PaymentsDetailsCubit>(
          create: (_) => PaymentsDetailsCubit(PaymentDetailsRepository()),
        ),
        //  BlocProvider<PaymentsTabSelectionCubit>(
        //   create: (_) => PaymentsTabSelectionCubit(),
        // ),
        BlocProvider<StudentPaidDetailsCubit>(
          create: (_) => StudentPaidDetailsCubit(PaidRepository()),
        ),

        BlocProvider<ResultsOnlineCubit>(
          create: (_) => ResultsOnlineCubit(ResultOnlineRepository()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final currentLanguage =
              context.watch<AppLocalizationCubit>().state.language;

          return MaterialApp(
            navigatorKey: UiUtils.rootNavigatorKey,
            theme: Theme.of(context).copyWith(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              scaffoldBackgroundColor: pageBackgroundColor,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: onPrimaryColor,
                    secondary: secondaryColor,
                    background: backgroundColor,
                    error: errorColor,
                    onSecondary: onSecondaryColor,
                    onBackground: onBackgroundColor,
                  ),
            ),
            builder: (context, widget) {
              return ScrollConfiguration(
                behavior: GlobalScrollBehavior(),
                child: widget!,
              );
            },
            locale: currentLanguage,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: appLanguages.map((appLanguage) {
              return UiUtils.getLocaleFromLanguageCode(
                appLanguage.languageCode,
              );
            }).toList(),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            onGenerateRoute: Routes.onGenerateRouted,
          );
        },
      ),
    );
  }
}
