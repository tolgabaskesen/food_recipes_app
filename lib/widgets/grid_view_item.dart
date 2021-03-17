import 'package:FoodRecipes/screens/category_recipes_screen.dart';
import 'package:FoodRecipes/screens/cuisine_recipes_screen.dart';
import 'package:FoodRecipes/services/http_service.dart';
import 'package:FoodRecipes/widgets/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final String path;

  GridViewItem(this.id, this.title, this.image, this.path);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return (path == HttpService.CATEGORY_IMAGES_PATH)
              ? CategoryRecipesScreen(
                  id: id,
                  title: title,
                )
              : CuisineRecipesScreen(
                  id: id,
                  title: title,
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      // it should match the border radius of the container
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: '$path$image',
              placeholder: (context, url) => ShimmerWidget(
                width: 200,
                height: double.infinity,
                circular: false,
              ),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black12),
              alignment: AlignmentDirectional.bottomStart,
              padding: EdgeInsets.all(8),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
