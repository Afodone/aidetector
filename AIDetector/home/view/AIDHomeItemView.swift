//
//  AIDHomeItemView.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDHomeItemView:UIView{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(label)
        addSubview(sublabel)
        addSubview(imgView)
        addSubview(imgArrowView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sublabel.sizeToFit()
        imgView.frame = .init(x: 10, y: 10, width: 40, height: 40)
        imgArrowView.frame = .init(x: width-40, y: 10, width: 40, height: 40)
        label.frame = .init(x: 10, y: imgView.frame.maxY+20, width: width-10, height: 20)
        sublabel.frame = .init(x: 10, y: label.frame.maxY+20, width: width-10, height:sublabel.height)
        bgView.frame = bounds
    }
    
    lazy var label:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.font = AIDFont.boldFont(16)
        view.textColor = aid_FFFFFF
        view.text = AIDString.localized("Humanize")
        return view
    }()
    lazy var sublabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-10, height: 20))
        view.textColor = aid_999999
        view.numberOfLines = 0
        view.text = AIDString.localized("Make Your Text\nSound Natural &\nEngaging")
        return view
    }()
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: .homeIcon1)
        view.contentMode = .center
        return view
    }()
    lazy var imgArrowView:UIImageView = {
        let view = UIImageView(image: .homeArrow)
        view.contentMode = .center
        return view
    }()
    lazy var bgView:UIImageView = {
        let view = UIImageView(image: .itembg1)
        view.alpha = 0.3
        return view
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
