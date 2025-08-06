//
//  AIDGuideView3.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//


import UIKit


class AIDGuideView3:AIDGuideBaseView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView.image = .img3

        
        addSubview(label1)
      
        addSubview(label5)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label1.frame = .init(x: 0, y: height*0.55, width: width, height: 80)
     
        label5.frame = .init(x: 0, y: label1.frame.maxY+20, width: width, height: 60)
        

    }
    
    lazy var label1:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: height*0.55, width: width, height: 30))
        view.textAlignment = .center
        view.font = AIDFont.boldFont(28)
        view.textColor = aid_FE76F5
        view.text = AIDString.localized("Combating Visual\nFraud")
        view.numberOfLines = 0

        return view
    }()
 
    lazy var label5:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(14)
        view.textColor = aid_FFFFFF.withAlphaComponent(0.8)
        view.numberOfLines = 0
        view.text = AIDString.localized("Expose Edited, Composite, and AI-Fabricated\nPhoto Evidence.")
        return view
    }()
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
