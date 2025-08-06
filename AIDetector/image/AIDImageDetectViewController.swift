//
//  AIDImageDetectViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import UIKit
import PhotosUI
import Kingfisher
class AIDImageDetectViewController: AIDParentViewController {

    let currentService = AIDService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(contentView)
        self.view.addSubview(sureButton)
        self.showBarbutton()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.frame =  .init(x: 10, y: self.view.safeAreaInsets.top + 10, width: self.view.width-20, height: 388/343 * (self.view.width-20))
        sureButton.frame = .init(x: 10, y: self.view.height-self.view.safeAreaInsets.bottom-10-52, width: self.view.width-20, height: 52)
    }
    
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func pasteButtonClick(){
        if let value = UIPasteboard.general.string{
            contentView.textFiledView.textFiled.text = value
            contentView.imgView.kf.setImage(with: URL(string: value)) { result in
                switch result {
                case .success(_):
                    self.contentView.hasImage = true
                    break
                case .failure( _):
                    break
                }
            }
        }
    }
    @objc func addImage(){
        self.showPhotoPicker()
    }
    @objc func deleteImage(){
        contentView.image = nil
    }
    
    @objc func sureButtonClick(){
        
        guard let image = self.contentView.imgView.image else {return}
        
        let loadingView = AIDBlurLoadingView()
        loadingView.message = AIDString.localized("Loading...")
        loadingView.show(in: self.view)
        
        
        
        currentService.startImageDetection(image: image, view: self.view) { json in
            loadingView.hide()
      
            
            let id = json["id"].stringValue
            let resultString = json.rawString() ?? ""
            let model  = AIDHumanData.init(id:id,result: resultString,type: 2)
            model.saveImage(image: image)
            AIDHumanDataFile.addHuman(data: model)
            
            
            let ctr = AIDTextDetectionResultController()
            ctr.currentData = model
            ctr.currentType = .image
            ctr.imageDetectionResult = json
            self.navigationController?.pushViewController(ctr, animated: true)
        }
        

    }
    func checkPaste(){
        if let _ = UIPasteboard.general.string{
            contentView.textFiledView.pasteButton.isEnabled = true
        }else{
            contentView.textFiledView.pasteButton.isEnabled = false
        }
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
        titelLabel.text = AIDString.localized("ImgDetect")
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backClick)))
        
        self.showProButton()
    }
    lazy var contentView:AIDDetectView = {
        
        let view = AIDDetectView(frame: .init(x: 10, y: 10, width: self.view.width, height: 388/343 * (self.view.width-20)))

        view.backgroundColor = aid_181818.withAlphaComponent(0.7)
        view.layer.cornerRadius = 12
        view.textFiledView.pasteButton.addTarget(self, action: #selector(pasteButtonClick), for: .touchUpInside)
        view.borderView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(addImage)))
        view.deleteButton.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        return view
    }()
    
    
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(.button, for: .normal)
        button.setTitle(AIDString.localized("Humanize Now"), for: .normal)
        button.titleLabel?.font = AIDFont.boldFont(16)
        
        button.setTitleColor(aid_FFFFFF, for: .normal)
        button.setTitleColor(aid_999999, for: .disabled)

        button.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        return button
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


extension AIDImageDetectViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func requestPhotoLibraryPermission(block:@escaping(_ ok:Bool) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized,.limited:
            block(true)
        case .denied, .restricted:
            block(false)

        case .notDetermined:

            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    block(newStatus == .authorized)
                }
            }


        @unknown default:
            break
        }
    }
    
    func showPhotoPicker(){
        requestPhotoLibraryPermission { flag in
            guard flag else {
                AIDTools.showPhotoAlert(from: self)
                return
            }
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage{
            self.contentView.image = image
        }
     
    }
    
}
