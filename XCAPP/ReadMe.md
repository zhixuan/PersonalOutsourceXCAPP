# 携程企业商旅说明

## 参数信息说明

**系统参数信息**, 主要指与服务器之间的交互信息说明 不理解的地方可以添加QQ：`1099028580`

### 1.系统枚举类信息(位置：XCAPPProEnumUIKit.h);

* 1.用户性别信息

---

		GenderForNullStyle = 0 ,                                /**< == 0   未知性别信息*/
		GenderStyleForMaleStyle = 1,                            /**< == 1   男性性别 */
		GenderStyleForFemaleStyle = 2,                          /**< == 2   女性性别*/
		GenderStyleForDefautStyle = GenderStyleForFemaleStyle,  /**< == 1   男性性别 */

* 2.用户角色信息

---
		OptionRoleStyleForAdministration = 1,                           /**< == 1   管理员角色 */
		OptionRoleStyleForGuestStyle = 2,                               /**< == 2   二级权限角色*/
		OptionRoleStyleForDefautStyle = OptionRoleStyleForGuestStyle,   /**< == 2   二级权限角色 */

* 3.UserMatterStateStyle，出行种类

		MatterStateStyleForOfficialBusinessStyle = 0,                       /**< == 0   用户以公事出行 */
		MatterStateStyleForPrivateConcernStyle = 1,                         /**< == 1   用户以私事出行 */
		
		
		
		
		
* 4.XCAPPOrderPayStateStyle，系统中用户订单状态信息

---
		OrderStateForWaitForPay = 0,                                        /**< == 0   待支付 */
    	OrderStateForWaitForConfirm,                                        /**< == 1   待确认 */
    	OrderStateForAlreadyConfirm,                                        /**< == 2   已确认 */
    	OrderStateForAlreadyLeave,                                          /**< == 3   已离店 */
    	OrderStateForAlreadyCancel,                                         /**< == 4   已取消 */


---

> 

### 2.系统颜色信息描述(位置：XCAPPThemeColor.h);

* 1.导航头部背景色.

---
		///导航头部背景色
		>#define  KDefaultNavigationWhiteBackGroundColor  HUIRGBColor(5.0f, 54.0f, 126.0f, 1.0f)
* 2.导航头部标题颜色.

---
		///导航头部标题颜色
		.#define KDefineUIButtonTitleNormalColor     [UIColor whiteColor]	



### 3.系统适配参数信息(位置：XCAPPThemeScreenSize.h)

		///屏幕内容
		.#define KProjectScreenWidth                 [UIScreen mainScreen].bounds.size.width
		.#define KProjectScreenHeight                [UIScreen mainScreen].bounds.size.height

		///列表界面加载更多 CellHeight
		.#define kSizeLoadMoreCellHeight             (30.0f)

		///适配宽高
		.#define KXCAdapterSizeWidth                 (KProjectScreenWidth/375.0)
		.#define KXCAdapterSizeHeight                (KProjectScreenHeight/667.0)

		///适配宽高计算
		.#define KXCUIControlSizeHeight(f)         (f*KXCAdapterSizeHeight)
		.#define KXCUIControlSizeWidth(f)          (f*KXCAdapterSizeWidth)

An email <example@example.com> link.

Simple inline link <http://chenluois.com>, another inline link [Smaller](http://25.io/smaller/), one more inline link with title [Resize](http://resizesafari.com "a Safari extension").

A [reference style][id] link. Input id, then anywhere in the doc, define the link with corresponding id:

[id]: http://25.io/mou/ "Markdown editor on Mac OS X"

Titles ( or called tool tips ) in the links are optional.

*/
#### Images

