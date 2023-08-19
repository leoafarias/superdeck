
---
image: https://media.giphy.com/media/hVbErjjtKCIHb24j4y/giphy.gif
layout: cover
contentAlignment: center

---

# Flutter Design Systems Using Mix
<!-- show -->
Leo Farias (@leoafarias)

--- 

layout: contentLeft
contentAlignment: center
---

## Mixing


```dart
//@snippet
final style = Mix(
    height(50),  
    width(100),
    bgColor(Colors.white),
    roundedTL(20), 
    roundedBR(20),
    border(
        color: Colors.black,
        width: 4,
    ),
//@end-snippet
);

return Box(
    mix: style
);
```


---
layout: contentLeft
contentAlignment: center
scrollable: true
---

#### Variants

```dart
final style = Mix(
    height(100),
    width(100),
    animated(),
    rounded(20),
    bgColor(Colors.black),
    textColor(Colors.white),
    align(Alignment.center),
    (dark | landscape)(
        textColor(Colors.black),
    ),
    dark(  
        bgColor(Colors.white),
    ),
    landscape(
        bgColor(Colors.yellow),
    )
);

return Pressable(
    mix:style, 
    onPressed:(){},  
    child:TextMix('Button'),
);

```
---
layout: contentLeft
image: https://media.giphy.com/media/6G48V62YlbZj1W6fso/giphy.gif
contentAlignment: bottomCenter
---

## What is a Design System?

Um conjunto completo de padrões destinados a gerenciar o design em escala usando componentes e padrões reutilizáveis.

---
image: https://media.giphy.com/media/yoJC2pxpca0K6v67qo/giphy.gif
layout: contentRight
contentAlignment: center
---

## Benefits

Uma linguagem unificada dentro e entre equipes multifuncionais.

- Consistência
- Vocabulário compartilhado
- Produto mais intuitivo
- Aumenta a eficiência
- Fonte central da verdade

<!-- - One consistent product and service ecosystem
- Rapid design and prototyping process
- Easier handovers and improved collaboration
- Allows to focus on development tasks not design -->



---
contentAlignment: center
---
# Principles

- Capacidade de escalar o sistema
- Capacidade de colaborar e manter o sistema em tempo real
- Sistema flexível o suficiente para se adaptar às demandas do projeto.

---

contentAlignment: center
---

# Flutter

### Composition > Inheritance

---
---

## Flutter Design Primitives


- Padding
- Align
- ColoredBox
- DecoratedBox
- Transform
- e muitas outras...

---
---

# Material Design

---
scrollable: true
---

## Custom Widget 

```dart
class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  bool _isHover = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (event) {
        setState(() => _isHover = true);
      },
      onExit: (event) {
        setState(() => _isHover = false);
      },
      child: Material(
        elevation: _isHover ? 2 : 10,
        child: AnimatedContainer(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 100),
          height: 100,
          padding:
              _isHover ? const EdgeInsets.all(20) : const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: _isHover ? colorScheme.secondary : colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Custom Widget',
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: _isHover
                      ? colorScheme.onSecondary
                      : colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
```

---
image: https://media.giphy.com/media/l3vRnoppYtfEbemBO/giphy.gif
layout: cover
contentAlignment: bottomCenter
styles: gradientMix
---

# Mix

## API simples para compor atributos de design e layout para widgets.

Facilmente estendido, substituído e combinado

- Defina attributos fora do BuildContext
- Defina e compartilhe BuildContext Design Tokens
- Responda rapidamente às mudanças de requisitos
- Crie designs e layouts adaptáveis com facilidade

---
scrollable: true
---

## With Mix

```dart
class CustomMixWidget extends StatelessWidget {
  const CustomMixWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Mix(
      height(100),
      animated(),
      marginY(10),
      elevation(10),
      rounded(10),
      bgColor($primary),
      textStyle($button),
      textColor($onPrimary),
      hover(
        elevation(2),
        padding(20),
        bgColor($secondary),
        textColor($onSecondary),
      ),
    );
    return Box(
      mix: style,
      child: const TextMix('Custom Widget'),
    );
  }
}
```

