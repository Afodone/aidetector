//
//  AIDGuideBaseView.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDGuideBaseView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = .init(x: width*0.1, y: 0, width: width*0.8, height: height*0.5)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFit
        return view
        
    }()
    
    
}
