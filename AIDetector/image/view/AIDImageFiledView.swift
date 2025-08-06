//
//  AIDImageFiledView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit


class AIDImageFiledView:UIView{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textFiled)
        addSubview(pasteButton)
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = aid_363636.cgColor
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pasteButton.frame = .init(x: width-pasteButton.width-10, y: (height-33)/2, width: pasteButton.width, height: 33)
        textFiled.frame = .init(x: 10, y: 0, width: pasteButton.x - 20, height: height)
        
    }
    
    lazy var textFiled:UITextField = {
        let view = UITextField(frame: .init(x: 10, y: 0, width: width-90, height: height))
        view.attributedPlaceholder = .init(string: AIDString.localized("Paste URL of image"), attributes: [.font:AIDFont.font(14),.foregroundColor:aid_999999])
        view.font = AIDFont.font(14)
        view.textColor = aid_FFFFFF
        return view
    }()
    
    lazy var pasteButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = aid_9843B5
        button.setTitle(AIDString.localized("Paste"), for: .normal)
        button.titleLabel?.font = AIDFont.font(14)
        button.sizeToFit()
        button.width += 30
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
