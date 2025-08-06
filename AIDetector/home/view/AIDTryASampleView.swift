//
//  AIDTryASampleView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit

class AIDTryASampleView:UIView{
    
    
    var applayBlock:((String) -> Void)?
    
    var currentData:AIDSampleData = AIDSampleData.datas[0]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backview)
        addSubview(titleLabel)
        addSubview(refreshButton)

        backview.addSubview(applyButton)
        backview.addSubview(lineView)
        backview.addSubview(contentLabel)
       
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isAnimate{
            return
        }
        titleLabel.frame = .init(x: 0, y: 0, width: width-0, height: 40)
        refreshButton.frame = .init(x: width-40, y: 0, width: 40, height: 40)
        backview.frame = .init(x: 0, y: 40, width: width, height: height-40)

        let width = backview.width
        let height = backview.height
        
        applyButton.frame = .init(x: width-applyButton.width-10, y: height-40, width: applyButton.width, height: 30)
        lineView.frame = .init(x: 10, y: applyButton.y-10, width: width-20, height: 1)
        contentLabel.frame = .init(x: 10, y: 6, width: width-20, height:lineView.y - 10)
        
    }
    
    var isAnimate = false
    @objc func appleyClick(){
        isAnimate = true
        applayBlock?(currentData.name)
        UIView.animate(withDuration: 0.3) {
            self.backview.height = 0
            self.backview.alpha = 0
        }completion: { finish in
            self.isAnimate = false
        }
    }
    @objc func refreshClick(){
        isAnimate = true

        UIView.animate(withDuration: 0.3) {
            self.backview.height = self.height-40
            self.backview.alpha = 1
        }completion: { finish in
            self.isAnimate = false
        }
        currentData = AIDSampleData.datas.randomElement() ?? AIDSampleData.datas[0]
        self.contentLabel.text = AIDString.localized(currentData.name)
        
    }
    lazy var refreshButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.refresh, for: .normal)
        button.addTarget(self, action: #selector(refreshClick), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addPulseAnimation()
        return button
    }()
    lazy var applyButton:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = aid_9843B5
        button.setTitle(AIDString.localized("Apply"), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = AIDFont.font(12)
        button.sizeToFit()
        button.width += 20
        button.addPulseAnimation()
        button.addTarget(self, action: #selector(appleyClick), for: .touchUpInside)

        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width, height: 40))
        label.font = AIDFont.boldFont(16)
        label.textColor = aid_FFFFFF
        label.text = AIDString.localized("Try a simple")
        label.textAlignment = .left
        return label
    }()
   
    lazy var contentLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width, height: 40))
        label.font = AIDFont.font(14)
        label.textColor = aid_999999
        label.text = AIDString.localized(currentData.name)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = aid_292929
        return view
    }()
    
    lazy var backview:UIView = {
        let view = UIView()
        view.backgroundColor = aid_181818
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
