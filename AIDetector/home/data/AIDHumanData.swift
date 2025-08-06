//
//  AIDHumanData.swift
//  AIDetector
//
//  Created by yong on 2025/7/27.
//

import Foundation
import UIKit
import SwiftyJSON
struct AIDHumanData:Codable{
    
    var contenet:String = ""
    var id:String = ""
    var result:String = ""
    var type:Int = 0 //0 text; 1 dection;
    var date:Date = Date()
    
    var dateString:String{
        let time = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)

        if  Calendar.current.isDateInToday(date){
            return "Today, " + time
        }
        if Calendar.current.isDateInYesterday(date){
            return "Yesterday, " + time
        }
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
    }
    
    static func convertToModel(jsonString:String) -> AIDHumanData{
        do {
            if let data = jsonString.data(using: .utf8){
                let model = try JSONDecoder().decode(AIDHumanData.self, from: data)
                return model
            }
        } catch {
            print("Error decoding: \(error)")
        }
        return AIDHumanData()
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
    
    
    func saveImage(image:UIImage){
        let path = NSHomeDirectory() + "/Documents/\(id).jpeg"
        FileManager.default.createFile(atPath: path, contents: image.jpegData(compressionQuality: 0.9))
    }
    
    
    
    func getImage() -> UIImage?{
        let path = NSHomeDirectory() + "/Documents/\(id).jpeg"
        return  UIImage(contentsOfFile: path) ?? .deImageDef
    }
    
    
    func detectionValue() -> Int{
        if let data = result.data(using: .utf8){
            let json = JSON(data)
            return json["result"].intValue
        }
        return 0
    }
    
    
    static let exampleString = "Weather Alert – July 8, 2025\nA rare summer storm struck Southern California this morning, bringing heavy rain, thunder, and strong winds. Over 2 inches of rain fell in downtown L.A., setting a new July record. Lightning and brief power outages were reported in several areas.\nThe storm is expected to weaken by evening, but light showers may continue. Residents are advised to stay indoors and avoid flooded roads."
    
    
    static let exampleDat:AIDHumanData = .init(contenet: exampleString,id: "",result: AIDTextDetectionData.exampleJson ,type: 1)
    

}


class AIDHumanDataFile{
    
    static let allDataKey = "aid_all_human_data"
    
    static func getAllHuman() -> [String]{
        if let list = UserDefaults.standard.value(forKey: allDataKey) as? [String]{
            return list
        }
        return []
    }
    
    static func addHuman(data:AIDHumanData){
        var all = getAllHuman()
        all.insert(data.toJsonString(), at: 0)
        UserDefaults.standard.set(all, forKey: allDataKey)
        UserDefaults.standard.synchronize()
    }
    
    
    
    static func resetData(model:AIDHumanData){
        UserDefaults.standard.set([model.toJsonString()], forKey: allDataKey)
        UserDefaults.standard.synchronize()
    }
    
    
    
}
