import 'package:flutter/material.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';

class ExpandableFab extends StatefulWidget {
  final List<ExpandableFabItem> children;

  const ExpandableFab({super.key, required this.children});

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _open = false;

  _toggle() {
    setState(() {
      _open = !_open;
    });
    if (_open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _icone() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transformAlignment: Alignment.center,
      transform: Matrix4.rotationZ(
        _open ? 0.8 : 0,
      ),
      child: Icon(Icons.add),
    );
  }

  Widget _aberto() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _open ? 0 : 1,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () => _toggle(),
          child: _icone(),
        ),
      ),
    );
  }

  Widget _fechado() {
    return FloatingActionButton(
      onPressed: () => _toggle(),
      backgroundColor: Colors.red,
      child: _icone(),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    super.initState();
  }

  Widget _buildIcons() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Positioned(
          bottom: 70,
          child: _PainelDeIcones(
            animation: _animation,
            children: widget.children,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        _fechado(),
        _buildIcons(),
        _aberto(),
      ],
    );
  }
}

class ExpandableFabItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ExpandableFabItem({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        color: AppColors.primaryColor,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _PainelDeIcones extends StatelessWidget {
  final Animation<double> animation;
  final List<Widget> children;

  const _PainelDeIcones({
    required this.children,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: animation.value,
      child: Container(
        padding: const EdgeInsets.all(kMainPadding),
        child: Material(
          elevation: 10,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(kMainBorderRadius),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
