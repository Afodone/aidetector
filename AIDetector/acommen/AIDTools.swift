//
//  JWTools.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//


import UIKit
import StoreKit

class AIDTools:NSObject{
    
    static let share = AIDTools()
  
    
    @MainActor class func showRate(){
        
        for  scene in UIApplication.shared.connectedScenes {
            if scene.activationState == .foregroundActive || scene.activationState == .foregroundInactive {
                if let scene = scene as? UIWindowScene{
                    if #available(iOS 16.0, *) {
                        AppStore.requestReview(in: scene)
                    } else {
                        // Fallback on earlier versions
                        SKStoreReviewController.requestReview(in: scene)
                    }
                    
                    break
                }
                
                
            }
        }
        
        
    }
    
    
    class func showPhotoAlert(from:UIViewController){
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        let set = UIAlertAction(title: "Setting", style: .default) { action in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let alert = UIAlertController.init(title: "App Would Like to Access Your Photo Library", message: "We need access to your photo library to upload the photo for ai detector feature.", preferredStyle: .alert)
        alert.addAction(cancel)
        alert.addAction(set)
        from.present(alert, animated: true)
    }
    
    class func showCameraAlert(from:UIViewController){
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        let set = UIAlertAction(title: "Setting", style: .default) { action in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let alert = UIAlertController.init(title: "App Would Like to Access the Camera", message: "We need access to your camera to capture photos for using ai detector feature.", preferredStyle: .alert)
        alert.addAction(cancel)
        alert.addAction(set)
        from.present(alert, animated: true)
    }
    
    class var showGuide:Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "aid_show_guide")
            UserDefaults.standard.synchronize()
        }get{
            UserDefaults.standard.bool(forKey: "aid_show_guide")
        }
    }
    
    class var firstShowRate:Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "aid_firstShowRate")
            UserDefaults.standard.synchronize()
        }get{
            UserDefaults.standard.bool(forKey: "aid_firstShowRate")
        }
    }
    
    class var shouldReminder:Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "aid.remnder.on")
            UserDefaults.standard.synchronize()
        }get{
            return  UserDefaults.standard.bool(forKey: "aid.remnder.on")
        }
    }
    
    class var firstInstallDate:Date?{
        set{
            UserDefaults.standard.set(newValue, forKey: "aid.firstInstallDate")
            UserDefaults.standard.synchronize()
        }get{
            return  UserDefaults.standard.value(forKey: "aid.firstInstallDate") as? Date
        }
    }
}


extension AIDTools{
    
    class func requestNotificationAuthorization(completion: ((Bool) -> Void)? = nil) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            
            DispatchQueue.main.async {
                if let error = error {
                    print("通知权限请求错误: \(error.localizedDescription)")
                    completion?(false)
                    return
                }
                
                if granted {
                    print("通知权限已授予")
                    completion?(true)
                } else {
                    print("用户拒绝了通知权限")
                    completion?(false)
                }
            }
          
        }
    }
    
    class func showRemonderAlert(from:UIViewController){
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        let set = UIAlertAction(title: "Setting", style: .default) { action in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        let alert = UIAlertController.init(title: "App Would Like to Send You Notifications", message: "Notifications may include alerts,sounds,and icon badgets. These can be configured in Settings.", preferredStyle: .alert)
        alert.addAction(cancel)
        alert.addAction(set)
        from.present(alert, animated: true)
    }
    
}
