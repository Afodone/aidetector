//
//  AIDGuideView2.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//


import UIKit


class AIDGuideView2:AIDGuideBaseView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView.image = .img2

        
        addSubview(label1)
      
        addSubview(lable4Img)
       // lable4Img.addSubview(label4)
        addSubview(label5)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label1.frame = .init(x: 0, y: height*0.5, width: width, height: 30)
      
        lable4Img.frame = .init(x: 0, y: label1.frame.maxY+20, width: width, height: 60)
        label4.frame = lable4Img.bounds
        label5.frame = .init(x: width*0.1, y: lable4Img.frame.maxY+40, width: width*0.8, height: 90)
        
    }
    
    lazy var label1:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: height*0.5, width: width, height: 30))
        view.textAlignment = .center
        view.font = AIDFont.boldFont(28)
        view.textColor = aid_FE76F5
        view.text = AIDString.localized("Powerful")
        return view
    }()
 
    lazy var label4:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(20)
        view.textColor = aid_FFFFFF
        view.text = AIDString.localized("AIO Detector")
        return view
    }()
    lazy var label5:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textAlignment = .center
        view.font = AIDFont.font(14)
        view.numberOfLines = 0
        view.textColor = aid_FFFFFF.withAlphaComponent(0.8)
        view.text = AIDString.localized("My services include verifying the authenticity\nof article images and humanizing AI-\ngenerated text.")
        return view
    }()
    
    lazy var lable4Img:UIImageView = {
        let view = UIImageView(image: .gimg5)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
