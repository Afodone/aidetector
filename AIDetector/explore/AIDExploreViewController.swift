//
//  AIDExploreViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit

class AIDExploreViewController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(AIDString.localized("Explore"))
        self.showProButton()
        self.view.addSubview(aidTable)
        
        aidTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aidTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            aidTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            aidTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            aidTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Do any additional setup after loading the view.
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AIDExploreData.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AIDExploreCell else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        let data = AIDExploreData.datas[indexPath.row]
        
        cell.imgView.image = .init(named: data.icon)
        cell.label.text = AIDString.localized(data.title)
        cell.sublabel.text = AIDString.localized(data.subtitle)
        cell.lineView.isHidden = indexPath.row == 2
        
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = AIDExploreData.datas[indexPath.row]

        let ctr = AIDExploreInfoController()
        ctr.exploreData = data
        ctr.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctr, animated: true)
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
        table.register(AIDExploreCell.self, forCellReuseIdentifier: "cell")

        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        
        return table
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
