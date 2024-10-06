import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:soulscribe/constants/colors.dart';

import 'clipper.dart';

class ConcentricPageView extends StatefulWidget {
  final Function(int index) itemBuilder;
  final Function(int page)? onChange;
  final Function? onFinish;
  final int? itemCount;
  final PageController? pageController;
  final bool pageSnapping;
  final bool reverse;
  final List<LinearGradient> colors;
  final ValueNotifier? notifier;
  final double scaleFactor;
  final double opacityFactor;
  final double radius;
  final double verticalPosition;
  final Axis direction;
  final ScrollPhysics? physics;
  final Duration duration;
  final Curve curve;
  final Key? pageViewKey;

  /// Useful for adding a next icon to the page view button
  final WidgetBuilder? nextButtonBuilder;

  const ConcentricPageView({
    super.key,
    required this.itemBuilder,
    required this.colors,
    this.pageViewKey,
    this.onChange,
    this.onFinish,
    this.itemCount,
    this.pageController,
    this.pageSnapping = true,
    this.reverse = false,
    this.notifier,
    this.scaleFactor = 0.3,
    this.opacityFactor = 0.0,
    this.radius = 40.0,
    this.verticalPosition = 0.75,
    this.direction = Axis.horizontal,
    this.physics = const ClampingScrollPhysics(),
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeInOutSine, // const Cubic(0.7, 0.5, 0.5, 0.1),
    this.nextButtonBuilder,
  }) : assert(colors.length >= 2);

  @override
  _ConcentricPageViewState createState() => _ConcentricPageViewState();
}

class _ConcentricPageViewState extends State<ConcentricPageView> {
  late PageController _pageController;
  double _progress = 0;
  int _prevPage = 0;
  LinearGradient? _prevColor;
  LinearGradient? _nextColor;

  @override
  void initState() {
    _prevColor = widget.colors[_prevPage];
    _nextColor = widget.colors[_prevPage + 1];
    _pageController = (widget.pageController ?? PageController(initialPage: 0))
      ..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _buildClipper(),
        _buildPageView(),
        Positioned(
          top: MediaQuery.of(context).size.height * widget.verticalPosition,
          child: _Button(
            pageController: _pageController,
            widget: widget,
          ),
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      key: widget.pageViewKey,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
        overscroll: false,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      clipBehavior: Clip.none,
      scrollDirection: widget.direction,
      controller: _pageController,
      reverse: widget.reverse,
      physics: widget.physics,
      itemCount: widget.itemCount,
      pageSnapping: widget.pageSnapping,
      onPageChanged: (int page) {
        if (widget.onChange != null) {
          widget.onChange!(page);
        }
      },
      itemBuilder: (context, index) {
        final child = widget.itemBuilder(index);
        if (!_pageController.position.hasContentDimensions) {
          return child;
        }
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            final progress = _pageController.page! - index;
            if (widget.opacityFactor != 0) {
              child = Opacity(
                opacity: (1 - (progress.abs() * widget.opacityFactor))
                    .clamp(0.0, 1.0),
                child: child,
              );
            }
            if (widget.scaleFactor != 0) {
              child = Transform.scale(
                scale:
                    (1 - (progress.abs() * widget.scaleFactor)).clamp(0.0, 1.0),
                child: child,
              );
            }
            return child!;
          },
          child: child,
        );
      },
    );
  }

  Widget _buildClipper() {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (ctx, _) {
        return Container(
          decoration: BoxDecoration(gradient: _prevColor!),
          child: ClipPath(
            clipper: ConcentricClipper(
              progress: _progress,
              reverse: widget.reverse,
              radius: widget.radius,
              verticalPosition: widget.verticalPosition,
            ),
            child: Container(
              decoration: BoxDecoration(gradient: _nextColor!),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }

  void _onScroll() {
    final direction = _pageController.position.userScrollDirection;
    double page = _pageController.page ?? 0;

    if (direction == ScrollDirection.forward) {
      _prevPage = page.toInt();
      _progress = page - _prevPage;
    } else {
      _prevPage = page.toInt();
      _progress = page - _prevPage;
    }

    final total = widget.colors.length;
    final prevIndex = _prevPage % total;
    int nextIndex = prevIndex + 1;

    if (prevIndex == total - 1) {
      nextIndex = 0;
    }

    _prevColor = widget.colors[prevIndex];
    _nextColor = widget.colors[nextIndex];

    widget.notifier?.value = page - _prevPage;
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.pageController,
    required this.widget,
  });

  final PageController pageController;
  final ConcentricPageView widget;

  @override
  Widget build(BuildContext context) {
    final size = widget.radius * 2;
    Widget? child = widget.nextButtonBuilder != null
        ? widget.nextButtonBuilder!(context)
        : null;

    child = GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        if (pageController.page == 3) {
          widget.onFinish!();
          return;
        }
        final isFinal = pageController.page == widget.colors.length - 1;
        if (isFinal && widget.onFinish != null) {
          widget.onFinish!();
          return;
        }
        pageController.nextPage(
          duration: widget.duration,
          curve: widget.curve,
        );
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SizedBox.fromSize(
          size: Size.square(size),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  kWhiteColor,
                  kWhiteColor,
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode
                .srcIn, // Ensures the child takes the color of the gradient
            child: child, // Your actual child widget goes here
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final currentPage = pageController.page?.floor() ?? 0;
        final progress = (pageController.page ?? 0) - currentPage;
        return AnimatedOpacity(
          opacity: progress > 0.01 ? 0.0 : 1.0,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 150),
          child: IconTheme(
            data: const IconThemeData(),
            child: ShaderMask(
              shaderCallback: (bounds) => widget
                  .colors[currentPage % widget.colors.length]
                  .createShader(bounds),
              child: child!,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
