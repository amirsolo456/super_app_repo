import 'package:erp_app/pages/lists/com/person/person_list_bloc.dart';
import 'package:erp_app/pages/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';
import 'components/mainlayout/main_layout.dart';

void main() {
  setupServices();

  final apiClient = getIt.get<ApiClient>();
  final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<LoginService>(
          create: (_) =>
              LoginService(client: apiClient, storage: StorageService()),
        ),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(
          create: (_) => PersonListBloc(apiMiddleware: apiMiddleware),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aryan Front',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      theme: ThemeData(
        fontFamily: 'IRanSans',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MainLayoutPage(),
    );
  }
}
