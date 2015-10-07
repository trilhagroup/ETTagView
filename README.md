ETTagView
========
A wrapper flexible for multiple tags. **ETTagView** creates buttons inside a view with different colors, texts and interactions. Just provide an array of dictionaries and this view will be able to display everything automatically.

Installation
--------
Clone this repo and copy the folder **ETTagView** into your Xcode project.

How-to
--------

![image](demo.png)

### Initialization

Programmatically, you must create using a traditional view.

```
- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored;
- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored;
- (CGRect)layoutTags:(NSArray *)tags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow;
- (CGRect)layoutTags:(NSArray *)tags matchingTags:(NSArray *)matchingTags colored:(BOOL)colored forMaximumSize:(NSInteger)maxSize canOverflow:(BOOL)overflow;
```

`tags` is an array of dictionaries, structured as: 

```
tagID: string used to compare objects with matchingTags
color: string hexadecimal to generate a color
name: string indicating the name of this tag
```

### Delegate

You have several delegate callbacks available to you. Just hook your delegate outlet and you are ready to go!

```
@optional
- (void)tagView:(ETTagView *)tagView touchedButtonAtIndex:(NSInteger)buttonIndex matching:(BOOL)matching;
```

Support
--------
Just open an issue on Github and we'll get to it as soon as possible.

About
--------
**ETTagView** is brought to you by Trilha.
