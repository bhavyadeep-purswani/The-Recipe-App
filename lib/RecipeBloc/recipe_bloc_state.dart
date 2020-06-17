import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:thereceipeapp/Model/RecipeSearchData.dart';

@immutable
abstract class RecipeBlocState extends Equatable {}

class InitialRecipeState extends RecipeBlocState {
  @override
  List<Object> get props => [];
}

class HomeFormRecipeState extends RecipeBlocState {
  @override
  List<Object> get props => [];
}

class LoadingRecipeState extends RecipeBlocState {
  @override
  List<Object> get props => [];
}

class ErrorRecipeState extends RecipeBlocState {
  @override
  List<Object> get props => [];
}

class RecipesLoaded extends RecipeBlocState {
  final RecipeSearchData recipeSearchData;
  final String diet;
  final double maxCalories;
  final String ingredients;
  RecipesLoaded(
      this.recipeSearchData, this.ingredients, this.maxCalories, this.diet);

  @override
  List<Object> get props {
    return [recipeSearchData, ingredients, maxCalories, diet];
  }
}

class NextPageLoaded extends RecipeBlocState {
  final RecipeSearchData recipeSearchData;
  final int offset;
  NextPageLoaded(this.recipeSearchData, this.offset);

  @override
  List<Object> get props {
    return [recipeSearchData, offset];
  }
}

class ThemeChangeState extends RecipeBlocState {
  final bool isDark;

  ThemeChangeState(this.isDark);

  @override
  List<Object> get props => [isDark];
}

class ErrorState extends RecipeBlocState {
  final String text;

  ErrorState(this.text);

  @override
  List<Object> get props => [text];
}

class ShowBookmarksState extends RecipeBlocState {
  @override
  List<Object> get props => [];
}
