//
//  AIDGuideView1.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit


class AIDGuideView1:AIDGuideBaseView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView.image = .img1
        
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(lable4Img)
        lable4Img.addSubview(label4)
        addSubview(label5)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label1.frame = .init(x: 0, y: height*0.45, width: width, height: 30)
        label2.frame = .init(x: 0, y: label1.frame.maxY, width: width, height: 30)
        label3.frame = .init(x: 0, y: label2.frame.maxY+20, width: width, height: 20)
        lable4Img.frame = .init(x: 0, y: height*0.7, width: width, height: 60)
        label4.frame = lable4Img.bounds
        label5.frame = .init(x: 0, y: lable4Img.frame.maxY, width: width, height: 30)
        

        
    }
    
    lazy var label1:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: height*0.5, width: width, height: 30))
        view.textAlignment = .center
        view.font = AIDFont.boldFont(28)
        view.textColor = aid_FFFFFF
        view.text = AIDString.localized("Welcome to")
        return view
    }()
    lazy var label2:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.boldFont(28)
        view.textColor = aid_FE76F5
        view.text = AIDString.localized("AI Detector")
        return view
    }()
    lazy var label3:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(14)
        view.textColor = aid_FFFFFF.withAlphaComponent(0.8)
        view.text = AIDString.localized("All your homework need in one")
        return view
    }()
    lazy var label4:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(20)
        view.textColor = aid_FFFFFF
        view.text = AIDString.localized("#1 Rated")
        return view
    }()
    lazy var label5:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(14)
        view.textColor = aid_FFFFFF.withAlphaComponent(0.8)
        view.text = AIDString.localized("Humanizer and Detector App")
        return view
    }()
    
    lazy var lable4Img:UIImageView = {
        let view = UIImageView(image: .gimg3)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



