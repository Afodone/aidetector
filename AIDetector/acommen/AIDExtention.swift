//
//  AIDExtention.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit
extension UIView{
    
    var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    
    var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    var xsize: CGSize{
        get{
            return self.frame.size
        }
        set{
            var r = self.frame
            r.size = newValue
            self.frame = r
        }
    }
    
    var centerX:CGFloat{
        get{
            center.x
        }set{
            var c = center
            c.x = newValue
            center = c
        }
    }
    
    var centerY:CGFloat{
        get{
            center.y
        }set{
            var c = center
            c.y = newValue
            center = c
        }
    }
    
    var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var r = self.frame
            r.origin = newValue
            self.frame = r
        }
    }
    

    
}





extension UITextView {
    
    private static let STATIC_kPlaceholderTag = 4000001
    
    var placeholder: String {
        set {
            if let var_lb = viewWithTag(UITextView.STATIC_kPlaceholderTag) as? UILabel {
                var_lb.text = newValue
            } else {
                let var_lb = UILabel()
                var_lb.tag = UITextView.STATIC_kPlaceholderTag
                var_lb.font = AIDFont.font(14)
                var_lb.numberOfLines = 0
                var_lb.textColor = aid_999999
                var_lb.text = newValue
                addSubview(var_lb)
                setValue(var_lb, forKey: "_placeholderLabel")
            }
        }
        get {
            let var_lb = value(forKey: "_placeholderLabel") as? UILabel
            return var_lb?.text ?? ""
        }
    }
}


extension UIButton {
    func addHighlightAnimation(highlightColor: UIColor = UIColor.white.withAlphaComponent(0.3)) {
        let overlayView = UIView()
        overlayView.backgroundColor = highlightColor
        overlayView.isUserInteractionEnabled = false
        overlayView.alpha = 0
        overlayView.tag = 999 // 用于后续查找
        
        addSubview(overlayView)
        overlayView.frame = bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    @objc private func touchDown() {
        guard let overlay = viewWithTag(999) else { return }
        UIView.animate(withDuration: 0.1) {
            overlay.alpha = 1
        }
    }
    
    @objc private func touchUp() {
        guard let overlay = viewWithTag(999) else { return }
        UIView.animate(withDuration: 0.1) {
            overlay.alpha = 0
        }
    }
}
extension UIButton {
    func addSpringAnimation(scale: CGFloat = 0.95) {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    @objc private func animateDown(sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    @objc private func animateUp(sender: UIButton) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            sender.transform = .identity
        }, completion: nil)
    }
}

extension UIButton {
    func addPulseAnimation() {
        addTarget(self, action: #selector(touchDown1), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp1), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    @objc private func touchDown1() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.alpha = 0.8
        }
    }
    
    @objc private func touchUp1() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1.0
        }
    }
}
