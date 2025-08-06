//
//  JWTools.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//


import UIKit
import MessageUI
import StoreKit
import DeviceKit

class AIDTools:NSObject,MFMailComposeViewControllerDelegate{
    
    static let share = AIDTools()
    
    func sendEmail(to recipients: [String],subject: String,body: String,in viewController: UIViewController) {
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            mailComposer.setToRecipients(recipients)
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(body, isHTML: false)
            
            
            let message = self.getAppInfoMessage()
            mailComposer.setMessageBody(message, isHTML: false)
            
            viewController.present(mailComposer, animated: true, completion: nil)
        } else {
            showEmailErrorAlert(in: viewController)
      
        }
    }
    
    func getAppInfoMessage() -> String{
        let dic:NSDictionary = Bundle.main.infoDictionary! as NSDictionary
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Jawline"
        let appv:String = dic.value(forKey: "CFBundleShortVersionString") as! String
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
        let device = UIDevice.current.localizedModel
        let verson:String = UIDevice.current.systemVersion
        var country:String = ""
        
        if #available(iOS 16, *) {
            country = Locale.current.region?.identifier ?? ""
        } else {
            country = Locale.current.regionCode ?? ""
            // Fallback on earlier versions
        }
        
        let deviceName = Device.current
        print("设备名称: \(device.description)")  // 例如: "iPhone 12 Pro"
        
        var language = Locale.current.languageCode ?? ""
        if #available(iOS 16, *) {
            language = Locale.current.language.languageCode?.identifier ?? ""
        } else {
            // Fallback on earlier versions
        }
        
        // 检查具体
        let message = "App Name: \(appName)\nApp Version: \(appv)\nBuild Version: \(buildNumber)\nDevice: \(device)\niOS: \(verson)\niPhone Type: \(deviceName)\nLanguage: \(language)\nCountry: \(country)\n"
        
        return message
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("cancel")
        case .saved:
            print("save")
        case .sent:
            print("send")
        case .failed:
            print("failed: \(error?.localizedDescription ?? "error.nil")")
        @unknown default:
            print("unknown result")
        }
    }
    
    private func showEmailErrorAlert(in viewController: UIViewController) {
        let alert = UIAlertController(title: "Email note",
                                      message: "No email account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
    
    
    
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
        let alert = UIAlertController.init(title: "App Would Like to Access Your Photo Library", message: "We need access to your photo library to upload the photo for ai face analyzer.", preferredStyle: .alert)
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
        let alert = UIAlertController.init(title: "App Would Like to Access the Camera", message: "We need access to your camera to capture photos for ai face analyzer.", preferredStyle: .alert)
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
