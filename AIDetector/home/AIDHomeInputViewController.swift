//
//  AIDHomeInputViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//

import UIKit
import Toast_Swift
import MobileCoreServices
import UniformTypeIdentifiers
import PDFKit
import SwiftyJSON
import AVFoundation


class AIDHomeInputViewController: AIDParentViewController,UITableViewDelegate,UITableViewDataSource {
    
    enum AIDHomeType {
        
        case humanizaton
        case detaction
        
    }
    var currentType:AIDHomeType = .humanizaton
    
    let currentService = AIDService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBarbutton()
        
        bgView.isHidden = true
        self.view.addSubview(aidTable)
        self.view.addSubview(sureButton)
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sureButton.isEnabled = !topView.textView.text.isEmpty
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        aidTable.frame = .init(x: 0, y: self.view.safeAreaInsets.top, width: self.view.width, height: self.view.height-self.view.safeAreaInsets.top)
        
        sureButton.frame = .init(x: 20, y: self.view.height-self.view.safeAreaInsets.bottom-52-10, width: self.view.width-40, height: 52)
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
        titelLabel.text = AIDString.localized("Humanize")
        if currentType == .detaction{
            titelLabel.text = AIDString.localized("AI Detection")
        }
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backClick)))
        self.showProButton()
    }
    
    @objc func backClick(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func sureButtonClick(){
        
        let content = self.topView.textView.text ?? ""
        let loadingView = AIDBlurLoadingView()
        loadingView.message = AIDString.localized("Loading...")
        loadingView.show(in: view)
        
        if currentType == .detaction{
            currentService.startDetectionText(content: content) { result in
                loadingView.hide()
                switch result {
                case .success(let json):
                    let result = json.rawString() ?? ""
                    let model = AIDHumanData.init(contenet: content,id: "",result: result, type: 1)
                    AIDHumanDataFile.addHuman(data: model)
                                        
                    let ctr = AIDTextDetectionResultController()
                    ctr.currentData = model
                    let info = AIDTextDetectionData.mainInfo(json)
                    
                    ctr.datalist = [.init(name: "Al-generated", progress: Int(round(info.result/3.0))),
                                    .init(name: "Al-generated & Al-refined", progress: Int(round(info.result/3.0))),
                                    .init(name: "Human-written & Al-refined", progress: Int(round(info.result/4.0))),
                                    .init(name: "Human-written", progress: Int(info.human))]
                    
                    self.navigationController?.pushViewController(ctr, animated: true)
                    
                    break
                case .failure(let error):
                    self.view.makeToast(error.localizedDescription)
                    break
                }
            }
            
            return
        }
                
        currentService.startHumanization(content: content) { result in
            
            loadingView.hide()
            
            switch result{
                
            case .success(let result):
                
                var message =  content
                if let value = self.chooseView.currentTone{
                    message = value + "\n" + message
                }
                
                let model = AIDHumanData.init(contenet: message,id: result.id,result: result.result)
                AIDHumanDataFile.addHuman(data: model)
                
                DispatchQueue.main.async {
                    let ctr = AIDHomeResultViewController()
                    ctr.humanData = model
                    self.navigationController?.pushViewController(ctr, animated: true)
                }
                
                break
                
            case .failure(let error):
                self.view.makeToast(error.localizedDescription)
                break
            }
        }
        
    }
    
    
    func getOutput(data:AIDHumanData){
        AIDService.humanRetrieve(id: data.id) { result in
            let model = AIDHumanData.init(contenet: data.contenet,id: data.id,result: result)
            AIDHumanDataFile.addHuman(data: model)
            
            let ctr = AIDHomeResultViewController()
            ctr.humanData = model
            self.navigationController?.pushViewController(ctr, animated: true)
        } failBlock: { errorMessage in
            
        }
    }
    
    func showAddView(){
        
        let contentView = AIDAddToneView(frame: .init(x: 0, y: 0, width: self.view.width, height: self.view.height*0.7))
        contentView.backgroundColor = aidHexColor("#111111")
        
        let grayView = AIDbackgroundView(frame: UIScreen.main.bounds)
        self.view.addSubview(grayView)
        grayView.showWith(view: contentView)
        contentView.y = self.view.height - contentView.height
        
        contentView.clickBlock = {[weak self]in
            grayView.dismiss()
            self?.chooseView.reloadData()
        }
    }
    
    
    func upload(){
        openDocumentPicker()
    }
    
    func showCamera(){
        requestCameraPermission { grand in
            if grand{
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    
#if targetEnvironment(simulator)
        self.view.makeToast("Camera unavailable")
        return
#endif
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.allowsEditing = true
                    picker.delegate = self
                    self.present(picker, animated: true)
                }else{
                    self.view.makeToast(AIDString.localized("Camera not available"))
                }
            }else{
                AIDTools.showCameraAlert(from: self)
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if indexPath.row == 0{
            cell.contentView.addSubview(self.topView)
        }else{
            if currentType == .humanizaton{
                cell.contentView.addSubview(self.chooseView)
            }else{
                cell.contentView.addSubview(self.sampleView)

            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return self.topView.frame.maxY
        }
        
        if currentType == .detaction{
            return sampleView.frame.maxY
        }
        return chooseView.frame.maxY
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
    
    lazy var topView:AIDInputView = {
        let view = AIDInputView(frame: .init(x: 10, y: 20, width: self.view.width-20, height: self.view.height*0.4))
     
        view.textUpdateBlock = {[weak self]text in
            guard let self = self else {return}
            self.sureButton.isEnabled = !text.isEmpty
        }
        
        view.clickBlock = {type in
            if type == .ocr{
                self.showCamera()
            }else if type == .paste{
                if let text = UIPasteboard.general.string{
                    view.contentString = text
                    self.sureButton.isEnabled = !text.isEmpty
                }
            }else if type == .upload{
                self.upload()
            }
        }
        return view
    }()
    
    
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(.button, for: .normal)
        button.setBackgroundImage(.disbutton, for: .disabled)
        button.isEnabled = false
        button.setTitle(AIDString.localized("Humanize Now"), for: .normal)
        button.titleLabel?.font = AIDFont.boldFont(16)
        button.setTitleColor(aid_FFFFFF, for: .normal)
        button.setTitleColor(aid_999999, for: .disabled)

        button.addTarget(self, action: #selector(sureButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var chooseView:AIDChooseView = {
        let view = AIDChooseView(frame: .init(x: 10, y: 30, width: self.view.width-20, height: 90))
        view.chooseBlock = {
            self.showAddView()
        }
        return view
    }()
    
    lazy var sampleView:AIDTryASampleView = {
        let view = AIDTryASampleView(frame: .init(x: 10, y: 30, width: self.view.width-20, height: 200))
        view.applayBlock = { [weak self]text in
            self?.topView.textView.text = text
            self?.topView.updateTextCount()
            self?.sureButton.isEnabled = !text.isEmpty
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

extension AIDHomeInputViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
                        
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        @unknown default:
            completion(false)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        picker.dismiss(animated: true)
        self.view.makeToastActivity(.center)
        
    
        AIDTextRecognizer.shared.recognizeText(in: image) { result in
            self.view.hideToastActivity()
            switch result {
            case .success(let texts):
                print("识别到的文本: \(texts)")
                DispatchQueue.main.async {
                    self.topView.textView.text = texts.joined()
                }
            case .failure(let error):
                print("识别失败: \(error.localizedDescription)")
            }
        }
        
        
    }
}


extension AIDHomeInputViewController : UIDocumentPickerDelegate {
    
    func openDocumentPicker() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.text,.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 是否允许多选
        present(documentPicker, animated: true, completion: nil)
    }
    
    // MARK: - UIDocumentPickerDelegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        
        // 获取文件访问权限
        let shouldStopAccessing = selectedFileURL.startAccessingSecurityScopedResource()
        
        defer {
            if shouldStopAccessing {
                selectedFileURL.stopAccessingSecurityScopedResource()
            }
        }
        
        if selectedFileURL.pathExtension.lowercased() == "pdf" {
            if let text = extractTextFromPDF(at: selectedFileURL){
                print("提取的文本: \(text)")
                self.topView.contentString = text
                if text.isEmpty{
                    self.view.makeToast(AIDString.localized("No text detected"))
                }
                self.sureButton.isEnabled = !text.isEmpty
            }else{
                self.view.makeToast(AIDString.localized("No text detected"))
            }
        }else{
            do {
                // 读取文件内容
                let fileData = try Data(contentsOf: selectedFileURL)
                let text = String.init(data: fileData, encoding: .utf8)
                print("文件数据大小: \(fileData.count) 字节")
                self.topView.contentString = text
                self.sureButton.isEnabled = text?.count != 0

                // 处理文件...
            } catch {
                self.view.makeToast(AIDString.localized("No text detected"))

                print("读取文件失败: \(error)")
            }
        }
        
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("用户取消了文件选择")
        
    }
    
    

    func extractTextFromPDF(at url: URL) -> String? {
        guard let pdfDocument = PDFDocument(url: url) else { return nil }
        var fullText = ""
        for i in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: i) else { continue }
            guard let pageText = page.string,!pageText.isEmpty else { continue }
            fullText += pageText
        }
        return fullText.isEmpty ? nil : fullText
    }
    
    
  

    
}
