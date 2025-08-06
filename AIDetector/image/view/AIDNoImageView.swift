//
//  AIDNoImageView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit

class AIDNoImageView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textlabel)
        addSubview(imgView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = .init(x: 0, y: 0, width: width, height: height)
        textlabel.frame = .init(x: 0, y: height-50, width: width, height: 50)
    }
    
    lazy var textlabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-20, height: 20))
        view.textColor = aid_999999
        view.font = AIDFont.font(14)
        view.textAlignment = .center
        return view
    }()
    
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: .init(named: "noImage"))
        view.contentMode = .center
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
