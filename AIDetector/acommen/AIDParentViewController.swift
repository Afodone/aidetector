//
//  AIDParentViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit

class AIDParentViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = aidHexColor("#010101")
        self.view.addSubview(bgView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.frame = view.bounds
        
    }
    
    
    @objc func proClick(){
    
    }
    
    func setTitle(_ text:String){
        self.titelLabel.text = text
        self.navigationItem.leftBarButtonItem = .init(customView: self.titelLabel)
    }
    func showProButton(){
//        let pro = UIBarButtonItem(image: .proIcon.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(proClick))
//        self.navigationItem.rightBarButtonItem = pro
    }
    
    lazy var bgView:UIImageView = {
        let view = UIImageView(image: .bg)
        view.contentMode = .scaleAspectFill
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
        
    }()
    
    lazy var titelLabel:UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 40))
        label.font = AIDFont.boldFont(18)
        label.textColor = aid_FFFFFF
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
