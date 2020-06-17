import 'package:flutter/material.dart';
import 'package:thereceipeapp/Model/RecipeSearchResult.dart';

import 'RecipeInstructionsView.dart';
import 'RecipeSummaryView.dart';

class CustomCard extends StatefulWidget {
  final RecipeSearchResult _recipeSearchResult;
  final bool _isBookmarked;

  const CustomCard(this._recipeSearchResult, this._isBookmarked, {Key key})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState(_recipeSearchResult);
}

class _CustomCardState extends State<CustomCard> {
  final RecipeSearchResult _recipeSearchResult;

  _CustomCardState(this._recipeSearchResult);
  bool _showFirst;
  @override
  Widget build(BuildContext context) {
    final Widget recipeSummary =
        RecipeSummaryView(_recipeSearchResult, widget._isBookmarked);
    final Widget recipeInstructions =
        RecipeInstructionView(_recipeSearchResult);
    return InkWell(
      onTap: () {
        setState(() {
          _showFirst = !_showFirst;
          PageStorage.of(context)?.writeState(context, _showFirst,
              identifier: ValueKey(_recipeSearchResult.id));
        });
      },
      child: AnimatedCrossFade(
          crossFadeState:
              _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          firstChild: recipeSummary,
          secondChild: recipeInstructions),
    );
  }

  @override
  void initState() {
    super.initState();
    _showFirst = PageStorage.of(context)?.readState(context,
            identifier: ValueKey(_recipeSearchResult.id)) as bool ??
        true;
  }
}
