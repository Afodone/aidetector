//
//  AIDService+Image.swift
//  AIDetector
//
//  Created by yong on 2025/7/29.
//

import SwiftyJSON

extension AIDService{
    
     func imagePreurl(block:@escaping(_ result:JSON) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://ai-image-detect.undetectable.ai/get-presigned-url?file_name=example.jpeg"
         let headers = ["apikey":AIDService.apiKey,"accept":"application/json"]
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 30.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
           
            guard let data = data , let json = try? JSON(data: data) else {
                print("aid.human.request.fail")
                failBlock("")
                return}
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }

            print("aid.image.preURL ",json.rawString())
            
            AIDService.share.presigned_url = json["presigned_url"].stringValue
            AIDService.share.file_path = json["file_path"].stringValue
            
            AIDService.aid_preurl = json["presigned_url"].stringValue
            AIDService.aid_path = json["file_path"].stringValue

            block(json)
 
        })
        
        dataTask.resume()
    }
    
    
     func imageUpload(url: URL, image: UIImage, completion: @escaping (Result<Int, Error>) -> Void) {
  
       guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "error"])))
            return
        }
        
       print("image.size: ",imageData.count/1024,"kb")
  
       var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData,timeoutInterval: 90)
       request.httpMethod = "PUT"
       request.allHTTPHeaderFields = ["Content-Type":"image/jpeg",
                                      "x-amz-acl":"private"]

    
        let task = URLSession.shared.uploadTask(with: request, from: imageData) { data, response, error in
        
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "无效的响应"])))
                return
            }
            print("image.upload.code: ",httpResponse.statusCode)

            if httpResponse.statusCode == 200 {
                completion(.success(200))
            } else {
                completion(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: "没有返回数据"])))
            }
        }
        
        // 开始任务
        task.resume()
    }
    
     func imageDetection(filePath:String,block:@escaping(_ result:JSON) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){
        
        let urlString = "https://ai-image-detect.undetectable.ai/detect"
        let headers = ["Content-Type": "application/json","accept": "application/json"]
        
         let parameters = ["key":AIDService.apiKey,
                          "url": "https://ai-image-detector-prod.nyc3.digitaloceanspaces.com/\(filePath)",
                          "generate_preview":true] as [String : Any]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 20.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data , let json = try? JSON(data: data) else {
                failBlock("")
                print("aid.human.request.fail")
                return}
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }
            
            let id = json["id"].stringValue
            AIDService.aid_id = id
            block(json)
            
            print("aid.img: ",json.rawString())
            
            
        })
        
        dataTask.resume()
    }
    
     func imageQuery(id:String,block:@escaping(_ result:JSON) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){
        
        let urlString1 = "https://ai-image-detect.undetectable.ai/query"
        let headers = ["Content-Type": "application/json","accept": "application/json"]
        
        let parameters = ["id":id] as [String : Any]
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        
        let request = NSMutableURLRequest(url: NSURL(string:urlString1)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 90.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data , let json = try? JSON(data: data) else {
                failBlock("")
                print("aid.human.request.fail")
                return}
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }
            
            AIDService.aid_queryResult = json.rawString() ?? ""
            
            print("aid.img: ",json.rawString())
            
            block(json)
            
        })
        
        dataTask.resume()
    }
    
    
    
    class var aid_preurl:String{
        get{
            return UserDefaults.standard.value(forKey: "aid_preurl") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "aid_preurl")
            UserDefaults.standard.synchronize()
        }
    }
    class var aid_path:String{
        get{
            return UserDefaults.standard.value(forKey: "aid_path") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "aid_path")
            UserDefaults.standard.synchronize()
        }
    }
    class var aid_id:String{
        get{
            return UserDefaults.standard.value(forKey: "aid_id") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "aid_id")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var aid_queryResult:String{
        get{
            return UserDefaults.standard.value(forKey: "aid_queryResult") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "aid_queryResult")
            UserDefaults.standard.synchronize()
        }
    }
    
    

}


extension AIDService{
    
    func startImageDetection(image:UIImage,view:UIView){
        
        print("nil: ",self.updateImageResultBlock)
        
        imagePreurl { [weak self]result in
            self?.startImageUpload(image: image, view: view)
        } failBlock: { errorMessage in
            DispatchQueue.main.async {
                view.makeToast(errorMessage)
                self.updateImageFailBlock?()
            }
        }
    }
    
    func startImageUpload(image:UIImage,view:UIView){
        
        guard let value = AIDService.share.presigned_url,let preURL = URL(string: value) else {return}
        
        imageUpload(url: preURL, image: image) { res in
            switch res {
            case .success(_):
                let filePath = AIDService.share.file_path ?? ""
                self.imageDetection(filePath: filePath) { result in
                    let resultID = result["id"].stringValue
                    DispatchQueue.global().asyncAfter(deadline: .now()+4, execute: .init(block: {
                        self.imageDelayResult(duration: 1,id: resultID)

                    }))
                } failBlock: { errorMessage in
                    DispatchQueue.main.async {
                        view.makeToast(errorMessage)
                        self.updateImageFailBlock?()

                    }
                }
                
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    view.makeToast(error.localizedDescription)
                    self.updateImageFailBlock?()

                }
                break
            }
        }
        
    }
    
    func imageDelayResult(duration:TimeInterval,id:String){
        print("get.result.id: ",id)
        DispatchQueue.global().asyncAfter(deadline: .now()+duration, execute: .init(block: {
            self.imageQuery(id: id) { [weak self] result in
                if result["status"].stringValue == "done"{
                    DispatchQueue.main.async {
                        self?.updateImageResultBlock?(result)
                    }
                }else{
                    self?.imageDelayResult(duration: 1, id: id)
                }
            } failBlock: { errorMessage in
                self.updateImageFailBlock?()

            }
        }))
        
    }
    

}


extension AIDService{
    
  
    class func check(){

        let urlString = "https://ai-image-detect.undetectable.ai/check-user-credits"
        let headers = ["apikey": "\(apiKey)","Content-Type": "application/json","accept": "application/json"]
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 30.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data , let json = try? JSON(data: data) else {
                
                print("aid.human.request.fail")
                return}
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                
                print("aid.human.request.error: ",errorValue)
                return
            }

            print("aid.human.request.result.id: ",json.rawValue)

 
        })
        
        dataTask.resume()
    }
}



