import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void useOnMounted(void Function()? Function() effect) {
  useEffect(effect, []);
}

/// This is like effect but triggers only after the layout and renders happen.
/// In the case of a controller, it means that the controller now has clients.
void useLayoutEffect(void Function() effect, [List<Object?> keys = const []]) {
  final isMounted = useState(false);

  useEffect(() {
    if (isMounted.value) {
      effect();
    }
    return null;
  }, [...keys, isMounted.value]);

  useEffect(() {
    isMounted.value = true;
    return null;
  }, keys);
}

typedef VisibleItemsState = ({
  ItemScrollController itemScrollController,
  ItemPositionsListener itemPositionsListener,
  List<ItemPosition> visibleItems,
});

VisibleItemsState useScrollControllerWithVisibleItems() {
  final itemScrollController = useMemoized(() => ItemScrollController(), []);
  final itemPositionsListener =
      useMemoized(() => ItemPositionsListener.create(), []);
  final visibleItems = useState<List<ItemPosition>>([]);

  useEffect(() {
    listener() {
      visibleItems.value = itemPositionsListener.itemPositions.value.toList();
    }

    itemPositionsListener.itemPositions.addListener(listener);

    return () {
      itemPositionsListener.itemPositions.removeListener(listener);
    };
  }, []);

  return (
    itemScrollController: itemScrollController,
    itemPositionsListener: itemPositionsListener,
    visibleItems: visibleItems.value,
  );
}
