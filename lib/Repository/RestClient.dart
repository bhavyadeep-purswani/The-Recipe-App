import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:thereceipeapp/Constants.dart';
import 'package:thereceipeapp/Model/RecipeSearchData.dart';

part 'RestClient.g.dart';

@RestApi(baseUrl: "https://api.spoonacular.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/recipes/complexSearch")
  Future<RecipeSearchData> getSearchResults(
      {@Query("diet") String diet,
      @Query("includeIngredients") String includeIngredients,
      @Query("instructionsRequired") bool instructionsRequired = true,
      @Query("fillIngredients") bool fillIngredients = true,
      @Query("maxCalories") double maxCalories,
      @Query("number") int number = 20,
      @Query("apiKey") String apiKey = Constants.API_KEY,
      @Query("addRecipeInformation") bool addRecipeInformation = true,
      @Query("maxCarbs") double maxCarbs,
      @Query("cuisine") String cuisine,
      @Query("maxSugar") double maxSugar});

  @GET("/recipes/complexSearch")
  Future<RecipeSearchData> getSearchResultsWithOffset(
      {@Query("diet") String diet,
      @Query("includeIngredients") String includeIngredients,
      @Query("instructionsRequired") bool instructionsRequired = true,
      @Query("fillIngredients") bool fillIngredients = true,
      @Query("maxCalories") double maxCalories,
      @Query("number") int number,
      @Query("apiKey") String apiKey = Constants.API_KEY,
      @Query("addRecipeInformation") bool addRecipeInformation = true,
      @Query("offset") int offset,
      @Query("maxCarbs") double maxCarbs,
      @Query("cuisine") String cuisine,
      @Query("maxSugar") double maxSugar});
}
