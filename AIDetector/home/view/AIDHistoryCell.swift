//
//  AIDHistoryCell.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//


import UIKit


class AIDHistoryCell:UITableViewCell{
    
    static let textCellID = "textCellID"
    static let imgCellID = "imgCellID"
    static let exampleCellID = "exampleCellID"

    enum AIDHistoryType{
        case humanization
        case dection
        case image
        case example
    }
    
    var type:AIDHistoryType = .example{
        didSet{
            switch type {
            case .humanization:
                imgView.image = .flagHumanize
            case .dection:
                imgView.image = .flagDetection
            case .image:
                imgView.image = .flagDeimage
            case .example:
                imgView.image = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(aidView)
        aidView.addSubview(imgView)
        aidView.addSubview(label)
        aidView.addSubview(sublabel)
        aidView.addSubview(dateLabel)
        aidView.addSubview(deImgView)
        aidView.addSubview(progresslabel)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
//        label.layer.borderWidth = 1
//        sublabel.layer.borderColor = UIColor.red.cgColor
//        sublabel.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        aidView.frame = .init(x: 12, y: 0, width: width-24, height: height-20)
        dateLabel.frame = .init(x: 15, y: 0, width: aidView.width, height: 30)
        label.frame = .init(x: 15, y: dateLabel.frame.maxY, width: aidView.width-30, height: 40)
        if type == .dection{
            label.frame = .init(x: 10, y: dateLabel.frame.maxY, width: aidView.width*0.6, height: 40)
        }else if type == .example{
            label.frame = .init(x: 10, y: dateLabel.frame.maxY, width: aidView.width-20, height: 22)
        }
        sublabel.frame = .init(x: label.x, y: label.frame.maxY, width: label.width, height: aidView.height-label.frame.maxY-5)
     
        imgView.frame = .init(x: aidView.width-70, y: 0, width: 70, height: 23)
        
       // let imgHg = aidView.height-10-dateLabel.frame.maxY
        deImgView.frame = .init(x: 10, y: dateLabel.frame.maxY + (aidView.height-dateLabel.frame.maxY-80)/2-6, width: 80, height: 80)
        progresslabel.frame = .init(x: 0, y: dateLabel.frame.maxY, width: aidView.width-10, height: aidView.height-dateLabel.frame.maxY)
        if type == .example{
            progresslabel.frame = .init(x: 0, y: dateLabel.frame.maxY, width: aidView.width-10, height: 40)
        }
        
    }
    
    lazy var aidView:UIImageView = {
        let view = UIImageView(image: .cellbg2)
        
        return view
    }()
    lazy var imgView:UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var dateLabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.textColor = aid_999999
        view.font = AIDFont.font(12)
        view.text = AIDString.localized("Today")
        return view
    }()
    lazy var label:UILabel = {
        let view = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 20))
        view.font = AIDFont.font(14)
        view.textColor = aid_FFFFFF
        view.numberOfLines = 2

        return view
    }()
    lazy var sublabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-10, height: 20))
        view.textColor = aid_999999
        view.font = AIDFont.font(12)
        view.numberOfLines = 3

        return view
    }()
    lazy var progresslabel:UILabel = {
        let view = UILabel.init(frame: .init(x: 10, y: 0, width: width-10, height: 20))
        view.textColor = aid_FF5D61
        view.font = AIDFont.boldFont(18)
        view.textAlignment = .right
        return view
    }()
    lazy var deImgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
}


