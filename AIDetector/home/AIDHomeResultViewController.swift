//
//  AIDHomeResultViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/27.
//


import UIKit

class AIDHomeResultViewController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {

    var humanData:AIDHumanData = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBarbutton()

        bgView.isHidden = true
        self.view.addSubview(aidTable)
        aidTable.tableFooterView = footerView
        topView.textView.text = humanData.result
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aidTable.frame = .init(x: 0, y: self.view.safeAreaInsets.top, width: self.view.width, height: self.view.height-self.view.safeAreaInsets.top)
        
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
        titelLabel.text = AIDString.localized("Humanized Result")
        
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backClick)))
        
    }
    
    @objc func backClick(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    
 
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if indexPath.row == 0{
            cell.contentView.addSubview(self.topView)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        if indexPath.row == 0{
            return self.topView.frame.maxY
        }
        
        return 90
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

        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        return table
    }()
    
    lazy var topView:AIDResultView = {
        let view = AIDResultView(frame: .init(x: 10, y: 20, width: self.view.width-20, height: self.view.height*0.6))
        view.bottomView.didChooseBlock = {type in
            if type == .copy{
                self.copyResult()
            }else if type == .share{
                self.share()
            }else if type == .regenerate{
                self.regenerate()
            }
        }
        return view
    }()
    
    lazy var footerView:AIDResultFooterView = {
        let view = AIDResultFooterView(frame: .init(x: 0, y: 0, width: self.view.width, height: 150))
        view.didChooseBlock = { type in
            AIDTools.showRate()
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


extension AIDHomeResultViewController{
    
    func copyResult(){
        UIPasteboard.general.string = self.humanData.result
        self.view.makeToast(AIDString.localized("Copited"))
    }
    
    func share(){
        let result = humanData.result
        let act = UIActivityViewController.init(activityItems: [result], applicationActivities: nil)
        self.present(act, animated: true)
    }
    
    func regenerate(){
        
        let loadingView = AIDBlurLoadingView()
        loadingView.message = AIDString.localized("Loading...")
        loadingView.show(in: view)
        
        let content = self.humanData.contenet
        let id = self.humanData.id
        
        AIDService.share.startRehumanization(id: id) { result in
            loadingView.hide()
            
            switch result{
                
            case .success(let result):
                
                let model = AIDHumanData.init(contenet: content,id: result.id,result: result.result)
                AIDHumanDataFile.addHuman(data: model)
                self.humanData = model
                self.topView.textView.text = model.result
                
                break
                
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
                break
            }
        }
    }
    
}