An inline image ![Smaller icon](http://25.io/smaller/favicon.ico "Title here"), title is optional.

A ![Resize icon][2] reference style image.

[2]: http://resizesafari.com/favicon.ico "Title"

#### Inline code and Block code

Inline code are surround by `backtick` key. To create a block code:

	Indent each line by at least 1 tab, or 4 spaces.
    var Mou = exactlyTheAppIwant; 

####  Ordered Lists

Ordered lists are created using "1." + Space:

1. Ordered list item
2. Ordered list item
3. Ordered list item

#### Unordered Lists

Unordered list are created using "*" + Space:

* Unordered list item
* Unordered list item
* Unordered list item 

Or using "-" + Space:

- Unordered list item
- Unordered list item
- Unordered list item

#### Hard Linebreak

End a line with two or more spaces will create a hard linebreak, called `<br />` in HTML. ( Control + Return )  
Above line ended with 2 spaces.

#### Horizontal Rules

Three or more asterisks or dashes:

***

---

- - - -

#### Headers

Setext-style:

This is H1
==========

This is H2
----------

atx-style:

# This is H1
## This is H2
### This is H3
#### This is H4
##### This is H5
###### This is H6


### Extra Syntax

#### Footnotes

Footnotes work mostly like reference-style links. A footnote is made of two things: a marker in the text that will become a superscript number; a footnote definition that will be placed in a list of footnotes at the end of the document. A footnote looks like this:

That's some text with a footnote.[^1]

[^1]: And that's the footnote.


#### Strikethrough

Wrap with 2 tilde characters:

~~Strikethrough~~


#### Fenced Code Blocks

Start with a line containing 3 or more backticks, and ends with the first line with the same number of backticks:

```
Fenced code blocks are like Stardard Markdown’s regular code
blocks, except that they’re not indented and instead rely on
a start and end fence lines to delimit the code block.
```

#### Tables

A simple table looks like this:

First Header | Second Header | Third Header
------------ | ------------- | ------------
Content Cell | Content Cell  | Content Cell
Content Cell | Content Cell  | Content Cell

If you wish, you can add a leading and tailing pipe to each line of the table:

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

Specify alignment for each column by adding colons to separator lines:

First Header | Second Header | Third Header
:----------- | :-----------: | -----------:
Left         | Center        | Right
Left         | Center        | Right


### Shortcuts

#### View

* Toggle live preview: Shift + Cmd + I
* Toggle Words Counter: Shift + Cmd + W
* Toggle Transparent: Shift + Cmd + T
* Toggle Floating: Shift + Cmd + F
* Left/Right = 1/1: Cmd + 0
* Left/Right = 3/1: Cmd + +
* Left/Right = 1/3: Cmd + -
* Toggle Writing orientation: Cmd + L
* Toggle fullscreen: Control + Cmd + F

#### Actions

* Copy HTML: Option + Cmd + C
* Strong: Select text, Cmd + B
* Emphasize: Select text, Cmd + I
* Inline Code: Select text, Cmd + K
* Strikethrough: Select text, Cmd + U
* Link: Select text, Control + Shift + L
* Image: Select text, Control + Shift + I
* Select Word: Control + Option + W
* Select Line: Shift + Cmd + L
* Select All: Cmd + A
* Deselect All: Cmd + D
* Convert to Uppercase: Select text, Control + U
* Convert to Lowercase: Select text, Control + Shift + U
* Convert to Titlecase: Select text, Control + Option + U
* Convert to List: Select lines, Control + L
* Convert to Blockquote: Select lines, Control + Q
* Convert to H1: Cmd + 1
* Convert to H2: Cmd + 2
* Convert to H3: Cmd + 3
* Convert to H4: Cmd + 4
* Convert to H5: Cmd + 5
* Convert to H6: Cmd + 6
* Convert Spaces to Tabs: Control + [
* Convert Tabs to Spaces: Control + ]
* Insert Current Date: Control + Shift + 1
* Insert Current Time: Control + Shift + 2
* Insert entity <: Control + Shift + ,
* Insert entity >: Control + Shift + .
* Insert entity &: Control + Shift + 7
* Insert entity Space: Control + Shift + Space
* Insert Scriptogr.am Header: Control + Shift + G
* Shift Line Left: Select lines, Cmd + [
* Shift Line Right: Select lines, Cmd + ]
* New Line: Cmd + Return
* Comment: Cmd + /
* Hard Linebreak: Control + Return

#### Edit

* Auto complete current word: Esc
* Find: Cmd + F
* Close find bar: Esc

#### Post

* Post on Scriptogr.am: Control + Shift + S
* Post on Tumblr: Control + Shift + T

#### Export

* Export HTML: Option + Cmd + E
* Export PDF:  Option + Cmd + P


### And more?

Don't forget to check Preferences, lots of useful options are there.

Follow [@Mou](https://twitter.com/mou) on Twitter for the latest news.

For feedback, use the menu `Help` - `Send Feedback`