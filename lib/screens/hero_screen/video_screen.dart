import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  VideoScreen({required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isControlVisible = true;
  double _currentSliderValue = 0;
  IconData _playButtonIcon = Icons.play_arrow;
  bool _systemUIVisible=true;

  // late DeviceOrientation _currentOrientation=DeviceOrientation.portraitUp;
  DeviceOrientation _getOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return DeviceOrientation.portraitUp;
    } else {
      return DeviceOrientation.landscapeRight;
    }
  }
  @override
  void initState() {
    super.initState();
    String url = widget.videoUrl;
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.addListener(() {
      setState(() {
        _currentSliderValue = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                  _changeControlVisibility();
                  },
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),

             Visibility(
                    visible: _isControlVisible,
                    child: SizedBox(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("This is title",style: TextStyle(fontSize: 18,color: Colors.white),),
                                  Spacer(),
                                  Icon(
                                    Icons.cast,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.playlist_add_check_circle,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 8, 16, 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      // _rotateScreen();
                                    },
                                    child: Icon(
                                      Icons.screen_rotation,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.volume_down,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.headphones,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.speed,
                                    size: 30,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                              child: Row(
                                children: [
                                  Text('02:14',style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  //implement seek bar view here
                                  Expanded(
                                    child: Slider(
                                      onChangeEnd: (value) {
                                        _controller.play();
                                      },
                                      value: _currentSliderValue,
                                      min: 0,
                                      max: _controller.value.duration.inSeconds.toDouble(),
                                      onChanged: (value) {
                                        setState(() {
                                          _currentSliderValue = value;
                                          Duration duration = Duration(seconds: value.toInt());
                                          _controller.seekTo(duration);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('07:14',style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 32),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 30,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_back_ios_new_sharp,
                                    size: 40,
                                  ),
                                  SizedBox(width: 32),
                                  GestureDetector(
                                      onTap: () {
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                            setState(() {
                                              _playButtonIcon=Icons.play_arrow;

                                            });
                                          } else {
                                            setState(() {
                                              _playButtonIcon=Icons.pause;
                                            });
                                            _controller.play();
                                          }
                                      },
                                      child: Icon(
                                        _playButtonIcon,
                                        size: 45,
                                      )),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 40,
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.fullscreen,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  void _changeControlVisibility() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isControlVisible = !_isControlVisible;
        _systemUIVisible = !_systemUIVisible;
      });
    });
    _toggleSystemUI();
  }
  void _toggleSystemUI() {
    if (_systemUIVisible && _isControlVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Hide both the status bar and the navigation bar
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values); // Enable system UI overlays
    }
  }
  // void _rotateScreen() {
  //   setState(() {
  //     if (_currentOrientation == DeviceOrientation.portraitUp) {
  //       _currentOrientation = DeviceOrientation.landscapeRight;
  //     } else {
  //       _currentOrientation = DeviceOrientation.portraitUp;
  //     }
  //   });
  //
  //   SystemChrome.setPreferredOrientations([_currentOrientation]);
  // }
}
