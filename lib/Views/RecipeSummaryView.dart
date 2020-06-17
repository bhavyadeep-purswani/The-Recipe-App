import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';

class RecipeSummaryView extends StatefulWidget {
  final RecipeSearchResult _recipeSearchResult;
  final bool _isBookmarked;

  const RecipeSummaryView(this._recipeSearchResult, this._isBookmarked,
      {Key key})
      : super(key: key);

  @override
  _RecipeSummaryViewState createState() =>
      _RecipeSummaryViewState(_isBookmarked);
}

class _RecipeSummaryViewState extends State<RecipeSummaryView> {
  bool _isBookmarked;

  _RecipeSummaryViewState(this._isBookmarked);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget._recipeSearchResult.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: _isBookmarked
                  ? IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Hive.box<String>("recipes")
                            .delete(widget._recipeSearchResult.id);

                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Removed from Bookmark!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        setState(() {
                          _isBookmarked = false;
                        });
                      },
                    )
                  : IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(
                        Icons.star_border,
                        size: 30,
                      ),
                      onPressed: () {
                        Hive.box<String>("recipes")
                            .put(widget._recipeSearchResult.id,
                                jsonEncode(widget._recipeSearchResult.toJson()))
                            .then((value) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to Bookmark!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          setState(() {
                            _isBookmarked = true;
                          });
                        });
                      },
                    ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget._recipeSearchResult.title,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Ready in: ${widget._recipeSearchResult.readyInMinutes} minutes",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Ingredients:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ...getIngredients(
                          widget._recipeSearchResult.usedIngredients,
                          widget._recipeSearchResult.missedIngredients),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getIngredients(
      List<Ingredient> usedIngredients, List<Ingredient> missedIngredients) {
    List<Widget> list = [];
    list.addAll(usedIngredients.map<Widget>((ingredient) => Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            ingredient.original,
            style: TextStyle(
              color: Colors.lightGreen,
            ),
          ),
        )));
    list.addAll(missedIngredients.map<Widget>((ingredient) => Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            ingredient.original,
            style: TextStyle(
              color: Colors.blueAccent[400],
            ),
          ),
        )));
    return list;
  }
}
