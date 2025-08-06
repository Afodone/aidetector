//
//  BlurLoadingView.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//


import UIKit

class AIDBlurLoadingView: UIView {

    private let blurEffectView: UIVisualEffectView
    private let activityIndicator: UIActivityIndicatorView
    private let messageLabel: UILabel
    
    var message: String = AIDString.localized("Loading...") {
        didSet {
            messageLabel.text = message
        }
    }
    
    
    override init(frame: CGRect) {

        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.color = aid_FFFFFF
        
        messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.textColor = aid_FFFFFF
        messageLabel.font = AIDFont.boldFont(20)
        messageLabel.numberOfLines = 0
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageLabel)
        

        NSLayoutConstraint.activate([

            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -40),
            
  
            activityIndicator.topAnchor.constraint(equalTo: containerView.topAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            

            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    

    
    func show(in view: UIView, animated: Bool = true) {
        frame = view.bounds
        view.addSubview(self)
        
        if animated {
            alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
                completion?()
            }
        } else {
            removeFromSuperview()
            completion?()
        }
    }
}
