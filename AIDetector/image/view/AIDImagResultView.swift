//
//  AIDImagResultView.swift
//  AIDetector
//
//  Created by yong on 2025/7/30.
//

import UIKit

class AIDImagResultView:UIView{
    
    var image:UIImage? = nil{
        didSet{
            if let image = image{
                imgView.image = image
               // setupImageViewWithManualFrame(parentView: contentView, image: image)
            }else{
                imgView.image = image
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textlabel)
        addSubview(contentView)
        contentView.addSubview(imgView)
        
        layer.cornerRadius = 12
        backgroundColor = aid_181818.withAlphaComponent(0.7)
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textlabel.frame =  .init(x: 10, y: 0, width: width-20, height: 50)
        
        contentView.frame = .init(x: 0, y: textlabel.frame.maxY, width: width, height: height-50)
        let hg = contentView.height  - 30
        imgView.frame = .init(x: (width-hg)/2, y: 0, width: hg, height: hg)
    }
    
    func setupImageViewWithManualFrame(parentView: UIView, image: UIImage) {
        let imageView = imgView
        imageView.image = image
        
        
        // 计算保持宽高比的frame
        let containerSize = parentView.bounds.size
        let imageSize = image.size
        
        let widthRatio = containerSize.width / imageSize.width
        let heightRatio = containerSize.height / imageSize.height
        
        let scaleRatio = min(widthRatio, heightRatio)
        let scaledSize = CGSize(
            width: imageSize.width * scaleRatio,
            height: imageSize.height * scaleRatio
        )
        
        imageView.frame = CGRect(
            x: (containerSize.width - scaledSize.width) / 2,
            y: (containerSize.height - scaledSize.height) / 2,
            width: scaledSize.width,
            height: scaledSize.height
        )
        
        parentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textlabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-20, height: 50))
        view.textColor = aid_FFFFFF
        view.font = AIDFont.boldFont(16)
        view.textAlignment = .center
        view.text = AIDString.localized("This one is Al generated image")
        return view
    }()
    
    lazy var contentView:UIView = {
        let view = UIView()
        return view
    }()
    
    
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
}
