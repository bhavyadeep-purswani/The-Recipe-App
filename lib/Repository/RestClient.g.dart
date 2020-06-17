// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RestClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.spoonacular.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getSearchResults(
      {diet,
      includeIngredients,
      instructionsRequired = true,
      fillIngredients = true,
      maxCalories,
      number = 20,
      apiKey = Constants.API_KEY,
      addRecipeInformation = true,
      maxCarbs,
      cuisine,
      maxSugar}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'diet': diet,
      r'includeIngredients': includeIngredients,
      r'instructionsRequired': instructionsRequired,
      r'fillIngredients': fillIngredients,
      r'maxCalories': maxCalories,
      r'number': number,
      r'apiKey': apiKey,
      r'addRecipeInformation': addRecipeInformation,
      r'maxCarbs': maxCarbs,
      r'cuisine': cuisine,
      r'maxSugar': maxSugar
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/recipes/complexSearch',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RecipeSearchData.fromJson(_result.data);
    return value;
  }

  @override
  getSearchResultsWithOffset(
      {diet,
      includeIngredients,
      instructionsRequired = true,
      fillIngredients = true,
      maxCalories,
      number,
      apiKey = Constants.API_KEY,
      addRecipeInformation = true,
      offset,
      maxCarbs,
      cuisine,
      maxSugar}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'diet': diet,
      r'includeIngredients': includeIngredients,
      r'instructionsRequired': instructionsRequired,
      r'fillIngredients': fillIngredients,
      r'maxCalories': maxCalories,
      r'number': number,
      r'apiKey': apiKey,
      r'addRecipeInformation': addRecipeInformation,
      r'offset': offset,
      r'maxCarbs': maxCarbs,
      r'cuisine': cuisine,
      r'maxSugar': maxSugar
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/recipes/complexSearch',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RecipeSearchData.fromJson(_result.data);
    return value;
  }
}
