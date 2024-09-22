import 'package:flutter/material.dart';
import 'package:nsv_practical/View/widget/appbar_custom.dart';
import 'package:nsv_practical/View/widget/image_card.dart';
import 'package:provider/provider.dart';
import '../repository/imageprovider.dart';

class ImageGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);

    return Scaffold(
        appBar: CustomAppBar(),
        body: imageProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await imageProvider.loadImages();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75, // Adjust for a more dynamic look
                    ),
                    itemCount: imageProvider.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      final image = imageProvider.images[index];
                      return ImageCard(image: image);
                    },
                  ),
                ),
              ));
  }
}
