import 'dart:math';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_global_tools/utils/picture_utils.dart';

class FastCacheNetworkImageExamplePage extends StatefulWidget {
  const FastCacheNetworkImageExamplePage({super.key});

  @override
  State<FastCacheNetworkImageExamplePage> createState() =>
      _FastCacheNetworkImageExamplePageState();
}

class _FastCacheNetworkImageExamplePageState
    extends State<FastCacheNetworkImageExamplePage> {
  bool isImageCached = false;
  String? log;

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      'https://sample-videos.com/img/Sample-jpg-image-50kb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-100kb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-200kb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-500kb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-1mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-2mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-5mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-10mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-10mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-20mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-25mb.jpg',
      'https://sample-videos.com/img/Sample-jpg-image-30mb.jpg',
    ];

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                    itemCount: urls.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Get.width / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, i) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: buildCachedImageWithLoading(
                                urls[i],
                                loadingMode: ImageLoadingMode
                                    .values[Random().nextInt(2)],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () async {
                                await FastCachedImageConfig.deleteCachedImage(
                                    imageUrl: urls[i]);
                                setState(
                                    () => log = 'deleted image ${urls[i]}');
                                await Future.delayed(const Duration(seconds: 2),
                                    () => setState(() => log = null));
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 12),
              Text('Is image cached? = $isImageCached',
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              /*Text(log ?? ''),
              const SizedBox(height: 120),
              MaterialButton(
                onPressed: () async {
                  setState(() => isImageCached =
                      FastCachedImageConfig.isCached(imageUrl: url1));
                },
                child: const Text('check image is cached or not'),
              ),
              const SizedBox(height: 12),
              MaterialButton(
                onPressed: () async {
                  await FastCachedImageConfig.deleteCachedImage(imageUrl: url1);
                  setState(() => log = 'deleted image $url1');
                  await Future.delayed(const Duration(seconds: 2),
                      () => setState(() => log = null));
                },
                child: const Text('delete cached image'),
              ),*/
              const SizedBox(height: 12),
              MaterialButton(
                onPressed: () async {
                  await FastCachedImageConfig.clearAllCachedImages();
                  setState(() => log = 'All cached images deleted');
                  await Future.delayed(const Duration(seconds: 2),
                      () => setState(() => log = null));
                },
                child: const Text('delete all cached images'),
              ),
            ],
          ),
        ));
  }
}
