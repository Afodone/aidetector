//
//  AIDSettingViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit

class AIDSettingViewController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(AIDString.localized("Settings"))
        self.view.addSubview(aidTable)
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aidTable.frame = .init(x: 12, y: self.view.safeAreaInsets.top, width: view.width-24, height: view.height-self.view.safeAreaInsets.top)
    }
    
    
    
    @objc func enterForeground(){
       
        aidTable.reloadData()
    }
    @objc func notifyValueChanged(sender:UISwitch){
        AIDTools.requestNotificationAuthorization { flag in
            
            if flag{
                AIDTools.shouldReminder = sender.isOn
            }else{
                sender.isOn = false
                AIDTools.showRemonderAlert(from: self)
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        
        cell.backgroundColor = aid_181818.withAlphaComponent(0.7)
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = aid_FFFFFF
        cell.textLabel?.font = AIDFont.font(14)
        if indexPath.section == 0 {
            cell.textLabel?.text = AIDString.localized("Notifications")
            cell.imageView?.image = .init(named: "Bell")
            let switchOn = UISwitch()
            cell.accessoryView = switchOn
            switchOn.addTarget(self, action: #selector(notifyValueChanged), for: .valueChanged)

            switchOn.onTintColor = aid_9843B5
            
        }else{
            
            cell.accessoryView = UIImageView.init(image: .settingCellArrow)
            switch indexPath.row {

            case 0:
                cell.textLabel?.text = AIDString.localized("Rate us")
                cell.imageView?.image = .init(named: "Magic Stick")
                break
            case 1:
                cell.textLabel?.text = AIDString.localized("Share with friends")
                cell.imageView?.image = .init(named: "setting_share")
                break
            case 2:
                cell.textLabel?.text = AIDString.localized("Terms of use")
                cell.imageView?.image = .init(named: "File Text")
                break
            case 3:
                cell.textLabel?.text = AIDString.localized("Privacy policy")
                cell.imageView?.image = .init(named: "setting_polacy")
                break
            default:
                break
            }
         
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let lable = UILabel.init(frame: .init(x: 12, y: 10, width: 300, height: 60))
        lable.font = AIDFont.boldFont(16)
        lable.textColor = aid_FFFFFF
        view.addSubview(lable)
        if section == 1{
            lable.text = AIDString.localized("About")
        }else{
            lable.text = AIDString.localized("General")
        }
        
        return view
    }
    
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          cell.layer.mask = nil

          if indexPath.section == 0{
              let shapeLayer = CAShapeLayer()
              let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                            byRoundingCorners: [.allCorners],
                                            cornerRadii: CGSize(width: 16,height: 16))
              shapeLayer.path = bezierPath.cgPath
              cell.layer.mask = shapeLayer
          }else{
              if indexPath.row == 0{
                  let shapeLayer = CAShapeLayer()
                  let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                                byRoundingCorners: [.topLeft,.topRight],
                                                cornerRadii: CGSize(width: 16,height: 16))
                  shapeLayer.path = bezierPath.cgPath
                  cell.layer.mask = shapeLayer
              }else if indexPath.row == 3{
                  let shapeLayer = CAShapeLayer()
                  let bezierPath = UIBezierPath(roundedRect: cell.bounds,
                                                byRoundingCorners: [.bottomLeft,.bottomRight],
                                                cornerRadii: CGSize(width: 16,height: 16))
                  shapeLayer.path = bezierPath.cgPath
                  cell.layer.mask = shapeLayer
              }else{
                  cell.layer.mask = nil
              }
          }
         
          

      }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                if let url = URL(string: aid_rateUrl){
                    UIApplication.shared.open(url)
                }
                break
            case 1:
              
                if let url = URL(string: aid_shareUrl){
                    let act = UIActivityViewController.init(activityItems: [url], applicationActivities: nil)
                    self.present(act, animated: true)
                }
                break
            case 2:
                if let url = URL(string: aid_termUrl){
                    UIApplication.shared.open(url)
                }
                break
            case 3:
                if let url = URL(string: aid_policayUrl){
                    UIApplication.shared.open(url)
                }
                break
            default:
                break
            }
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(AIDTitleCell.self, forCellReuseIdentifier: "tcell")

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
