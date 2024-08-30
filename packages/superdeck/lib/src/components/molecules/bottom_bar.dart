import 'package:flutter/material.dart';

import '../../modules/common/helpers/routes.dart';

class SDBottomBar extends StatelessWidget {
  const SDBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(171, 21, 21, 21),
            border: Border(
              top: BorderSide(
                color: Colors.white10,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.previousSlide(),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => context.nextSlide(),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.closePresenterMenu(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
