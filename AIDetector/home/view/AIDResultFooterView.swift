//
//  AIDResultFooterView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//


import UIKit
class AIDResultFooterView:UIView{
    
    enum AIDResultChooseType {
        case like
        case disLike
    }
    
    var didChooseBlock:((_ type:AIDResultChooseType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(likedButton)
        addSubview(titleLabel)
        addSubview(disLikedButton)
        backgroundColor = aid_000000
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = .init(x: 0, y: 0, width: width, height: 50)
        likedButton.frame = .init(x: width/2-80, y: titleLabel.frame.maxY-20, width: 80, height: 80)
        disLikedButton.frame = .init(x: width/2, y: titleLabel.frame.maxY-20, width: 80, height: 80)

    }
    
    @objc func likeClick(){
        didChooseBlock?(.like)
    }
    
    @objc func dislikeClick(){
        didChooseBlock?(.disLike)
    }
    
    lazy var likedButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.like, for: .normal)
        button.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    lazy var disLikedButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.dislike, for: .normal)
        button.addTarget(self, action: #selector(dislikeClick), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width, height: 40))
        label.font = AIDFont.boldFont(16)
        label.textColor = aid_FFFFFF
        label.text = AIDString.localized("Did you like the results?")
        label.textAlignment = .center
        return label
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
