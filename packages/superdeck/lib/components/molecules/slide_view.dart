import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helpers/layout_builder.dart';
import '../../models/config_model.dart';
import '../../superdeck.dart';

class SlideView extends StatefulWidget {
  const SlideView(
    this.config, {
    super.key,
  });

  final SlideOptions config;

  @override
  State<SlideView> createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final config = widget.config;

    final style = SuperDeck.styleOf(context).applyVariant(config.styleVariant);
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: _backgroundDecoration(config.background),
          ),
          SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: StyledWidgetBuilder(
                style: style.animate(),
                builder: (mix) {
                  final spec = SlideSpec.of(mix);
                  return AnimatedMixedBox(
                    spec: spec.innerContainer,
                    duration: const Duration(milliseconds: 300),
                    child: LayoutBuilder(builder: (_, constraints) {
                      return Builder(builder: (_) {
                        if (config is SimpleSlideOptions) {
                          return SimpleSlide(config: config);
                        } else if (config is PreviewSlideOptions) {
                          return PreviewSlide(config: config);
                        } else if (config is ImageSlideOptions) {
                          return ImageSlide(config: config);
                        } else if (config is TwoColumnSlideOptions) {
                          return TwoColumnSlide(config: config);
                        } else if (config is TwoColumnHeaderSlideOptions) {
                          return TwoColumnHeaderSlide(config: config);
                        } else {
                          throw UnimplementedError(
                              'Slide config not implemented');
                        }
                      });
                    }),
                  );
                }),
          ),
        ],
      );
    });
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
