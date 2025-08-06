//
//  AIDDetectView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit

class AIDDetectView:UIView{
    
    var image:UIImage? = nil{
        didSet{
            imgView.image = image
            hasImage = image != nil
        }
    }
    
    var hasImage:Bool = false{
        didSet{
            noImageView.isHidden = hasImage
            orLabel.isHidden = hasImage
            deleteButton.isHidden = !hasImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(borderView)
        addSubview(textlabel)
        borderView.addSubview(noImageView)
        borderView.addSubview(imgView)
        borderView.addSubview(orLabel)
        borderView.isUserInteractionEnabled = true
        borderView.addSubview(deleteButton)
        addSubview(textFiledView)
        
        noImageView.isUserInteractionEnabled = false
        imgView.isUserInteractionEnabled = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textlabel.frame = .init(x: 0, y: 0, width: width, height: 50)
        borderView.frame = .init(x: 10, y: textlabel.frame.maxY, width: width-20, height: 225/311 * (width-20))
        noImageView.frame = .init(x: 0, y: borderView.height*0.2, width: borderView.width, height: borderView.height*0.6)
        orLabel.frame = .init(x: borderView.width/2-20, y: borderView.height-20, width: 40, height: 40)
        textFiledView.frame = .init(x: 10, y: borderView.frame.maxY + 50, width: width-20, height: 57)
        
        let wd = borderView.height*0.8
        imgView.frame = .init(x: (borderView.width-wd)/2, y:(borderView.height-wd)/2, width: wd, height: wd)
        deleteButton.frame = .init(x: width-65, y: 5, width: 40, height: 40)
    }
    
    
    lazy var textlabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-10, height: 20))
        view.textColor = aid_FFFFFF
        view.numberOfLines = 0
        view.font = AIDFont.boldFont(16)
        view.text = AIDString.localized("Detect AI generated images")
        view.textAlignment = .center
        return view
    }()
    
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: nil)
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.red.cgColor
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var borderView:UIImageView = {
        let view = UIImageView(image: .imageBorder)
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var orLabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: 40, height: 40))
        view.textColor = aid_FFFFFF
        view.numberOfLines = 0
        view.font = AIDFont.font(14)
        view.text = AIDString.localized("OR")
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = aid_000000
        
        return view
    }()
    
    lazy var noImageView:AIDNoImageView = {
        let view = AIDNoImageView()
        return view
    }()
    
    lazy var textFiledView:AIDImageFiledView = {
        let view = AIDImageFiledView()
        
        return view
    }()
    
    lazy var deleteButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.init(named: "close_fill_gray"), for: .normal)
        button.isHidden = true
        return button
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


