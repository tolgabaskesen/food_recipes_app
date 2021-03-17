import 'package:FoodRecipes/models/recipe.dart';
import 'package:FoodRecipes/screens/recipe_edit_screen.dart';
import 'package:FoodRecipes/screens/recipe_details_screen.dart';
import 'package:FoodRecipes/services/http_service.dart';
import 'package:FoodRecipes/utils/util.dart';
import 'package:FoodRecipes/widgets/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRecipesRecipeItem extends StatelessWidget {
  final List<Recipe> recipe;
  final int index;
  final String path;
  final Function getRecipes;

  MyRecipesRecipeItem({this.recipe, this.index, this.path, this.getRecipes});

  void selectRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(
          id: recipe[index].id,
          name: recipe[index].name,
          image: recipe[index].image,
          duration: recipe[index].duration,
          serving: recipe[index].serving,
          difficulty: recipe[index].difficulty,
          cuisine: recipe[index].cuisine,
          categories: recipe[index].categories,
          ingredients: recipe[index].ingredients,
          steps: recipe[index].steps,
          fName: recipe[index].fname,
          lName: recipe[index].lname,
          userImage: recipe[index].userimage,
          userId: recipe[index].userId,
          date: recipe[index].date,
        ),
      ),
    );
  }

  void editRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditRecipeScreen(
          id: recipe[index].id,
          name: recipe[index].name,
          image: recipe[index].image,
          duration: recipe[index].duration,
          serving: recipe[index].serving,
          difficulty: recipe[index].difficulty,
          cuisine: recipe[index].cuisine,
          categories: recipe[index].categories,
          ingredients: recipe[index].ingredients,
          steps: recipe[index].steps,
          fname: recipe[index].fname,
          lname: recipe[index].lname,
          userimage: recipe[index].userimage,
          userid: recipe[index].userId,
          date: recipe[index].date,
          getRecipes: getRecipes,
        ),
      ),
    );
  }

  Future<void> deleteRecipe(BuildContext context, String id) async {
    await HttpService.deleteUserRecipe(id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectRecipe(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 90,
        width: double.infinity,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: '$path${recipe[index].image}',
                    placeholder: (context, url) => ShimmerWidget(
                      width: 85,
                      height: 75,
                      circular: false,
                    ),
                    width: 85,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        Util.getDuration(recipe[index].duration),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].difficulty,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                      child: Text(
                        recipe[index].date.substring(0, 10),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await deleteRecipe(context, recipe[index].recipeid);
                  await getRecipes();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => editRecipe(context),
                child: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
