import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 35.0);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return  Center(
          child: Container(
            height: 35.0,
                      child: Column(
             
                verticalDirection: VerticalDirection.up,
                children :<Widget>[ Opacity(
                opacity: _opacityTween.evaluate(animation),
                child: SizedBox(
                  height: _sizeTween.evaluate(animation),
                    width: 350.0,
                    child: Container(
                   
                    color: Colors.blue,
                    
                  ), ),
                  ),
                ]
        
      ),
          ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);


    controller.forward();
  }

  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}