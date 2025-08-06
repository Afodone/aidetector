//
//  AIDResultBottomView.swift
//  AIDetector
//
//  Created by yong on 2025/7/27.
//

import UIKit

class AIDResultBottomView:UIView{
    
    enum AIDResultType{
        case copy
        case share
        case regenerate
    }
    
    var didChooseBlock:((_ type:AIDResultType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(copyButton)
        addSubview(shareButton)
        addSubview(regenerateButton)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        copyButton.frame = .init(x: 0, y: 0, width: height, height: height)
        shareButton.frame = .init(x: (width-height)/2, y: 0, width: copyButton.width, height: copyButton.height)
        regenerateButton.frame = .init(x: width-copyButton.width, y: 0, width: copyButton.width, height: copyButton.height)
        
    }
    @objc func regenerateClick(){
        didChooseBlock?(.regenerate)
    }
    @objc func copyClick(){
        didChooseBlock?(.copy)

    }
    @objc func shareClick(){
        didChooseBlock?(.share)

    }
    lazy var copyButton:UIButton = {
        let button = createVerticalButton(image: UIImage(named: "icon_result_copy"), title: AIDString.localized("Copy"))
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(copyClick), for: .touchUpInside)

        return button
    }()
    lazy var shareButton:UIButton = {
        let button = createVerticalButton(image: UIImage(named: "icon_result_share"), title: AIDString.localized("Share"))
        button.addTarget(self, action: #selector(shareClick), for: .touchUpInside)

        return button
    }()
    lazy var regenerateButton:UIButton = {
        let button = createVerticalButton(image: UIImage(named: "icon_result_restart"), title: AIDString.localized("Regenerate"))

        button.addTarget(self, action: #selector(regenerateClick), for: .touchUpInside)
        return button
    }()
    
    func createVerticalButton(image: UIImage?, title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.tintColor = .black
        button.backgroundColor = aid_1A1A1A
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        // 创建垂直堆栈视图
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false // 允许按钮接收触摸
        
        // 添加图片视图
        let imageView = UIImageView(image: image?.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // 添加标签
        let label = UILabel()
        label.text = title
        label.font = AIDFont.font(12)
        label.textColor = aid_FFFFFF
        
        // 添加子视图
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        // 将堆栈视图添加到按钮
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: button.trailingAnchor, constant: -8)
        ])
        
        return button
    }

    // 使用示例
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


