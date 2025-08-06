//
//  AIDHomeViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit
import SwiftyJSON
class AIDHomeViewController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {
    
    var historyList:[AIDHumanData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitle(AIDString.localized("All features"))
        self.showProButton()
        
        let head = UIView(frame: .init(x: 0, y: 0, width: view.width, height: self.headView.frame.maxY+30))
        head.addSubview(headView)
        self.view.addSubview(aidTable)
        aidTable.tableHeaderView = head
        
        if !AIDTools.firstShowRate{
            AIDTools.firstShowRate = true
            AIDTools.showRate()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aidTable.frame = .init(x: 0, y: self.view.safeAreaInsets.top, width: self.view.width, height: self.view.height-self.view.safeAreaInsets.top-self.view.safeAreaInsets.bottom)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateData()

    }
    
    func updateData(){
        self.historyList = AIDHumanDataFile.getAllHuman().map({ json in
            AIDHumanData.convertToModel(jsonString: json)
        })
        aidTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return historyList.count
//            return historyList.isEmpty ? 1 : historyList.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1{
            
            if historyList.isEmpty{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AIDHistoryCell.exampleCellID) as? AIDHistoryCell else {return UITableViewCell()}
                cell.type = .example
                cell.label.text = AIDString.localized("Example")
                
                if let date = AIDTools.firstInstallDate{
                    cell.dateLabel.text = AIDHumanData(date:date).dateString
                }else{
                    cell.dateLabel.text = AIDHumanData().dateString
                    AIDTools.firstInstallDate = Date()
                }

                cell.sublabel.text = AIDString.localized("Weather Alert – July 8, 2025 \nA rare summer storm struck Southern California this morning, bringing heavy rain, thunder, and strong winds. Over 2 inches of rain fell in downtown L.A., setting a new July record. Lightning and brief power outages were reported in several areas.\nThe storm is expected to weaken by evening, but light showers may continue. Residents are advised to stay indoors and avoid flooded roads.")
                cell.progresslabel.text = "98%"
                return cell
            }else{
                let data = historyList[indexPath.row]
                let cellID = data.type == 2 ? AIDHistoryCell.imgCellID : AIDHistoryCell.textCellID
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? AIDHistoryCell else {return UITableViewCell()}
                cell.dateLabel.text = data.dateString
                if data.type == 2{
                    cell.type = .image
                    cell.deImgView.image = data.getImage()
                    cell.progresslabel.text = "\(data.detectionValue())%"
                }else if data.type == 1{
                    cell.type = .dection
                    cell.progresslabel.text = "\(data.detectionValue())%"
                    cell.label.text = data.contenet
                    cell.sublabel.text = ""//data.result
                }else{
                    cell.type = .humanization
                    cell.progresslabel.text = ""
                    cell.label.text = data.contenet
                    cell.sublabel.text = data.result
                }
                                
                return cell
            }
     
        }
        
        if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AIDHeaderCell else {return UITableViewCell()}
            
            cell.titleLabel.text = AIDString.localized("History")
          
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imgcell") as? AIDHomeImageCell else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 136 + 10
        }
        if indexPath.row == 1{
            return 70
        }
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if !self.historyList.isEmpty{
                let data = historyList[indexPath.row]
                if data.type == 0{
            
                    let ctr = AIDHomeResultViewController()
                    ctr.humanData = data
                
                    ctr.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(ctr, animated: true)
                    
                    print("content:\n",data.contenet)
                    print("-----result-------:\n",data.result)
                }else{
                    let ctr = AIDTextDetectionResultController()
                    if data.type == 1{
                        ctr.currentType = .text
                        let result = data.result.data(using: .utf8)
                        let json = JSON(result as Any)
                        
                        let info = AIDTextDetectionData.mainInfo(json)
                        
                        ctr.datalist = [.init(name: "Al-generated", progress: Int(round(info.result/3.0))),
                                        .init(name: "Al-generated & Al-refined", progress: Int(round(info.result/3.0))),
                                        .init(name: "Human-written & Al-refined", progress: Int(round(info.result/4.0))),
                                        .init(name: "Human-written", progress: Int(info.human))]
                                                
                    }else if data.type == 2{
                        ctr.currentType = .image
                        let result = data.result.data(using: .utf8)
                        let json = JSON(result as Any)
                        ctr.imageDetectionResult = json
                    }
                    ctr.currentData = data
                    ctr.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(ctr, animated: true)
                }
               
            }else{
                let ctr = AIDTextDetectionResultController()
                ctr.isExample = true
                ctr.currentType = .text
                ctr.currentData = AIDHumanData.exampleDat
                let result = AIDTextDetectionData.exampleJson.data(using: .utf8)
                let json = JSON(result as Any)
                
//                let info = AIDTextDetectionData.mainInfo(json)
                ctr.datalist = AIDTextDetectionData.datas
                ctr.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctr, animated: true)
            }
        }else {
            
            let ctr = AIDImageDetectViewController()
            ctr.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ctr, animated: true)
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
        table.register(AIDHomeImageCell.self, forCellReuseIdentifier: "imgcell")
        table.register(AIDHeaderCell.self, forCellReuseIdentifier: "cell")

        table.register(AIDHistoryCell.self, forCellReuseIdentifier: AIDHistoryCell.textCellID)
        table.register(AIDHistoryCell.self, forCellReuseIdentifier: AIDHistoryCell.imgCellID)
        table.register(AIDHistoryCell.self, forCellReuseIdentifier: AIDHistoryCell.exampleCellID)

        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        return table
    }()
    
    lazy var headView:AIDHomeHeaderView = {
        let view = AIDHomeHeaderView(frame: .init(x: 12, y: 10, width: self.view.width-24, height: (self.view.width-24)/2))
        view.chooseBlock = {type in
            let ctr = AIDHomeInputViewController()
            ctr.hidesBottomBarWhenPushed = true
            if type == .detection{
                ctr.currentType = .detaction
            }else{
                ctr.currentType = .humanizaton
            }
            self.navigationController?.pushViewController(ctr, animated: true)
        }
        return view
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
