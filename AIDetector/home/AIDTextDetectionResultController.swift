//
//  AIDTextDetectionViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit
import SwiftyJSON

class AIDTextDetectionResultController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    enum AIDDectionType{
        case text
        case image
        
    }
    var currentType:AIDDectionType = .text
    
    var datalist = AIDTextDetectionData.datas
    
    var imageDetectionResult:JSON?
    
    var currentData:AIDHumanData?
    
    var isExample = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.image = nil
        self.showBarbutton()
        
        self.view.addSubview(aidTable)
        aidTable.tableHeaderView = headerView
        
        headerView.addSubview(self.progressBg)
        self.progressBg.addSubview(figlineView)
        headerView.addSubview(progressLabel)
        headerView.addSubview(textLabel)
        progressBg.layer.borderWidth = 0
        progressBg.layer.borderColor = UIColor.blue.cgColor
        headerView.addSubview(textDectionTipsView)
        
        let footer = UIView()
        footer.frame = .init(x: 0, y: 0, width: self.view.width-20, height: 90)
        aidTable.tableFooterView = footer
        
        if !isExample{
            footer.addSubview(shareButton)
        }else{
            aidTable.addSubview(self.blurEffectView)
        }
      
        if self.currentType != .image{
            self.view.addSubview(sureButton)

        }
        
        let wd = (self.view.width-20)*0.7-20
        figlineView.layer.anchorPoint = .init(x: (wd-11)/wd, y: 0.5)
        
        updateData()
        
    
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sureButton.frame = .init(x: 16, y: self.view.height-self.view.safeAreaInsets.bottom-10-52, width: self.view.width-32, height: 52)
        
        if self.currentType == .image{
            aidTable.frame = .init(x: 16, y: self.view.safeAreaInsets.top, width: self.view.width-32, height: self.view.height-self.view.safeAreaInsets.top)

        }else{
            aidTable.frame = .init(x: 16, y: self.view.safeAreaInsets.top, width: self.view.width-32, height: sureButton.y-self.view.safeAreaInsets.top)

        }
        let wd = aidTable.width*0.75
        let hg = wd * (138.0/245.0)
        
        progressBg.frame = .init(x: (aidTable.width-wd)/2, y: 50, width: wd, height: hg)
        
        let figWd = wd/2-20
        figlineView.frame = .init(x: 20, y: progressBg.height-50, width: figWd, height: 50/112 * figWd)
        figlineView.frame = .init(x: 20, y: progressBg.height-22, width: figWd, height:22)
        
        progressLabel.frame = .init(x: 0, y: progressBg.frame.maxY+30, width: aidTable.width, height: 50)
        textLabel.frame = .init(x: 0, y: progressLabel.frame.maxY + 20, width: aidTable.width, height: 60)
        
        if currentType == .image{
            headerView.frame = .init(x: 0, y: 0, width: aidTable.width, height: progressLabel.frame.maxY+30)
        }else{
            textDectionTipsView.frame = .init(x: 0, y: textLabel.frame.maxY, width: self.view.width-32, height: 98)
            headerView.frame = .init(x: 0, y: 0, width: aidTable.width, height: textDectionTipsView.frame.maxY+10)
        }
        
        if self.isExample{
            self.blurEffectView.frame = .init(x: 0, y: textLabel.frame.maxY, width: aidTable.width, height: 108 + 160)
        }
        
    }
    var showRate = false
    @objc func backClick(){
        if !showRate {
            AIDTools.showRate()
            showRate = true
            return
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func upgradePro(){
        print("updagrade....")
    }
    
    func showBarbutton(){
        let backView = UIView(frame: .init(x: 0, y: 0, width: 200, height: 40))
        backView.backgroundColor = .clear
        backView.addSubview(self.titelLabel)
        
        let button = UIButton.init(type: .custom)
        button.setImage(.navBack, for: .normal)
        button.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        button.frame = .init(x: 0, y: 0, width: 30, height: 40)
        backView.addSubview(button)
        titelLabel.x = 30
        self.navigationItem.leftBarButtonItem = .init(customView: backView)
        titelLabel.text = AIDString.localized("Detection Result")
        
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backClick)))
        
        self.showProButton()
    }
    
    func startAnimation(_ pro:CGFloat = 0.8){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = pro * Double.pi
        rotationAnimation.duration = 1.0
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = .forwards
        figlineView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    func updateData(){
        if let data = currentData{
            textDectionTipsView.isHidden = true
            if data.type == 1{
                let json = JSON(data.result.data(using: .utf8) as Any)
                let result = json["result"].floatValue
                let value = Int(result)
                progressLabel.count(from: 0, to: Double(value), duration: 1.0)

                startAnimation(CGFloat(result)/100.0)
                textDectionTipsView.isHidden = false

                if value <= 20{
                    textLabel.text = AIDString.localized("Text is likely Human-written.")
                }else if value > 20 && value <= 40{
                    textLabel.text = AIDString.localized("Mostly Human, slight AI influence.")
                }else if value > 40 && value <= 60{
                    textLabel.text = AIDString.localized("Unclear: Mixed human and AI traits.")
                }else if value > 60 && value <= 80{
                    textLabel.text = AIDString.localized("Likely AI-Generated, with human edits.")
                }else if value > 80 && value <= 100{
                    textLabel.text = AIDString.localized("Text is highly probable AI-Generated.")
                }
                
                textDectionTipsView.data = AIDTextDetectionData.decodingJson(json)
//                0%-20%     Text is likely Human-written.
//                21%-40%    Mostly Human, slight AI influence.
//                41%-60%    Unclear: Mixed human and AI traits.
//                61%-80%    Likely AI-Generated, with human edits.
//                81%-100%   Text is highly probable AI-Generated.
                
            }else if data.type == 2{
                textLabel.isHidden = true
                self.sureButton.isHidden = true
                if let json = imageDetectionResult{
                    let result = json["result"].floatValue
                    if let value = json["result_details"].dictionaryValue["final_result"]?.stringValue{
                        self.imageResultView.textlabel.text = "This one is \(value) image"
                    }
//                    progressLabel.text = "\(Int(result))% AI"
                    progressLabel.count(from: 0, to: Double(result), duration: 1.0)

                    imageResultView.image = currentData?.getImage()
                    startAnimation(CGFloat(result)/100.0)
                }
            }
        }else{
            startAnimation()
        }
    }
    
    @objc func shareClick(){
        
        if let image = currentData?.getImage(){
            let act = UIActivityViewController.init(activityItems: [image], applicationActivities: nil)
            self.present(act, animated: true)
        }
        
    }
    
    @objc func sureButtonClick(){
        let ctr = AIDHomeInputViewController()
        if let text = self.currentData?.contenet{
            ctr.topView.textView.text = text
        }
        self.navigationController?.pushViewController(ctr, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentType == .image{
            return 1
        }
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentType == .image{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cella") else {return UITableViewCell()}
            cell.backgroundColor = aid_181818
            cell.contentView.backgroundColor = aid_181818
            cell.selectionStyle = .none
            cell.contentView.addSubview(imageResultView)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AIDTextDetectionResultView else {return UITableViewCell()}
        cell.backgroundColor = aid_181818
        cell.contentView.backgroundColor = aid_181818
        cell.selectionStyle = .none
        let data = self.datalist[indexPath.row]
        
        cell.view.text = data.name
        cell.view.progress = data.progress
        cell.view.backgroundColor = aid_181818
        
        if indexPath.row == 3{
            cell.view.dotColor = aid_FF5D61
        }else{
            cell.view.dotColor = aidHexColor("#D9D9D9")
        }

        cell.setNeedsDisplay()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currentType == .image{
            return self.imageResultView.frame.maxY
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.mask = nil
        
        if currentType == .image{
            let shapeLayer = CAShapeLayer()
            let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                          byRoundingCorners: [.allCorners],
                                          cornerRadii: CGSize(width: 8,height: 8))
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
            return
        }
        if indexPath.row == 0{
            let shapeLayer = CAShapeLayer()
            let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                          byRoundingCorners: [.topLeft,.topRight],
                                          cornerRadii: CGSize(width: 8,height: 8))
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
        }else if indexPath.row == datalist.count-1{
            let shapeLayer = CAShapeLayer()
            let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                          byRoundingCorners: [.bottomLeft,.bottomRight],
                                          cornerRadii: CGSize(width: 8,height: 8))
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
        }else{
            cell.layer.mask = nil
        }
        
    }
    
    
    
    lazy var aidTable:UITableView = {
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        table.register(AIDTextDetectionResultView.self, forCellReuseIdentifier: "cell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cella")
        
        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        return table
    }()
    lazy var progressBg:UIImageView = {
        let view = UIImageView(image: .diagbg)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var figlineView:AIDPointterView = {
        let view = AIDPointterView()
        return view
    }()
    
    lazy var progressLabel:AIDCountingLabel = {
        let label = AIDCountingLabel(frame: .init(x: 0, y: 0, width: self.view.width, height: 40))
        label.font = AIDFont.boldFont(32)
        label.textColor = aid_FF5D61
        label.text = "10% AI"
        label.textAlignment = .center
        return label
    }()
    lazy var textLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: self.view.width, height: 40))
        label.font = AIDFont.boldFont(16)
        label.textColor = aid_FFFFFF
        label.text = AIDString.localized("Text is likely Human-written")
        label.textAlignment = .center
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(.button, for: .normal)
        button.setTitle(AIDString.localized("Humanize Now"), for: .normal)
        button.titleLabel?.font = AIDFont.boldFont(16)
        button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(AIDString.localized(" " + "Share"), for: .normal)
        button.setImage(.init(named: "text_de_share"), for: .normal)
        button.titleLabel?.font = AIDFont.boldFont(14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = aid_181818
        button.layer.cornerRadius = 12
        button.frame = .init(x: 0, y: 15, width: self.view.width-32, height: 44)
        button.addTarget(self, action: #selector(shareClick), for: .touchUpInside)
        return button
    }()
    
    lazy var headerView:UIView = {
        let view  = UIView()
        
        return view
    }()
    
    lazy var imageResultView:AIDImagResultView = {
        let view = AIDImagResultView(frame: .init(x: 0, y: 0, width: self.view.width-32, height: 293/343 * (self.view.width-32)))
        
        return view
    }()
    
    lazy var textDectionTipsView:AIDDetectionTipsView = {
        let view = AIDDetectionTipsView(frame: .init(x: 0, y: 0, width: self.view.width-32, height: 98))
        
        return view
    }()
    lazy var blurEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.layer.cornerRadius = 12
        blurEffectView.layer.masksToBounds = true
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(upgradePro)))
        blurEffectView.contentView.addSubview(upgradeLabel)
        return blurEffectView
    }()
    
    lazy var upgradeLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: self.view.width-32, height: 120))
        label.textColor = aid_FFFFFF
        label.font = AIDFont.boldFont(18)
        label.text = AIDString.localized("Upgrade to Premium")
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class AIDPointterView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(aid_FFFFFF.cgColor)
        context.setFillColor(aid_FFFFFF.cgColor)
        context.move(to: .init(x: width-11, y: height/2))
        context.addArc(center:  .init(x: width-11, y: height/2), radius: 11, startAngle: 0, endAngle: .pi*2, clockwise: false)
        context.fillPath()
        
        context.strokePath()
        
        context.move(to: .init(x: 0, y: height/2-2))
        context.addLine(to: .init(x: 0, y: height/2+2))
        context.addLine(to: .init(x: width-20, y: height/2+5))
        context.addLine(to: .init(x: width-20, y: height/2-5))
        
        context.addLine(to: .init(x: 0, y: height/2-2))
        context.fillPath()
        context.strokePath()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



