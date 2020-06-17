import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thereceipeapp/RecipeBloc/bloc.dart';
import 'package:thereceipeapp/Views/MultiSelectDialog.dart';

import '../Constants.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  TextEditingController calories = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController sugar = TextEditingController();
  String diet;
  TextEditingController ingredients = TextEditingController();
  String error = "";
  String _cuisines = "";
  Set<String> _selectedCuisine = Set<String>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? "images/splashPicTransparent.png"
                    : "images/splashPic.png",
                width: 170,
                height: 170,
              ),
              Container(
                width: double.infinity,
              ),
              getTextInputField(
                  "Max Calories (cal):",
                  calories,
                  TextInputType.numberWithOptions(signed: false, decimal: true),
                  100),
              getTextInputField(
                  "Max Carbs (gms):",
                  carbs,
                  TextInputType.numberWithOptions(signed: false, decimal: true),
                  100),
              getTextInputField(
                  "Max Sugar (gms):",
                  sugar,
                  TextInputType.numberWithOptions(signed: false, decimal: true),
                  100),
              getTextInputField("Ingredients \n(comma separated):", ingredients,
                  TextInputType.text, 200),
              getCuisineField(),
              getDietField(),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Theme.of(context).primaryColor,
                  child: Text("Search"),
                  onPressed: () {
                    setState(() {
                      BlocProvider.of<RecipeBlocBloc>(context).add(
                          SearchRecipes(
                              diet,
                              calories.text != null &&
                                      calories.text.trim().length > 0
                                  ? double.parse(calories.text)
                                  : 0,
                              ingredients.text,
                              carbs.text != null && carbs.text.trim().length > 0
                                  ? double.parse(carbs.text)
                                  : 0,
                              _cuisines,
                              sugar.text != null && sugar.text.trim().length > 0
                                  ? double.parse(sugar.text)
                                  : 0));
                    });
                  },
                ),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextInputField(String title, TextEditingController controller,
      TextInputType inputType, double width) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                title,
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                height: 30,
                child: TextField(
                  keyboardType: inputType,
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getDietField() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Diet",
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: diet ?? Constants.DIET_LIST[0],
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (value) {
                  setState(() {
                    diet = value;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                items: Constants.DIET_LIST.map<DropdownMenuItem<String>>(
                  ((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }),
                ).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getCuisineField() {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                "Cuisine",
              ),
            ),
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () => _showMultiSelect(context),
                child: Container(
                  height: 30,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Text(
                    _cuisines,
                    softWrap: false,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<String>>[];

    items.addAll(Constants.CUISINE_LIST
        .map((value) => MultiSelectDialogItem<String>(value, value)));

    final selectedValues = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: _selectedCuisine,
        );
      },
    );
    setState(() {
      _selectedCuisine = selectedValues;
      _cuisines = selectedValues.join(",");
    });
  }
}
