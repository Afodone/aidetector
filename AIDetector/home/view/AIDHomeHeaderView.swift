//
//  AIDHomeHeaderView.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDHomeHeaderView:UIView{
   
    enum AIDType{
        case humanize
        case detection
    }
    
    var chooseBlock:((_ type:AIDType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(humView)
        addSubview(decView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func humViewClick(){
        chooseBlock?(.humanize)
    }
    @objc func decViewClick(){
        chooseBlock?(.detection)
    }
    
    lazy var humView:AIDHomeItemView = {
        let view = AIDHomeItemView(frame: .init(x: 0, y: 0, width: (width-20)/2, height: height))
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(humViewClick)))
        
        return view
    }()
    
    lazy var decView:AIDHomeItemView = {
        let view = AIDHomeItemView(frame: .init(x: width/2+10, y: 0, width: (width-20)/2, height: height))
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(decViewClick)))
        view.imgView.image = .homeIcon2
        view.sublabel.text = AIDString.localized("Is This AI-Written?\nFind Out Instantly")
        view.label.text = AIDString.localized("AI Detection")
        return view
    }()

}
