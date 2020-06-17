import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecipeBlocEvent extends Equatable {}

class SearchRecipes extends RecipeBlocEvent {
  final String diet;
  final double maxCalories;
  final double maxCarbs;
  final String ingredients;
  final String cuisines;
  final double sugar;

  SearchRecipes(this.diet, this.maxCalories, this.ingredients, this.maxCarbs,
      this.cuisines, this.sugar);

  @override
  List<Object> get props =>
      [diet, maxCalories, ingredients, maxCarbs, cuisines, sugar];
}

class BackEvent extends RecipeBlocEvent {
  @override
  List<Object> get props => [];
}

class LoadNextPageEvent extends RecipeBlocEvent {
  final int offset;
  LoadNextPageEvent({this.offset});

  @override
  List<Object> get props {
    return [offset];
  }
}

class ChangeThemeEvent extends RecipeBlocEvent {
  final bool isDark;
  ChangeThemeEvent(this.isDark);
  @override
  List<Object> get props {
    return [isDark];
  }
}

class ThemeLoadedEvent extends RecipeBlocEvent {
  final bool isDark;
  ThemeLoadedEvent(this.isDark);
  @override
  List<Object> get props {
    return [isDark];
  }
}

class ErrorEvent extends RecipeBlocEvent {
  final String text;
  ErrorEvent({this.text});

  @override
  List<Object> get props {
    return [text];
  }
}

class ShowBookmarksEvent extends RecipeBlocEvent {
  @override
  List<Object> get props => [];
}
