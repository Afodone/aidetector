//
//  AIDHomeImageCell.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit


class AIDHomeImageCell:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aidView)
        aidView.addSubview(imgView)
        aidView.addSubview(label)
        aidView.addSubview(sublabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        aidView.frame = .init(x: 12, y: 0, width: width-24, height: height)
        imgView.frame = .init(x: 10, y: (aidView.height-50)/2, width: 50, height: 50)
        
        label.frame = .init(x: imgView.frame.maxX+10, y: imgView.frame.minY, width: aidView.width-imgView.frame.maxX, height: 20)
        sublabel.frame = .init(x: label.x, y: imgView.frame.maxY-20, width: label.width, height: 20)
        
    }
    
    lazy var aidView:UIImageView = {
        let view = UIImageView(image: .cellbg2)
        
        return view
    }()
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: .homeIcon3)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var label:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.font = AIDFont.boldFont(16)
        view.textColor = aid_FFFFFF
        view.text = AIDString.localized("ImgDetect")
        return view
    }()
    lazy var sublabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-10, height: 20))
        view.textColor = aid_999999
        view.numberOfLines = 0
        view.text = AIDString.localized("Detect AI generated images")
        return view
    }()
    
    
}





