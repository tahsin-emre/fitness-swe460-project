import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/texts.dart';
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
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
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
              Text(
                '${Texts.equipments.tr()}: ${widget.exercise.equipmentList.map((e) => e.name).toString().replaceAll('(', '').replaceAll(')', '')}',
                style: style,
              ),
              Text(
                '${Texts.muscles.tr()}: ${widget.exercise.muscleList.map((e) => e.name).toString().replaceAll('(', '').replaceAll(')', '')}',
                style: style,
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }
}
