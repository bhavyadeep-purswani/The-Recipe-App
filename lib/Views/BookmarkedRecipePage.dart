import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';
import 'package:thereceipeapp/Views/CustomCard.dart';

class BookmarkedRecipePage extends StatefulWidget {
  @override
  _BookmarkRecipeState createState() => _BookmarkRecipeState();
}

class _BookmarkRecipeState extends State<BookmarkedRecipePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<String>>(
      valueListenable: Hive.box<String>("recipes").listenable(),
      builder: (context, box, widget) {
        if (box.length == 0) {
          return Center(
            child: Text(
              "You don't seem to have any bookmarks.\nGo ahead, make one!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            RecipeSearchResult _recipeSearchResult =
                RecipeSearchResult.fromJson(
                    jsonDecode(box.getAt(box.length - index - 1)));
            return ListTile(
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MaterialApp(
                        theme: Theme.of(context).brightness == Brightness.dark
                            ? ThemeData.dark()
                            : ThemeData(
                                primaryColor: Colors.lime[500],
                                accentColor: Colors.green[500],
                                primaryColorDark: Colors.lime[700],
                                primaryColorLight: Colors.lime[100],
                              ),
                        home: Scaffold(
                            appBar: AppBar(
                              title: Text("The Recipe App"),
                            ),
                            body: CustomCard(_recipeSearchResult, true)))));
              },
              leading: Image.network(
                _recipeSearchResult.image,
                fit: BoxFit.contain,
              ),
              title: Text(_recipeSearchResult.title),
              subtitle: Text(_recipeSearchResult.nutrition != null &&
                      _recipeSearchResult.nutrition.length != 0
                  ? "${_recipeSearchResult.nutrition[0].title} (${_recipeSearchResult.nutrition[0].unit}): ${_recipeSearchResult.nutrition[0].amount}"
                  : ""),
              trailing: IconButton(
                onPressed: () {
                  Hive.box<String>("recipes").deleteAt(index);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
