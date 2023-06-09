import 'package:flutter/material.dart';
import 'package:organizzer/resources/colors.dart';

class ExpandableFab extends StatefulWidget {
  final List<ExpandableFabItem> children;

  const ExpandableFab({super.key, required this.children});

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  bool _open = false;

  _insertOverlay() {
    _controller.forward();
    _overlayEntry = OverlayEntry(
      builder: (_) => _WidgetItens(
        dismiss: _removeOverlay,
        animation: _animation,
        children: widget.children,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _open = true;
    });
  }

  _removeOverlay() async {
    await _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _open = false;
    });
  }

  _toggle() {
    if (_overlayEntry == null) {
      _insertOverlay();
    } else {
      _removeOverlay();
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
    // _buildIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_overlayEntry != null) {
          _removeOverlay();
          return false;
        }
        return true;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () => _toggle(),
            backgroundColor: Colors.red,
            child: _icone(),
          ),
          // _buildIcons(),
          IgnorePointer(
            ignoring: _open,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _open ? 0 : 1,
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: AppColors.primaryColor,
                onPressed: () => _toggle(),
                child: _icone(),
              ),
            ),
          ),
        ],
      ),
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
        elevation: 4,
        color: AppColors.primaryColor,
        shape: CircleBorder(),
        child: InkWell(
          borderRadius: BorderRadius.circular(45),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _WidgetItens extends StatelessWidget {
  final Function() dismiss;
  final List<ExpandableFabItem> children;
  final Animation<double> animation;

  const _WidgetItens({
    required this.dismiss,
    required this.children,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => dismiss(),
            child: AnimatedBuilder(
              animation: animation,
              builder: (_, __) {
                return Container(color: Colors.black.withOpacity(animation.value * 0.5));
              },
            ),
          ),
          Positioned(
            bottom: 100,
            child: SizeTransition(
              sizeFactor: animation,
              child: Column(
                children: children.map((e) {
                  return ExpandableFabItem(
                    icon: e.icon,
                    onTap: () {
                      dismiss();
                      e.onTap();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
