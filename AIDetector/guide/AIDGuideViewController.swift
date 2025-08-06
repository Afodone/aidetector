//
//  AIDGuideViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDGuideViewController: AIDParentViewController ,UIScrollViewDelegate{
   
    enum AIDType {
        case guide1
        case guide2
        case guide3
    }
    
    var currentType:AIDType = .guide1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.view.addSubview(sureButton)
        scrollView.addSubview(guideView1)
        scrollView.addSubview(guideView2)
        scrollView.addSubview(guideView3)
        self.view.addSubview(pageControl)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sureButton.frame = .init(x: 20, y: view.height-view.safeAreaInsets.bottom-62, width: self.view.width-40, height: 52)
        
        self.scrollView.frame = .init(x: 0, y: view.safeAreaInsets.top, width: view.width, height: sureButton.frame.minY - view.safeAreaInsets.top)
        
        guideView1.frame = .init(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        guideView2.frame = .init(x: guideView1.frame.maxX, y: 0, width: scrollView.width, height: scrollView.height)
        guideView3.frame = .init(x: guideView2.frame.maxX, y: 0, width: scrollView.width, height: scrollView.height)
        pageControl.frame = .init(x: 0, y: sureButton.frame.minY-60, width: self.view.width, height: 30)
        
    }
    
    @objc func sureButtonClick(){
    
        if currentType == .guide1{
            currentType = .guide2
            self.sureButton.setTitle(AIDString.localized("Continue"), for: .normal)
        }else if currentType == .guide2{
            currentType = .guide3
            self.sureButton.setTitle(AIDString.localized("Continue"), for: .normal)
        }else if currentType == .guide3{
            NotificationCenter.default.post(name: .init(aid_guidComplete), object: nil)
            AIDTools.showGuide = true
        }
        
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentOffset.x = self.currentType == .guide2 ? self.view.width : self.view.width*2
            self.refreshPageControl()
        }
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/self.view.width)
        
        if index == 0{
            currentType = .guide1
            self.sureButton.setTitle(AIDString.localized("Get Start"), for: .normal)

        }else if index == 1{
            currentType = .guide2
            self.sureButton.setTitle(AIDString.localized("Continue"), for: .normal)

        }else if index == 2{
            currentType = .guide3
            self.sureButton.setTitle(AIDString.localized("Continue"), for: .normal)
        }
        
        refreshPageControl()
        
    }
    
    func refreshPageControl(){
        let index = Int(scrollView.contentOffset.x/self.view.width)
        pageControl.preferredIndicatorImage = UIImage(named: "page_unselected")
        pageControl.setIndicatorImage(UIImage(named: "page_unselected"), forPage: 0)
        pageControl.setIndicatorImage(UIImage(named: "page_unselected"), forPage: 1)
        pageControl.setIndicatorImage(UIImage(named: "page_unselected"), forPage: 2)
        pageControl.setIndicatorImage(UIImage(named: "page_selected"), forPage: index)
        pageControl.currentPage = index
    }
    
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView(frame: .init(x: 0, y: 0, width: self.view.width, height: self.view.height))
        view.contentSize = .init(width: self.view.width*3, height: 300)
        view.isPagingEnabled = true
        view.delegate = self
        return view
    }()

    
    lazy var guideView1:AIDGuideView1 = {
        let view = AIDGuideView1(frame: .init(x: 0, y: 0, width: self.view.width, height: 200))
        view.layer.borderWidth = 0
        return view
    }()
    lazy var guideView2:AIDGuideView2 = {
        let view = AIDGuideView2(frame: .init(x: 0, y: 0, width: self.view.width, height: 200))
        view.layer.borderWidth = 0
        return view
    }()
    lazy var guideView3:AIDGuideView3 = {
        let view = AIDGuideView3(frame: .init(x: 0, y: 0, width: self.view.width, height: 200))
        view.layer.borderWidth = 0
        return view
    }()
    
    
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(.button, for: .normal)
        button.setTitle(AIDString.localized("Get Started"), for: .normal)
        button.titleLabel?.font = AIDFont.boldFont(16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var pageControl:UIPageControl = {
        let view = UIPageControl(frame: .init(x: 0, y: 0, width: view.width, height: 30))
        view.numberOfPages = 3
        view.preferredIndicatorImage = UIImage(named: "page_unselected")
        view.setIndicatorImage(UIImage(named: "page_selected"), forPage: 0)
//        view.setIndicatorImage(UIImage(named: "page_selected"), forPage: 1)
//        view.setIndicatorImage(UIImage(named: "page_selected"), forPage: 2)

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
