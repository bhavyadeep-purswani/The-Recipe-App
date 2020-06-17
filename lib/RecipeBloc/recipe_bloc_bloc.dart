import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:thereceipeapp/Constants.dart';
import 'package:thereceipeapp/Model/RecipeSearchData.dart';
import 'package:thereceipeapp/Repository/RestClient.dart';

import './bloc.dart';

class RecipeBlocBloc extends Bloc<RecipeBlocEvent, RecipeBlocState> {
  Dio dio;
  RestClient client;
  String diet;
  double maxCalories;
  String ingredients;
  double maxCarbs;
  String cuisines;
  double sugar;

  RecipeBlocBloc() {
    dio = Dio();
    client = RestClient(dio);
  }

  @override
  RecipeBlocState get initialState => InitialRecipeState();

  @override
  Stream<RecipeBlocState> mapEventToState(
    RecipeBlocEvent event,
  ) async* {
    if (event is SearchRecipes) {
      yield LoadingRecipeState();
      RecipeSearchData recipeSearchData;
      maxCalories = event.maxCalories;
      diet = event.diet;
      ingredients = event.ingredients;
      maxCarbs = event.maxCarbs;
      cuisines = event.cuisines;
      sugar = event.sugar;
      String error;
      try {
        if (event.maxCalories == 0) {
          recipeSearchData = await client.getSearchResults(
              diet: event.diet == "None" ? null : event.diet,
              includeIngredients: event.ingredients,
              maxCarbs: event.maxCarbs != 0 ? event.maxCarbs : null,
              cuisine: event.cuisines == "" ? null : event.cuisines,
              maxSugar: event.sugar != 0 ? event.sugar : null);
        } else {
          recipeSearchData = await client.getSearchResults(
              diet: event.diet == "None" ? null : event.diet,
              includeIngredients: event.ingredients,
              maxCalories: event.maxCalories,
              maxCarbs: event.maxCarbs != 0 ? event.maxCarbs : null,
              cuisine: event.cuisines == "" ? null : event.cuisines,
              maxSugar: event.sugar != 0 ? event.sugar : null);
        }
      } on DioError catch (e) {
        if (e.response.statusCode == 402) {
          try {
            if (event.maxCalories == 0) {
              recipeSearchData = await client.getSearchResults(
                  diet: event.diet == "None" ? null : event.diet,
                  includeIngredients: event.ingredients,
                  apiKey: Constants.BACKUP_API_KEY,
                  maxCarbs: event.maxCarbs != 0 ? event.maxCarbs : null,
                  cuisine: event.cuisines == "" ? null : event.cuisines,
                  maxSugar: event.sugar != 0 ? event.sugar : null);
            } else {
              recipeSearchData = await client.getSearchResults(
                  diet: event.diet == "None" ? null : event.diet,
                  includeIngredients: event.ingredients,
                  maxCalories: event.maxCalories,
                  apiKey: Constants.BACKUP_API_KEY,
                  maxCarbs: event.maxCarbs != 0 ? event.maxCarbs : null,
                  cuisine: event.cuisines == "" ? null : event.cuisines,
                  maxSugar: event.sugar != 0 ? event.sugar : null);
            }
          } on DioError {
            error =
                "Sorry! We are unable to process right now, please try tomorrow.";
          }
        } else {
          error = "Sorry! We are unable to process, try again.";
        }
      }
      if (error != null) {
        yield ErrorState(error);
      } else if (recipeSearchData.results.length == 0) {
        yield ErrorState("Sorry! We couldn't find any results.");
      } else {
        yield RecipesLoaded(
            recipeSearchData, event.ingredients, event.maxCalories, event.diet);
      }
    } else if (event is BackEvent) {
      yield InitialRecipeState();
    } else if (event is LoadNextPageEvent) {
      RecipeSearchData recipeSearchData;
      String error;
      try {
        if (maxCalories == 0) {
          recipeSearchData = await client.getSearchResultsWithOffset(
              diet: diet == "None" ? null : diet,
              includeIngredients: ingredients,
              offset: event.offset,
              maxCarbs: maxCarbs != 0 ? maxCarbs : null,
              cuisine: cuisines == "" ? null : cuisines,
              maxSugar: sugar != 0 ? sugar : null);
        } else {
          recipeSearchData = await client.getSearchResultsWithOffset(
              diet: diet == "None" ? null : diet,
              includeIngredients: ingredients,
              maxCalories: maxCalories,
              offset: event.offset,
              maxCarbs: maxCarbs != 0 ? maxCarbs : null,
              cuisine: cuisines == "" ? null : cuisines,
              maxSugar: sugar != 0 ? sugar : null);
        }
      } on DioError catch (e) {
        if (e.response.statusCode == 402) {
          try {
            if (maxCalories == 0) {
              recipeSearchData = await client.getSearchResultsWithOffset(
                  diet: diet == "None" ? null : diet,
                  includeIngredients: ingredients,
                  apiKey: Constants.BACKUP_API_KEY,
                  offset: event.offset,
                  maxCarbs: maxCarbs != 0 ? maxCarbs : null,
                  cuisine: cuisines == "" ? null : cuisines,
                  maxSugar: sugar != 0 ? sugar : null);
            } else {
              recipeSearchData = await client.getSearchResultsWithOffset(
                  diet: diet == "None" ? null : diet,
                  includeIngredients: ingredients,
                  maxCalories: maxCalories,
                  apiKey: Constants.BACKUP_API_KEY,
                  offset: event.offset,
                  maxCarbs: maxCarbs != 0 ? maxCarbs : null,
                  cuisine: cuisines == "" ? null : cuisines,
                  maxSugar: sugar != 0 ? sugar : null);
            }
          } on DioError {
            error =
                "Sorry! We are unable to process right now, please try tomorrow.";
          }
        } else {
          error = "Sorry! We are unable to process, try again.";
        }
      }
      if (error != null) {
        yield ErrorState(error);
      } else {
        yield NextPageLoaded(recipeSearchData, event.offset);
      }
    } else if (event is ChangeThemeEvent) {
      yield ThemeChangeState(event.isDark);
    } else if (event is ThemeLoadedEvent) {
      yield ThemeChangeState(event.isDark);
    } else if (event is ErrorEvent) {
      yield ErrorState(event.text);
    } else if (event is ShowBookmarksEvent) {
      yield ShowBookmarksState();
    }
  }

  @override
  Future<void> close() {
    dio.close();
    return super.close();
  }
}
