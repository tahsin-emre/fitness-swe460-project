import 'package:fitness/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseDetailView extends StatefulWidget {
  final ExerciseModel exercise;
  const ExerciseDetailView(this.exercise, {super.key});

  @override
  State<ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<ExerciseDetailView> {
  VideoPlayerController? controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.exercise.videoUrl!))
      ..initialize().then((_) {
        controller!.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(title: Text(widget.exercise.name ?? '')),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(controller!),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(widget.exercise.muscleList.toString()),
              Text(widget.exercise.equipmentList.toString()),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }
}
