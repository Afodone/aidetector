//
//  AIDTextDetectionResultView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit

class AIDTextDetectionResultView:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(view)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.frame = .init(x: 10, y: 0, width: width-20, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var view:AIDTextDectecionResultItemView = {
        let info = AIDTextDectecionResultItemView()
        return info
    }()
}

class AIDTextDectecionResultItemView:UIView{
    
    var text:String = "Al-generated"
    var progress = 10
    
    var dotColor:UIColor = aid_C9C9C9
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setFillColor(dotColor.cgColor)
        context.addArc(center: .init(x: 7, y: height/2), radius: 7, startAngle: 0, endAngle: .pi*2, clockwise: true)
        context.fillPath()
        
        let size = (text as NSString).size(withAttributes: [.font:AIDFont.font(14)])
        
        (text as NSString).draw(at: .init(x: 20, y: (height-size.height)/2),withAttributes: [.font:AIDFont.font(14),.foregroundColor:aid_999999])
                                
        let ps = NSMutableParagraphStyle()
        ps.alignment = .right
    
        let pro = "\(progress)%"
        (pro as NSString).draw(in: .init(x: 0, y: (height-size.height)/2, width: width, height: height), withAttributes: [.paragraphStyle:ps,.font:AIDFont.font(14),.foregroundColor:aid_999999])
                        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
