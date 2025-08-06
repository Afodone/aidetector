//
//  AIDResultView.swift
//  AIDetector
//
//  Created by yong on 2025/7/27.
//


import UIKit

class AIDResultView:UIView{
    
    enum AIDClickType {
        case ocr
        case paste
        case upload
    }

    var clickBlock:((_ type:AIDClickType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = aid_181818.withAlphaComponent(0.7)
        self.addSubview(textView)
        self.addSubview(lineView)
        
  
        self.addSubview(bottomView)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame = .init(x: 10, y: 10, width: width-20, height: height-140)
        lineView.frame = .init(x: 10, y: height-130, width: width-20, height: 1)
        bottomView.frame =  .init(x: 30, y: lineView.frame.maxY+20, width: width-60, height: 90)
    
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
    
    lazy var textView:UITextView = {
        let view = UITextView(frame: .init(x: 0, y: 0, width: width, height: height-100))
        view.textColor = aid_FFFFFF
        view.font = AIDFont.font(14)
        view.isEditable = false
        view.backgroundColor = .clear
        view.placeholder = AIDString.localized("Paste AI-generated text or any content you want to sound more natural here...")
        return view
    }()
    
    lazy var lineView:UIView = {
        let view = UIView(frame: .init(x: 10, y: height-70, width: width-20, height: 1))
        view.backgroundColor = aid_292929
        return view
    }()
    

    lazy var bottomView:AIDResultBottomView = {
        let view = AIDResultBottomView(frame: .init(x: 0, y: 0, width: width, height: 90))
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
