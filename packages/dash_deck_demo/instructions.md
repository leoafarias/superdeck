

## Definitions

**ImageFit**
Controls how an image is inscribed into a box.

Values:
- `cover`: As large as possible while still containing the entire source within the target box. Might not fill the target entirely.

- `contain`: As large as possible while still fully visible within the target box.

- `fill`: Fill the target box by distorting the source's aspect ratio.

- `fitHeight`: Make the height of the source match the height of the target and let the width adjust proportionally.

- `fitWidth`: Make the width of the source match the width of the target and let the height adjust proportionally.

- `none`: Ignore the source's aspect ratio. Change the width and height independently.

- `scaleDown`: Behavior is the same as either `contain` or `none`, whichever is less intrusive.

**ImagePosition**
Specifies where an image will be placed in a layout.

Values:
- `left`: Position the image on the left side of the slide.
- `right`: Position the image on the right side of the slide.

**ContentAlignment**
Defines the alignment of content within a slide.

Values:
- `topLeft`: Align content to the top left of the slide.
- `topCenter`: Align content to the top center of the slide.
- `topRight`: Align content to the top right of the slide.
- `centerLeft`: Align content to the center left of the slide.
- `center`: Align content to the center of the slide.
- `centerRight`: Align content to the center right of the slide.
- `bottomLeft`: Align content to the bottom left of the slide.
- `bottomCenter`: Align content to the bottom center of the slide.
- `bottomRight`: Align content to the bottom right of the slide.


## Layouts

**none**
  
The default layout. A basic slide with content positioned according to ContentAlignment property. Great for simple presentations.

Properties:
- `layout`: Always 'none' for this.
- `contentAlignment`: Content alignment in the slide.


**cover**
  
This layout uses a background image to cover the whole slide. The content is overlaid on this image. This is useful for welcome slides or when a big image can illustrate your storytelling.

Properties:
- `layout`: Always 'cover' for this.
- `background`: The URL of the background image.
- `contentAlignment`: Content alignment in the slide.

**image**
  
A layout tailored for slides that display an image prominently alongside textual content. The image is positioned to the left or right of the text.

Properties:
- `layout`: Always 'image' for this.
- `imageFit`: How the image box should be inscribed into box (optional).
- `image`: The URL of the image to be displayed.
- `imagePosition`: The position of the image in the slide. It can be 'left' or 'right'.

**full**
  
A layout intended for full-page content without special divisions such as columns or sections. A background image can optionally underlay the content.

Properties:
- `layout`: Always 'full' for this.
- `background`: The URL of the background image (optional).

**twoColumn**
  
This layout divides the slide into two equal columns, allowing distinct content on each side. It's useful for comparisons, showing two concurrent data sets, or enhancing the visual organization.

Properties:
- `layout`: Always 'twoColumn' for this.respectively. Undesignated content defaults to the left.

**twoColumnHeader**
  
A layout similar to 'twoColumn', but also includes a top header section. The lower part of the slide is bifurcated into columns, and the top section is reserved for common header content.

Properties:
- `layout`: Always 'twoColumnHeader' for this.appears in the header section.