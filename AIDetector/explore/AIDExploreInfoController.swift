//
//  AIDExploreInfoController.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDExploreInfoController:AIDParentViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    var exploreData:AIDExploreData = AIDExploreData.datas[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        titelLabel.text = exploreData.title
        
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backClick)))
        
        self.showProButton()
        
        view.addSubview(aidTable)
        aidTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aidTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            aidTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            aidTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            aidTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

    }
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreData.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = exploreData.datas[indexPath.row]
    
        if data.type == .boldTitle{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AIDTitleCell else {return UITableViewCell()}
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none

            cell.label.text = AIDString.localized(data.title)
            return cell
        }
        if data.type == .content{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AIDContentCell.cellID) as? AIDContentCell else {return UITableViewCell()}
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none
            if data.content.isEmpty{
                cell.label.text = AIDString.localized(data.title)

            }else{
                let text = data.title
                let range = (text as NSString).range(of: data.content)
                let attr = NSMutableAttributedString.init(string: text)
                attr.addAttributes([.font:AIDFont.boldFont(14),.foregroundColor:aid_FFFFFF], range: range)
                cell.label.attributedText = attr
            }
            return cell
        }
        
        
        if data.type == .dotTitleContent{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "boldDotcell") as? AIDBoldDotCell else {return UITableViewCell()}
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none

            let t1 = AIDString.localized(data.title)
            let t2 = AIDString.localized(data.content)
            
            let text = t1 + t2
            
            let attr = NSMutableAttributedString.init(string: text)
            
            attr.addAttributes([.font:AIDFont.boldFont(14),.foregroundColor:aid_FFFFFF], range: .init(location: 0, length: t1.count))
            cell.label.attributedText = attr
            
            return cell
        }
        
        if data.type == .dotContent{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AIDNormalDotCell.cellID) as? AIDNormalDotCell else {return UITableViewCell()}
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none
   
            let text = data.title
            let range = (text as NSString).range(of: data.content)
            
            let attr = NSMutableAttributedString.init(string: text)
            
            attr.addAttributes([.font:AIDFont.boldFont(14),.foregroundColor:aid_FFFFFF], range: range)
            cell.label.attributedText = attr
            
            return cell
        }
        
   
     
        if data.type == .dotContent {
            
        }
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "boldDotcell") as? AIDBoldDotCell else {return UITableViewCell()}
//        cell.backgroundColor = .clear
//        cell.contentView.backgroundColor = .clear
//        cell.selectionStyle = .none

        
        return UITableViewCell()
       
    }
    
 
    
    
    
    lazy var aidTable:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 90

        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        table.register(AIDTitleCell.self, forCellReuseIdentifier: "cell")
        table.register(AIDBoldDotCell.self, forCellReuseIdentifier: "boldDotcell")
        table.register(AIDContentCell.self, forCellReuseIdentifier: AIDContentCell.cellID)
        table.register(AIDNormalDotCell.self, forCellReuseIdentifier: AIDNormalDotCell.cellID)

        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        
        
        
        return table
    }()
}
