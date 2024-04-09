import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helpers/layout_builder.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../atoms/slide_transition_widget.dart';

class SlideView extends StatelessWidget {
  const SlideView(
    this.props, {
    super.key,
  });

  final Slide props;

  @override
  @override
  Widget build(BuildContext context) {
    final props = this.props;

    final style = SuperDeck.styleOf(context).applyVariant(props.styleVariant);

    return SlideTransitionWidget(
      key: ValueKey(props.transition),
      transition: props.transition,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: _backgroundDecoration(props.background),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: StyledWidgetBuilder(
                  style: style.animate(),
                  key: ValueKey(props),
                  builder: (mix) {
                    final spec = SlideSpec.of(mix);
                    return AnimatedMixedBox(
                      spec: spec.innerContainer,
                      duration: const Duration(milliseconds: 300),
                      child: LayoutBuilder(builder: (_, constraints) {
                        return Builder(builder: (_) {
                          if (props is SimpleSlide) {
                            return SimpleSlideTemplate(config: props);
                          } else if (props is WidgetSlide) {
                            return WidgetSlideTemplate(config: props);
                          } else if (props is ImageSlide) {
                            return ImageSlideTemplate(config: props);
                          } else if (props is TwoColumnSlide) {
                            return TwoColumnSlideTemplate(config: props);
                          } else if (props is TwoColumnHeaderSlide) {
                            return TwoColumnHeaderSlideTemplate(config: props);
                          } else if (props is InvalidSlide) {
                            return InvalidSlideTemplate(config: props);
                          } else {
                            throw UnimplementedError(
                              'Slide config not implemented',
                            );
                          }
                        });
                      }),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}

class SlideConstraints extends InheritedWidget {
  const SlideConstraints({
    required this.constraints,
    required super.child,
    super.key,
  });

  final BoxConstraints constraints;

  static BoxConstraints of(BuildContext context) {
    final slideConstraints =
        context.dependOnInheritedWidgetOfExactType<SlideConstraints>();
    if (slideConstraints == null) {
      throw Exception('SlideConstraints not found in context');
    }
    return slideConstraints.constraints;
  }

  @override
  bool updateShouldNotify(SlideConstraints oldWidget) {
    return oldWidget.constraints != constraints;
  }
}

BoxDecoration? _backgroundDecoration(String? background) {
  ImageProvider imageProvider;

  if (background == null) {
    return null;
  }

  if (background.startsWith('http')) {
    imageProvider = CachedNetworkImageProvider(background);
  } else {
    imageProvider = AssetImage(background);
  }
  return BoxDecoration(
    image: DecorationImage(
      image: imageProvider,
      fit: BoxFit.cover,
    ),
  );
}
