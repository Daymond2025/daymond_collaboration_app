import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioPayer extends StatefulWidget {
  const AudioPayer({super.key,
    required this.audio,
    required this.id_audio,
  });
  final audio;
  final id_audio;
  @override
  State<AudioPayer> createState() => _AudioPayerState();
}

class _AudioPayerState extends State<AudioPayer> {
  final service_annonce = ServiceAnnonce();
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/Terrain.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      player.onDurationChanged.listen((Duration d) { //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {

        });
      });


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () async {
                    if(!isplaying && !audioplayed){
                      service_annonce.ReadAudio(widget.id_audio);
                      final result = await int.parse('${player.play(UrlSource(widget.audio))}');
                      if(result == 1){ //play success
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      }else{
                        print("Error while playing audio.");
                      }
                    }else if(audioplayed && !isplaying){
                      final result = await int.parse('${player.resume()}');
                      if(result == 1){ //resume success
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      }else{
                        print("Error on resume audio.");
                      }
                    }else{
                      int result = await int.parse('${player.pause()}');
                      if(result == 1){ //pause success
                        setState(() {
                          isplaying = false;
                        });
                      }else{
                        print("Error on pause audio.");
                      }
                    }
                  },
                  child: Icon(isplaying?Icons.pause:Icons.play_arrow)
              ),
            ),
            Expanded(
              flex: 3,
              child:  Container(
                  child: Slider(
                    value: double.parse(currentpos.toString()),
                    min: 0,
                    max: double.parse(maxduration.toString()),
                    divisions: maxduration,
                    label: currentpostlabel,
                    onChanged: (double value) async {
                      int seekval = value.round();
                      final result = await int.parse('${player.seek(Duration(milliseconds: seekval))}');
                      if(result == 1){ //seek successful
                        currentpos = seekval;
                      }else{
                        print("Seek unsuccessful.");
                      }
                    },
                  )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(currentpostlabel, style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        )

    );
  }
}