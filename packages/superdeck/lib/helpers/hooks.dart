import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void useMount(VoidCallback fn) {
  return usePostFrameEffect(() {
    fn();
  });
}

void useEffectOnce(void Function()? Function() effect) {
  useEffect(effect, []);
}

void usePostFrameEffect(void Function() effect,
    [List<Object?> keys = const []]) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      effect();
    });
  }, keys);
}

typedef ScrollVisibleControllerData = ({
  ItemScrollController itemScrollController,
  ItemPositionsListener itemPositionsListener,
  List<ItemPosition> visibleItems,
});

ScrollVisibleControllerData useScrollVisibleController({
  List<Object?>? keys,
}) {
  return use(
    _ScrollVisibleController(keys: keys),
  );
}

class _ScrollVisibleController extends Hook<ScrollVisibleControllerData> {
  const _ScrollVisibleController({
    super.keys,
  });

  @override
  HookState<ScrollVisibleControllerData, Hook<ScrollVisibleControllerData>>
      createState() => _ScrollVisibleControllerState();
}

class _ScrollVisibleControllerState
    extends HookState<ScrollVisibleControllerData, _ScrollVisibleController> {
  late final controller = ItemScrollController();
  late final itemPositionsListener = ItemPositionsListener.create();
  var visibleItems = <ItemPosition>[];

  void _listener() {
    visibleItems = itemPositionsListener.itemPositions.value.toList();
  }

  @override
  void initHook() {
    super.initHook();
    itemPositionsListener.itemPositions.addListener(_listener);
  }

  @override
  ScrollVisibleControllerData build(BuildContext context) => (
        itemScrollController: controller,
        itemPositionsListener: itemPositionsListener,
        visibleItems: visibleItems,
      );

  @override
  void dispose() {
    super.dispose();
    itemPositionsListener.itemPositions.removeListener(_listener);
  }

  @override
  String get debugLabel => 'useScrollVisibleController';
}

bool useFirstMount() {
  final first = useRef(true);

  if (first.value) {
    first.value = false;

    return true;
  }

  return first.value;
}

void useUpdateEffect(Dispose? Function() effect, [List<Object?>? keys]) {
  final isFirstMount = useFirstMount();

  useEffect(() {
    if (!isFirstMount) {
      return effect();
    }
  }, keys);
}

T? useDistinct<T>(T value, [Predicate<T>? compare]) {
  compare ??= (prev, next) => prev == next;

  final valueRef = useRef<T>(value);

  if (valueRef.value == null || !compare(valueRef.value, value)) {
    valueRef.value = value;
  }

  return valueRef.value;
}

typedef Predicate<T> = bool Function(T prev, T next);

GoRouter useGoRouter() {
  final context = useContext();
  return GoRouter.of(context);
}

String useRouteLocation() {
  final router = useGoRouter();
  final uri = useState(router.routeInformationProvider.value.uri);

  useEffect(() {
    router.routerDelegate.addListener(() {
      uri.value = router.routeInformationProvider.value.uri;
    });
  }, [router.routerDelegate]);

  return uri.value.toString();
}
