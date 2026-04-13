// Group Member
// Jagmohan Dass - 2380232
// Abdul Wahid - 2380222
// Saad Ahsan - 2380278
// M. Khizer - 2380279


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const AnimationScreen(),
    );
  }
}

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit vs Explicit Animations"),
        centerTitle: true,
      ),
      body: Row(
        children: const [
          Expanded(child: ExplicitAnimationWidget()),
          VerticalDivider(width: 1),
          Expanded(child: ImplicitAnimationWidget()),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////
/// EXPLICIT ANIMATION (Fade In Logo)
//////////////////////////////////////////////////////

class ExplicitAnimationWidget extends StatefulWidget {
  const ExplicitAnimationWidget({super.key});

  @override
  State<ExplicitAnimationWidget> createState() =>
      _ExplicitAnimationWidgetState();
}

class _ExplicitAnimationWidgetState extends State<ExplicitAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Explicit Animation",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          FadeTransition(
            opacity: animation,
            child: const FlutterLogo(size: 120),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: startAnimation,
            child: const Text("Fade In Logo"),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////
/// IMPLICIT ANIMATION (AnimatedContainer)
//////////////////////////////////////////////////////

class ImplicitAnimationWidget extends StatefulWidget {
  const ImplicitAnimationWidget({super.key});

  @override
  State<ImplicitAnimationWidget> createState() =>
      _ImplicitAnimationWidgetState();
}

class _ImplicitAnimationWidgetState extends State<ImplicitAnimationWidget> {
  double width = 100;
  double height = 100;
  Color color = Colors.blue;
  BorderRadius borderRadius = BorderRadius.circular(10);

  void animateBox() {
    setState(() {
      width = width == 100 ? 180 : 100;
      height = height == 100 ? 180 : 100;
      color = color == Colors.blue ? Colors.orange : Colors.blue;
      borderRadius = borderRadius == BorderRadius.circular(10)
          ? BorderRadius.circular(50)
          : BorderRadius.circular(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Implicit Animation",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: animateBox,
            child: const Text("Animate Box"),
          )
        ],
      ),
    );
  }
}