--- 
layout: contentLeft
contentAlignment: center
---

## Mixing

```dart
final style = Mix(
    height(50),  
    width(100),
    bgColor(Colors.white),
);

return Box(
    mix: style
);
```


--- 
layout: contentLeft
contentAlignment: center
---

## Visual Composition



```dart
final style = Mix(
    height(50),  
    width(100),
    bgColor(Colors.white),
    roundedTL(20), 
    roundedBR(20),
    border(
        color: Colors.black,
        width: 4,
    ),
);

return Box(
    mix: style
);
```

---
layout: contentLeft
contentAlignment: center
---

## Inheritance

```dart

final base = Mix(
    height(100),
    width(100),
    bgColor(Colors.white),  
);

// final roundedElevation = base.mix(
//    elevation(4),
//    rounded(10),
// );

final roundedElevation = Mix(
   apply(base),
   elevation(4),
   rounded(10),
);

return Box(mix: roundedElevation);
 
```

---
layout: contentLeft
contentAlignment: center
---

## Nesting

```dart
final style = Mix(
    height(100),
    width(100),
    bgColor(Colors.white),
    elevation(4),
    rounded(10),
    align(Alignment.center),
    textColor(Colors.black)
);

return Box(
    mix:style, 
    child:TextMix('Box'),
);
```

---
---

# Variants

---

contentAlignment: center
image: https://media.giphy.com/media/3ov9jS8fcnj9LpzGFi/giphy.gif
layout: contentLeft
---

### Reactive Variants

Allows for reactive behavior based on BuildContext



##### Pressable

hover | focus | press | disabled

##### Breakpoints

small | medium | large

##### Orientation

portrait | landscape

##### Theme

dark | light


---
layout: contentLeft
contentAlignment: center
scrollable: true
---
### Reactive Variants

```dart
final style = Mix(
    height(100),
    width(100),
    rounded(20),
    elevation(4),
    bgColor(Colors.white),
    textColor(Colors.black),
    align(Alignment.center),
    hover(
        bgColor(Colors.red),
        textColor(Colors.white)
    ),
     press(
        bgColor(Colors.blue),
    ),
);

return Pressable(
    mix:style, 
    onPressed:(){},  
    child:TextMix('Button'),
);

```
---
---
## Variant Operators

```dart
final style = Mix(
    (hover & press)(
        bgColor(Colors.purple),
    )
);

```

---
---

# Custom Variants

---
layout: contentLeft
contentAlignment: center
scrollable: true
---
### Callable

```dart
final outlined = Variant('outlined');

final style = Mix(
  bgColor(Colors.black),
  px(10),
  py(5),
  rounded(10),
  textColor(Colors.white),
  outlined(
    bgColor(Colors.transparent),
    borderColor(Colors.black),
    textColor(Colors.black),
  ),
);

return Pressable(
  mix: style,
  variant: outlined,
  onPressed: () {},
  child: const TextMix('Outlined Button'),
);

```

---
---

### Reactive

```dart
final dark = Variant(
  'dark',
  shouldApply: (BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  },
);
```

---
---

# Design Tokens

---
---

## Compatível com
## Material Theme

```dart

final style = Mix(
    textStyle($displayMedium),
    textColor($primary),
)

```

---
---

## Spacing Tokens

```dart

final style = Mix(
    p.large,
    mx.medium,
)

```

---
---

## Custom Design Tokens

```dart
const $displayLarge = TextStyleToken('displayLarge');


final TokenMap materialThemeTokens = {
  $displayLarge: (BuildContext context) {
    return context.textTheme.displayLarge;
  },
}

MixTheme(
    data: MixThemeData(
        designTokens: MixDesignTokens(materialThemeTokens)
    )
)

```

---
---

## Mix Theme

```dart
MixTheme(
  data: MixThemeData(
    space: MixThemeSpace(
      large: 16.0, // 16px
    ),
    breakpoints: MixThemeBreakpoints(),
    designTokens: MixDesignTokens(...)
  ),
  child: ..;,
);
```

---
---

## Obrigado 
### @leoafarias
### www.fluttermix.com
### github.com/leoafarias/mix

