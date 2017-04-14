//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by 焦相如 on 07/04/2017.
//  Copyright © 2017 jaxer. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
//    var label: UILabel? = nil //键盘显示框
    var textView: UITextView? = nil //键盘显示框
    var attrString: NSMutableAttributedString? = NSMutableAttributedString() //键盘显示表情内容
    
    ///创建一个 emoji 按键
    func createEmojiBtn() -> UIButton {
        let button = UIButton.init(type: .system) as UIButton
        button.frame = CGRect(x: 85, y: 50, width: 50, height: 50)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setBackgroundImage(UIImage(named: "love"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }
    
    ///点击事件
    func didTapButton() {
        print("didTapButton")
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("[love]") //添加到编辑框
        addEmoji()
    }
    
    func createTransBtn() -> UIButton {
        let button = UIButton.init(type: .system) as UIButton
        button.frame = CGRect(x: 200, y: 50, width: 30, height: 30)
        button.sizeToFit()
        button.backgroundColor = UIColor.green
        button.setTitle("Tr", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(translate), for: .touchUpInside)
        return button
    }
    
    ///文本转换为 emoji
    func translate() {
        print("translate")
        let paste = UIPasteboard.general.string
        if let paste = paste {
            if paste == "love" || paste == "[love]" {
                addEmoji()
            }
        }
    }
    
    ///添加 emoji 到 textView
    func addEmoji() {
        let textAttach = NSTextAttachment()
        textAttach.image = UIImage(named: "love")
        textAttach.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        //添加到键盘编辑框
        let string = NSAttributedString.init(attachment: textAttach)
        attrString?.append(string)
        self.textView?.attributedText = attrString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView(frame: CGRect(x: 5, y: 5, width: 400, height: 40))
        textView?.backgroundColor = UIColor.yellow
        textView?.isEditable = true
        self.view.addSubview(textView!)
        
        //emoji 按键
        let button = createEmojiBtn()
        self.view.addSubview(button)
        
        //转换按键
        let transBtn = createTransBtn()
        self.view.addSubview(transBtn)
    }
    
    ///暂时没用
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        UIMenuController.shared.isMenuVisible = true
//        let menu = UIMenuController.shared
//        self.becomeFirstResponder()
        
//        if action == #selector(copy(_:)) {
//            return true
//        }
//        else if action == #selector(select(_:)) {
//            return true
//        }
//        else if action == #selector(selectAll(_:)) {
//            return true
//        }
//        return super.canPerformAction(action, withSender: sender)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
}
