//
//  AIDExploreCell.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//


import UIKit


class AIDExploreCell:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aidView)
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        contentView.addSubview(sublabel)
        contentView.addSubview(lineView)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        aidView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            aidView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            aidView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            aidView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            aidView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            label.leadingAnchor.constraint(equalTo: aidView.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: aidView.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: aidView.topAnchor, constant: 0),
            
            sublabel.leadingAnchor.constraint(equalTo: aidView.leadingAnchor, constant: 0),
            sublabel.trailingAnchor.constraint(equalTo: aidView.trailingAnchor, constant: 0),
            sublabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            sublabel.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -10),
            
            imgView.leadingAnchor.constraint(equalTo: aidView.leadingAnchor, constant: 0),
            imgView.trailingAnchor.constraint(equalTo: aidView.trailingAnchor, constant: 0),
            imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 143/343),
            imgView.bottomAnchor.constraint(equalTo: aidView.bottomAnchor, constant: -30),
            imgView.topAnchor.constraint(equalTo: sublabel.bottomAnchor, constant: 10),
            
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            lineView.heightAnchor.constraint(equalToConstant: 1)
            
        ])

    }

    
    lazy var aidView:UIImageView = {
        let view = UIImageView(image: nil)
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
    
    lazy var lineView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .init(patternImage: .cellLine)
        return view
    }()
    
}








