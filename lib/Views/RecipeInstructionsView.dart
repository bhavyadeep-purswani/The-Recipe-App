import 'package:flutter/material.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeInstructionView extends StatelessWidget {
  final RecipeSearchResult _recipeSearchResult;

  const RecipeInstructionView(this._recipeSearchResult, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showNutrients = _recipeSearchResult.getNutritionInfo().length != 0;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_showNutrients)
                  ...getMapTextWidgets("Nutrition Info:",
                      _recipeSearchResult.getNutritionInfo()),
                ...getMapTextWidgets(
                    "Instructions:", _recipeSearchResult.getInstructionList()),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "For more information visit:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    child: Text(
                      _recipeSearchResult.sourceUrl,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      if (await canLaunch(_recipeSearchResult.sourceUrl)) {
                        await launch(_recipeSearchResult.sourceUrl);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getMapTextWidgets(String name, Map<String, String> info) {
    List<Widget> list = [];
    list.add(Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ));
    info.forEach((key, value) => {
          list.add(Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Text(
              "$key: $value",
              style: TextStyle(fontSize: 16),
            ),
          ))
        });
    return list;
  }
}
