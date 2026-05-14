import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inkwell/features/home/presentation/controllers/planet_video_controller.dart';

class PlanetVideoPlayer extends StatelessWidget {
  final String videoUrl;
  const PlanetVideoPlayer({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlanetVideoController>(
      init: PlanetVideoController(videoUrl),
      tag: videoUrl,
      builder: (controller) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(28.r),
          child: _buildPlayer(controller),
        );
      },
    );
  }

  Widget _buildPlayer(PlanetVideoController controller) {
    if (controller.chewieController != null) {
      return Chewie(controller: controller.chewieController!);
    }
    return const Center(child: CupertinoActivityIndicator());
  }
}
