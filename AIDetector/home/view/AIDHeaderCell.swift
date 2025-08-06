//
//  AIDHeaderCell.swift
//  AIDetector
//
//  Created by yong on 2025/8/1.
//


import UIKit


class AIDHeaderCell:UITableViewCell{
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        contentView.addSubview(titleLabel)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = .init(x: 20, y: 10, width: width-20, height: height-10)
     
    }
    
 
    lazy var titleLabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textColor = aid_FFFFFF
        view.font = AIDFont.boldFont(18)
        return view
    }()
   
    
}
