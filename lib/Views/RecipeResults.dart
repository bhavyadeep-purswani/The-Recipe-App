import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thereceipeapp/Model/RecipeSearchData.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';
import 'package:thereceipeapp/RecipeBloc/bloc.dart';
import 'package:thereceipeapp/Views/CustomCard.dart';
import 'package:thereceipeapp/Views/LoadingView.dart';

class RecipeResults extends StatefulWidget {
  @override
  _RecipeResultsState createState() => _RecipeResultsState();
}

class _RecipeResultsState extends State<RecipeResults> {
  RecipeSearchData _recipeSearchData;
  PageController _pageController = PageController();
  bool _isLoading = false;
  List<int> _bookmarkedRecipes = [];
  RecipeBlocState _recipeBlocState;

  final PageStorageBucket _bucket = new PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.offset >= _pageController.position.maxScrollExtent &&
          !_pageController.position.outOfRange &&
          !_isLoading &&
          _recipeSearchData.results.length < _recipeSearchData.totalResults) {
        setState(() {
          _isLoading = true;
          BlocProvider.of<RecipeBlocBloc>(context)
              .add(LoadNextPageEvent(offset: _recipeSearchData.results.length));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<RecipeBlocBloc>(context),
        builder: (BuildContext context, RecipeBlocState state) {
          if (state is RecipesLoaded) {
            _recipeSearchData = state.recipeSearchData;
          } else if (state is NextPageLoaded) {
            if (_recipeBlocState == null ||
                !(_recipeBlocState is NextPageLoaded &&
                    (_recipeBlocState as NextPageLoaded).offset ==
                        state.offset)) {
              _isLoading = false;
              _recipeSearchData.results.addAll(state.recipeSearchData.results);
            }
          }
          _recipeBlocState = state;
          return ValueListenableBuilder(
              valueListenable: Hive.box<String>("recipes").listenable(),
              builder: (context, box, widget) {
                _bookmarkedRecipes.clear();
                box.values.forEach((value) {
                  _bookmarkedRecipes
                      .add(RecipeSearchResult.fromJson(jsonDecode(value)).id);
                });
                return PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: getCardList(_recipeSearchData.results),
                );
              });
        });
  }

  List<Widget> getCardList(List<RecipeSearchResult> recipeList) {
    List<Widget> list = [];
    for (RecipeSearchResult recipeSearchResult in recipeList) {
      list.add(getRecipeCard(
          recipeSearchResult, recipeList.indexOf(recipeSearchResult)));
    }
    if (_isLoading) {
      list.add(LoadingView());
    }
    return list;
  }

  Widget getRecipeCard(RecipeSearchResult recipeSearchResult, int index) {
    return PageStorage(
      child: CustomCard(
        recipeSearchResult,
        _bookmarkedRecipes.contains(recipeSearchResult.id),
      ),
      bucket: _bucket,
      key: PageStorageKey<int>(recipeSearchResult.id),
    );
  }
}
