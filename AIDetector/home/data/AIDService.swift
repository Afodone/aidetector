//
//  AIDService.swift
//  AIDetector
//
//  Created by yong on 2025/7/27.
//

import Foundation
import SwiftyJSON

typealias AIDHumanResultBlock = (_ result:Result<(id:String,result:String),Error>) -> Void
typealias AIDHumanDetectionResultBlock = (_ result:Result<JSON,Error>) -> Void


//MARK: - Huamnization...
class AIDService{

    static let share = AIDService()
    
    static let apiKey = "d93bacd5-2488-4008-ac47-2242f1e235ba"
    
    var didUpdateResultBlock:AIDHumanResultBlock?
    
    var didUpdateTextDetectionResultBlock:AIDHumanDetectionResultBlock?
    
    var updateImageResultBlock:((JSON) -> Void)?
    var updateImageFailBlock:(() -> Void)?
    
    
    var presigned_url:String?
    
    var file_path:String?
        

    class func humanization(content:String,block:@escaping(_ result:String) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://humanize.undetectable.ai/submit"
        let headers = ["apikey": "\(apiKey)","Content-Type": "application/json"]
        
        let parameters = ["content":content,
                          "readability": "High School",
                          "purpose": "General Writing",
                          "strength": "More Human",
                          "model": "v11"] as [String : Any]
        
    
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 90.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data , let json = try? JSON(data: data) else {
                
                print("aid.human.request.fail")
                return}
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }

            let id = json["id"].stringValue
            print("aid.human.request.result.id: ",id,json["status"])

            block(id)
 
        })
        
        dataTask.resume()
    }
    
    class func humanRetrieve(id:String,block:@escaping(_ result:String) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://humanize.undetectable.ai/document"
        let headers = ["apikey": "\(apiKey)","Content-Type": "application/json"]
        
        let parameters = ["id":id] as [String : Any]
    
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 90.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data , let json = try? JSON(data: data) else {
                print("aid.human.request.fail")
                return}
            
           
         
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }
            
            if json["status"].stringValue == "done"{
                let output = json["output"].stringValue
                print("aid.human.request.result.id: ",output,json["status"])
                block(output)
            }else{
                failBlock(errorValue)
            }
 
        })
        
        dataTask.resume()
    }
    
    
    class func reHumanization(id:String,block:@escaping(_ result:String) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://humanize.undetectable.ai/rehumanize"
        let headers = ["apikey": "\(apiKey)","Content-Type": "application/json"]
        
        let parameters = ["id":id] as [String : Any]
    
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
                print("aid.human.request.fail")
                return}
            
           
         
            let errorValue = json["error"].stringValue
            guard errorValue.isEmpty else {
                print("aid.human.request.error: ",errorValue)
                failBlock(errorValue)
                return
            }
            
            if json["status"].stringValue == "Document submitted successfully"{
                let id = json["id"].stringValue
                print("aid.human.request.result.id: ",id,json["status"])
                block(id)
            }else{
                failBlock(errorValue)
            }
 
        })
        
        dataTask.resume()
    }
    
    
    
    
    

}

extension AIDService{
    
    func startRehumanization(id:String,resultBlock:@escaping AIDHumanResultBlock){
        
        self.didUpdateResultBlock = resultBlock
        
        AIDService.reHumanization(id: id) { resultID in
            self.delayToFetch(delay: 5, id: resultID)
        } failBlock: { errorMessage in
            let error = NSError(domain: "idError", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            
            DispatchQueue.main.async {
                self.didUpdateResultBlock?(.failure(error))
            }
        }
        
    }
    
    
    
    func startHumanization(content:String,resultBlock:@escaping AIDHumanResultBlock){
        
        self.didUpdateResultBlock = resultBlock
        
        AIDService.humanization(content: content) { resultID in
            self.delayToFetch(delay: 5, id: resultID)
        } failBlock: { errorMessage in
            let error = NSError(domain: "idError", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            
            DispatchQueue.main.async {
                self.didUpdateResultBlock?(.failure(error))
            }
        }
        
    }
    
    
    func delayToFetch(delay:TimeInterval,id:String){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: .init(block: {
            
            AIDService.humanRetrieve(id: id) { result in
                DispatchQueue.main.async {
                    self.didUpdateResultBlock?(.success((id,result)))
                }
            } failBlock: { errorMessage in
                
                self.delayToFetch(delay: 1, id: id)

            }
            
            
        }))
    
    }
    
    
    
}



//MARK: - Text detection
extension AIDService{
    
    class func detectionText(content:String,block:@escaping(_ result:JSON) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://ai-detect.undetectable.ai/detect"
        let headers = ["Content-Type": "application/json","accept": "application/json"]
        
        let parameters = ["text":content,
                          "key":apiKey,
                          "model": "xlm_ud_detector",
                          "retry_count": 0
                         ] as [String : Any]
        
    
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 90.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data
        
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

            let id = json["id"].stringValue
            print("aid.human.request.result.id: ",id,json["status"])

            block(json)
 
        })
        
        dataTask.resume()
    }
    
    class func detectionTextRetrieve(id:String,block:@escaping(_ result:JSON) -> Void,failBlock:@escaping(_ errorMessage:String) -> Void){

        let urlString = "https://ai-detect.undetectable.ai/query"
        let headers = ["Content-Type": "application/json","accept": "application/json"]
        
        let parameters = ["id":id] as [String : Any]
    
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                
        let request = NSMutableURLRequest(url: NSURL(string:urlString)! as URL,
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

            if json["status"].stringValue == "done"{
                let output = json["output"].stringValue
                print("aid.human.request.result.id: ",output,json["status"])
                block(json)
            }else{
                failBlock(errorValue)
            }
        })
        
        dataTask.resume()
    }

}
extension AIDService{
    
    func startDetectionText(content:String,resultBlock:@escaping AIDHumanDetectionResultBlock){
        
        self.didUpdateTextDetectionResultBlock = resultBlock
        AIDService.detectionText(content: content) { result in
            self.delayToFetchDetectionText(delay: 4, id: result["id"].stringValue)
        } failBlock: { errorMessage in
            DispatchQueue.main.async {
                let error = NSError(domain: "detectionError", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                self.didUpdateTextDetectionResultBlock?(.failure(error))
            }
        }
    }
    
    
    func delayToFetchDetectionText(delay:TimeInterval,id:String){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: .init(block: {
            AIDService.detectionTextRetrieve(id: id) { result in
                DispatchQueue.main.async {
                    self.didUpdateTextDetectionResultBlock?(.success(result))
                }
            } failBlock: { errorMessage in
                self.delayToFetchDetectionText(delay: 1, id: id)
            }
            
        }))
    
    }
    
    
    
}


