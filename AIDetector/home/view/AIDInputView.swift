//
//  AIDInputView.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//

import UIKit

class AIDInputView:UIView,UITextViewDelegate{
    
    
    enum AIDClickType {
        case ocr
        case paste
        case upload
    }
    
    let maxTextCount = 300

    var clickBlock:((_ type:AIDClickType) -> Void)?
    var textUpdateBlock:((String) -> Void)?
    
    
    var contentString:String? = nil{
        didSet{
            
            if let updatedText = contentString, updatedText.count > maxTextCount {
                let index = updatedText.index(updatedText.startIndex, offsetBy: maxTextCount)
                textView.text = String(updatedText[..<index])
            }else{
                textView.text = contentString
            }
            updateTextCount()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = aid_181818.withAlphaComponent(0.7)
        self.addSubview(textView)
        self.addSubview(lineView)
        
        self.addSubview(ocrButton)
        self.addSubview(uploadButton)
        self.addSubview(pasteButton)
        self.addSubview(tipLabel)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        updateTextCount()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = .init(x: 10, y: 10, width: width-20, height: height-110)
        lineView.frame = .init(x: 10, y: height-95, width: width-20, height: 1)
        pasteButton.frame = .init(x: width-20-pasteButton.width, y: lineView.y + 20, width: pasteButton.width, height: 30)
        uploadButton.frame = .init(x: pasteButton.frame.minX-10-uploadButton.width, y: pasteButton.y, width: uploadButton.width, height: pasteButton.height)
        ocrButton.frame = .init(x: uploadButton.frame.minX-10-ocrButton.width, y: pasteButton.y, width: ocrButton.width, height: pasteButton.height)
        tipLabel.frame = .init(x: 0, y: height-40, width: width-20, height: 30)
    }
    
    @objc func ocrClick(){
        clickBlock?(.ocr)
    }
    
    @objc func uploadClick(){
        clickBlock?(.upload)
    }
    
    @objc func pasteClick(){
        clickBlock?(.paste)
    }
    
    func updateTextCount(){
        let count = textView.text.count
        let text1 = "\(count)"
        let text2 = " / \(maxTextCount)"
        let text = text1 + text2
        let attr = NSMutableAttributedString(string: text)
        attr.addAttributes([.foregroundColor:aid_FFFFFF], range: .init(location: 0, length: text1.count))
        tipLabel.attributedText = attr
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        

        textUpdateBlock?(textView.text)
        updateTextCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        

        if updatedText.count > maxTextCount {
            let index = updatedText.index(updatedText.startIndex, offsetBy: maxTextCount)
            textView.text = String(updatedText[..<index])
            
            updateTextCount()
            
            return false
        }
        
        return true
    }
    
    lazy var textView:UITextView = {
        let view = UITextView(frame: .init(x: 0, y: 0, width: width, height: height-100))
        view.textColor = aid_FFFFFF
        view.font = AIDFont.font(14)
        view.backgroundColor = .clear
        view.placeholder = AIDString.localized("Paste AI-generated text or any content you want to sound more natural here...")
        view.delegate = self
        return view
    }()
    
    lazy var lineView:UIView = {
        let view = UIView(frame: .init(x: 10, y: height-70, width: width-20, height: 1))
        view.backgroundColor = aid_292929
        return view
    }()
    
    lazy var ocrButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.iconOcr, for: .normal)
        button.backgroundColor = aid_9843B5
        button.addTarget(self, action: #selector(ocrClick), for: .touchUpInside)
        button.sizeToFit()
        button.width = 30

        button.layer.cornerRadius = 15
        button.addHighlightAnimation()
        button.clipsToBounds = true
        return button
    }()
    
    lazy var uploadButton:UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(.iconUpload.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = aid_9843B5
        button.addTarget(self, action: #selector(uploadClick), for: .touchUpInside)
        button.setTitle(AIDString.localized("Upload" + " "), for: .normal)
        button.setTitleColor(aid_FFFFFF, for: .normal)

        button.imageEdgeInsets.right = 6
        button.sizeToFit()
        button.width += 20
        button.layer.cornerRadius = 15
        button.titleLabel?.font = AIDFont.font(12)
        button.addHighlightAnimation()
        button.clipsToBounds = true
        return button
    }()
    
    
    lazy var pasteButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.iconCopy.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = aid_9843B5
        button.addTarget(self, action: #selector(pasteClick), for: .touchUpInside)
        button.setTitle(AIDString.localized("Paste" + " "), for: .normal)
        button.imageEdgeInsets.right = 6

        button.sizeToFit()
        button.width += 20
        button.layer.cornerRadius = 15
        button.titleLabel?.font = AIDFont.font(12)
        button.addHighlightAnimation()
        button.clipsToBounds = true
      

        return button
    }()
    
    lazy var tipLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width-20, height: 30))
        label.textAlignment = .right
        label.font = AIDFont.font(12)
        label.textColor = aid_999999
        label.text = "0/1500"
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



