//
//  AIDToneData.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//

import Foundation


struct AIDToneData:Codable{
    
    var name:String = ""
    
    var content:String = ""
    
    var id:String = UUID.init().uuidString
    
    static func convertToModel(jsonString:String) -> AIDToneData{
        do {
            if let data = jsonString.data(using: .utf8){
                let model = try JSONDecoder().decode(AIDToneData.self, from: data)
                return model
            }
        } catch {
            print("Error decoding: \(error)")
        }
        return AIDToneData()
    }
    
    func toJsonString() -> String{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(self){
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString ?? ""
        }
        return ""
    }
    
}



class AIDToneDataFile{
    
    static let allToneDataKey = "aid_alltonedata_key"
    
    static func setInitData(){
        
        
        let t1 =  "Rewrite this to sound more human and casual, like a friend chatting"
        let t2 =  "Enhance this text to reflect polished, professional tone suitable for formal correspondence."
        let t3 =  "Make this text hilarious—like a robot trying too hard to be human. Bonus if I snort-laugh."
       
        if !UserDefaults.standard.bool(forKey: "aid_init"){
            
            let list:[AIDToneData] = [.init(name: "Casual",content: t1),
                                      .init(name: "Formal",content: t2),
                                      .init(name: "Funny",content: t3)]
            
            let values =  list.map { data in
                data.toJsonString()
            }
            
            UserDefaults.standard.set(values, forKey: allToneDataKey)
            UserDefaults.standard.synchronize()
        }else{
            UserDefaults.standard.setValue(true, forKey: "aid_init")
            UserDefaults.standard.synchronize()
        }
        
    }
    
    static func getAllTones() -> [String]{
        if let list = UserDefaults.standard.value(forKey: allToneDataKey) as? [String]{
            return list
        }
        return []
    }
    
    
    static func addTone(data:AIDToneData){
        var list = getAllTones()
        list.insert(data.toJsonString(), at: 0)
       // list.append(data.toJsonString())
        UserDefaults.standard.set(list, forKey: allToneDataKey)
        UserDefaults.standard.synchronize()
    }
    
    
    
    
}
