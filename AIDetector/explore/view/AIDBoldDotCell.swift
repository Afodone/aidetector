//
//  AIDBoldDotCell.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//


import UIKit

class AIDBoldDotCell:UITableViewCell{
    
    let inset = 20.0
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(aidView)
        contentView.addSubview(imgView)
        contentView.addSubview(label)
//        contentView.addSubview(sublabel)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        label.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
     
            label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset/2),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imgView.heightAnchor.constraint(equalToConstant: 5),
            imgView.widthAnchor.constraint(equalToConstant: 5),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17)
            
        ])

    }

    lazy var aidView:UIImageView = {
        let view = UIImageView(image: nil)
        return view
    }()
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 2
        view.backgroundColor = aid_FFFFFF
        
        return view
    }()
    lazy var label:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.font = AIDFont.font(14)
        view.textColor = aid_999999
        view.text = AIDString.localized("ImgDetect")
        view.numberOfLines = 0
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



