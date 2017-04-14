# TestKeyboard
iOS 简单键盘扩展 Demo。效果图如下：

![p1](https://github.com/Ranch2014/TestKeyboard/blob/master/pics/p1.gif)



PS: 因需要制作，目前功能极其简陋，有待以后扩展。这里用到了 APP Extension，之前没用过，因此做下小结。



- 创建 APP Extension

首先新建一个 Project，之后在 File -> New -> Target 选择 "Custom Keyboard Extension"，如图所示：

![p2](https://github.com/Ranch2014/TestKeyboard/blob/master/pics/p2.png)

该扩展依托于之前的 Project (类似寄生关系)。

PS: 新建成功后会多出一个包含 ViewController 和 "Info.plist" 的文件夹。



- 遇到的各种问题

  Q1: CustomKeyboard 文件夹里的 ViewController 无法使用 Assets.xcassets 中的图片？

  A1: 在 CustomKeyboard 文件夹中新建一个 .xcassets 资源（File -> New -> File… -> Catalog）。



​	Q2: 如何同时显示文本和 emoji 表情？

​	A2: 此处用到了 `NSAttributedString` 和 `NSTextAttachment` , 并显示在 `UITextView` 中。示例代码如下：

```swift
var textView: UITextView? = nil
var attrString: NSMutableAttributedString? = NSMutableAttributedString()

//添加附件
let textAttach = NSTextAttachment()
textAttach.image = UIImage(named: "love")
textAttach.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
//添加到键盘编辑框
let string = NSAttributedString.init(attachment: textAttach)
attrString?.append(string)
self.textView?.attributedText = attrString
```



​	Q3: 真机调试无法获取剪切板内容？

​	模拟器上获取剪切板内容只需下面一行代码：

```swift
let paste = UIPasteboard.general.string
```

​	这样在模拟器上没问题，但真机调试的时候却提示 `"Error: Error Domain=PBErrorDomain Code=7 "Cannot connect to pasteboard server" ` , 原因是 Apple 在键盘扩展中限制了对剪切板的访问。

​	A3: 需要进行以下设置：

 `Info.plist -> NSExtension -> NSExtensionAttributes -> RequestsOpenAccess -> YES` ，如图所示：

![p3](https://github.com/Ranch2014/TestKeyboard/blob/master/pics/p3.png)

​	此外，还需要在 iPhone 的键盘中设置"允许完全访问"，如图所示：

![p4](https://github.com/Ranch2014/TestKeyboard/blob/master/pics/p4.png)

​	这样就可以访问剪切板的内容了！



- TODO

  - 复制文本较多时暂时无法进行匹配

  当前复制一个 "love" 时可以匹配 emoji，但复制多个时无法匹配。

  - 目前对应状态是写死的，有待增加一个数据模型

  目前 emoji 和对应的 "love" 是分开的，以后添加多个时需要一个数据模型将二者联系起来。

  - 还有很多有待改进的地方，这里只是一个雏形。



- 其他

查阅资料的过程中，发现了禁用/解除禁用复制、粘贴等的功能，示例代码如下：

```swift
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        else if action == #selector(select(_:)) {
            return true
        }
        else if action == #selector(selectAll(_:)) {
            return true
        }
        return true
    }

```

PS: 此代码仅供参考，实际应用中应根据不同需求改变。



- 小结

1. 刚开始键盘编辑框用的 `UILabel` ，导致不能编辑（虽然键盘扩展本身也不可编辑，当时没想到用 `UITextView` ）；
2. 键盘扩展无法编辑。刚开始不知道，后来查了相关资料，最后想起了用剪切板操作。



这个 Demo 虽然功能非常简单，但真正实现起来还是遇到了不少问题的，中间也有几次不想搞了，可坚持做下来最后还是能找到解决方法的。



- 参考文章

1. http://www.cocoachina.com/ios/20140922/9706.html
2. http://www.lai18.com/content/330678.html
3. http://superdanny.link/2015/09/16/Custom-UITextField-and-UITextView-function/
4. http://stackoverflow.com/questions/25957366/ios8-custom-keyboard-copy-paste-to-uipasteboard/25978977
5. http://www.cnblogs.com/jaxer/p/6700707.html