//
//  PSGraybackgroundView.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//


import UIKit

class AIDbackgroundView:UIView{
    
    var clickBlcok:(() -> Void)?
    
    var contentView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        
        backgroundColor = .clear
        bgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
    }
    
    func showWith(view:UIView){
        contentView = view

        addSubview(view)
        bgView.alpha = 0
        let f = view.frame
        view.y = height
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            view.frame = f
            self.bgView.alpha = 1
        }completion: { finish in
            
        }
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.contentView?.y = self.height
            self.bgView.alpha = 0
        }completion: { finish in
            self.removeFromSuperview()
        }
    }
    
    @objc func click(){
        dismiss()
        clickBlcok?()
    }
    
    lazy var bgView:UIView = {
        let view = UIView(frame: bounds)
        view.backgroundColor = aid_000000.withAlphaComponent(0.6)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
