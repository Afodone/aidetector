//
//  AIDChooseView.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//

import UIKit

class AIDChooseView:UIView{
    
    var chooseBlock:(() -> Void)?
    
    var currentTone:String? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(addButton)
        addSubview(itemsView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = .init(x: 0, y: 0, width: width-20, height: 40)
        addButton.frame = .init(x: width-94, y: 5, width: 74, height: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        
        let items = AIDToneDataFile.getAllTones().map { json in
            AIDToneData.convertToModel(jsonString: json).name
        }
        var index = itemsView.selectedIndex
        if index != -1{
            index = index + 1
        }
        itemsView.configure(with: items, selectedIndex: index)
    }
    
    @objc func addClick(){
   
        chooseBlock?()
    }
    
    lazy var addButton:UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        button.setTitle(" "+AIDString.localized("Add"), for: .normal)
        button.setImage(.init(named: "fill_add"), for: .normal)
        button.setTitleColor(aid_9843B5, for: .normal)
        button.layer.borderColor = aid_9843B5.cgColor
        button.layer.borderWidth = 1
        button.sizeToFit()
        button.width += 30
        button.layer.cornerRadius = 15
        button.titleLabel?.font = AIDFont.font(12)
        button.addHighlightAnimation()
        button.clipsToBounds = true
      
        return button
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width-20, height: 40))
        label.font = AIDFont.boldFont(16)
        label.textColor = aid_FFFFFF
        label.text = AIDString.localized("Choose a Tone")
        
        return label
    }()

    lazy var itemsView:AIDHorizontalTextCollectionView = {
        
        let items = AIDToneDataFile.getAllTones().map { json in
            AIDToneData.convertToModel(jsonString: json).name
        }
        
        
        let collectionView = AIDHorizontalTextCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        // 配置
        collectionView.itemFont = AIDFont.font(14)
        collectionView.itemTextColor = aid_FFFFFF
        collectionView.selectedItemTextColor = aid_FFFFFF
        collectionView.selectedItemBackgroundColor = aid_9843B5
        collectionView.itemSpacing = 10
        collectionView.itemPadding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        // 设置数据
        collectionView.configure(with: items, selectedIndex: -1)
        
        // 选中回调
        collectionView.itemSelected = { index in
            print("选中了: \(index) - \(items[index])")
            self.currentTone = items[index]
        }
        
        return collectionView
          
    }()
}
