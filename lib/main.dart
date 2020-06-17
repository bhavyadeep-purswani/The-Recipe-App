import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thereceipeapp/Constants.dart';
import 'package:thereceipeapp/RecipeBloc/bloc.dart';
import 'package:thereceipeapp/Repository/SharedPreferenceRepository.dart';
import 'package:thereceipeapp/Views/BookmarkedRecipePage.dart';
import 'package:thereceipeapp/Views/ErrorView.dart';
import 'package:thereceipeapp/Views/HomeForm.dart';
import 'package:thereceipeapp/Views/LoadingView.dart';
import 'package:thereceipeapp/Views/RecipeResults.dart';
import 'package:thereceipeapp/Views/SplashScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Future.delayed(Duration(seconds: 3), () async {
        final dir = await getApplicationDocumentsDirectory();
        Hive.init(dir.path);
        await Hive.openBox<String>("recipes");
        return SharedPreference.getBoolFromSP(Constants.THEME_KEY);
      }),
      builder: (context, snap) {
        switch (snap.connectionState) {
          case ConnectionState.done:
            _isDark = snap.data;
            return BlocProvider(
              create: (BuildContext context) => RecipeBlocBloc(),
              child: BlocBuilder<RecipeBlocBloc, RecipeBlocState>(
                  builder: (BuildContext context, RecipeBlocState state) {
                if (state is ThemeChangeState) {
                  _isDark = state.isDark;
                }
                return MaterialApp(
                  title: 'The Recipe App',
                  theme: _isDark
                      ? ThemeData.dark()
                      : ThemeData(
                          primaryColor: Colors.lime[500],
                          accentColor: Colors.green[500],
                          primaryColorDark: Colors.lime[700],
                          primaryColorLight: Colors.lime[100],
                        ),
                  home: RecipeHomePage(),
                );
              }),
            );
          default:
            return SplashScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    Hive.box("recipes").compact();
    Hive.close();
    super.dispose();
  }
}

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  RecipeBlocState currentState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("The Recipe App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.book,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              BlocProvider.of<RecipeBlocBloc>(context)
                  .add(ShowBookmarksEvent());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                SharedPreference.addBoolToSP(
                    Constants.THEME_KEY, !_MyAppState._isDark);
                if (!(currentState is LoadingRecipeState)) {
                  BlocProvider.of<RecipeBlocBloc>(context)
                      .add(ChangeThemeEvent(!_MyAppState._isDark));
                } else {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        "Changing theme is not available while loading.",
                      ),
                      duration: Duration(milliseconds: 900),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color:
                      _MyAppState._isDark ? Colors.white : Colors.transparent,
                ),
                padding: const EdgeInsets.all(10),
                child: Text("Dark Mode",
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: BlocBuilder(
          bloc: BlocProvider.of<RecipeBlocBloc>(context),
          builder: (BuildContext context, RecipeBlocState state) {
            if (state is ThemeChangeState) {
              state = currentState;
            }
            currentState = state;
            if (state is InitialRecipeState) {
              return HomeForm();
            } else if (state is RecipesLoaded || state is NextPageLoaded) {
              return RecipeResults();
            } else if (state is ErrorState) {
              return ErrorView(text: state.text);
            } else if (state is ShowBookmarksState) {
              return BookmarkedRecipePage();
            } else {
              return LoadingView();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (currentState is InitialRecipeState ||
        currentState is ThemeChangeState) {
      return Future.value(true);
    } else if (currentState is RecipesLoaded ||
        currentState is NextPageLoaded ||
        currentState is ErrorState ||
        currentState is ShowBookmarksState) {
      BlocProvider.of<RecipeBlocBloc>(context).add(BackEvent());
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
