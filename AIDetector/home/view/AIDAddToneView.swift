//
//  AIDAddToneView.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//

import UIKit
import Toast_Swift
class AIDAddToneView:UIView,UITableViewDelegate,UITableViewDataSource{
    
    var clickBlock:(() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(addButton)
        addSubview(cancelButton)
        addSubview(aidTable)
        
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.topLeft,.topRight],
                                      cornerRadii: CGSize(width: 16,height: 16))
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = .init(x: 0, y: 0, width: width, height: 50)
        cancelButton.frame = .init(x: 20, y: 0, width: cancelButton.width, height: 50)
        addButton.frame = .init(x: width-addButton.width-20, y: 0, width: addButton.width, height: 50)
        aidTable.frame = .init(x: 0, y: titleLabel.frame.maxY, width: width, height: height-titleLabel.frame.maxY)
        
    }
    
    @objc func addClick(){
        
        guard let name = nameTextFiled.text else {
            
            return
        }
        
        guard let content = textView.text else {
            
            return
        }
        
        if name.isEmpty{
            self.makeToast(AIDString.localized("Tone name is empty"))
            return
        }
        
        if content.isEmpty{
            self.makeToast(AIDString.localized("Tone instructions is empty"))
            return
        }
        AIDToneDataFile.addTone(data: .init(name: name,content: content))
        
        clickBlock?()

    }
    @objc func cancelClick(){
        clickBlock?()
        
    }
    @objc func nameValueChanged(sender:UITextField){
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        if row == 0 || row == 2 || row == 4{
            return titleCell(indexPath: indexPath, tableView: tableView)
        }
        
        let id = row == 1 ? "namecell" : "textViewcell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id) else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if row == 1{
            cell.contentView.addSubview(nameTextFiled)
        }else if row == 3{
            cell.contentView.addSubview(textbackView)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 || row == 2 || row == 4{
            return 50
        }
        if row == 1{
            return 70
        }
        
        
        return self.textbackView.frame.maxY
    }
    
    
    lazy var aidTable:UITableView = {
        let table = UITableView(frame: self.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        table.register(UITableViewCell.self, forCellReuseIdentifier: "titlecell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "namecell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "textViewcell")
        
        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        return table
    }()
    
    lazy var addButton:UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        button.setTitle(AIDString.localized("Add"), for: .normal)
        button.setTitleColor(aid_999999, for: .normal)
        button.setTitleColor(aid_FFFFFF, for: .highlighted)
        
        button.titleLabel?.font = AIDFont.font(14)
        button.sizeToFit()
        
        return button
    }()
    lazy var cancelButton:UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        button.setTitle(AIDString.localized("Cancel"), for: .normal)
        button.setTitleColor(aid_999999, for: .normal)
        button.setTitleColor(aid_FFFFFF, for: .highlighted)
        
        button.titleLabel?.font = AIDFont.font(14)
        
        button.sizeToFit()
        return button
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: width, height: 40))
        label.font = AIDFont.boldFont(16)
        label.textColor = aid_FFFFFF
        label.text = AIDString.localized("Add Custom Tone")
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameTextFiled:UITextField = {
        let view = UITextField(frame: .init(x: 20, y: 0, width: width-40, height: 50))
        view.returnKeyType = .done
        view.addTarget(self, action: #selector(nameValueChanged), for: .editingChanged)
        view.attributedPlaceholder = .init(string: AIDString.localized("Enter tone name"), attributes: [.foregroundColor:aid_999999,.font:AIDFont.font(14)])
        view.layer.cornerRadius = 12
        view.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 50))
        view.leftViewMode = .always
        view.backgroundColor = aid_181818
        view.textColor = aid_FFFFFF
        
        return view
    }()
    
    lazy var textView:UITextView = {
        let view = UITextView(frame: .init(x: 10, y: 10, width: width-60, height:104))
        view.textColor = aid_FFFFFF
        view.font = AIDFont.font(14)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.placeholder = AIDString.localized("Example: Make the text sound more enthusiastic and energetic, using positive language and exclamation marks where appropriate")
        
        return view
    }()
    
    lazy var textbackView:UIView = {
        let view = UIView(frame: .init(x: 20, y: 0, width: width-40, height:124))
        view.backgroundColor = aid_181818
        view.layer.cornerRadius = 12
        view.addSubview(textView)
        view.isUserInteractionEnabled = true
        return view
        
    }()
    
}


extension AIDAddToneView{
    
    func titleCell(indexPath:IndexPath,tableView:UITableView) -> UITableViewCell{
        let row = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "titlecell") else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        if row == 0{
            cell.textLabel?.text = AIDString.localized("TONE NAME")
            cell.textLabel?.font = AIDFont.font(14)
            cell.textLabel?.textColor = aid_999999
            
        }else if row == 2{
            cell.textLabel?.text = AIDString.localized("TONE INSTRUCTIONS")
            cell.textLabel?.font = AIDFont.font(14)
            cell.textLabel?.textColor = aid_999999
            
        }else if row == 4{
            cell.textLabel?.text = AIDString.localized("These instructions will guide the Al how to modify the text")
            cell.textLabel?.font = AIDFont.font(12)
            cell.textLabel?.textColor = aid_6F6F6F
        }
        return cell
        
    }
}
