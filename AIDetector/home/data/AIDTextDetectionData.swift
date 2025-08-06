//
//  AIDTextDetectionData.swift
//  AIDetector
//
//  Created by yong on 2025/7/28.
//

import Foundation
import SwiftyJSON

struct AIDTextDetectionData{
    var name:String
    var progress:Int
    
    static let datas:[AIDTextDetectionData] = [.init(name: "Al-generated", progress: 3),
                                               .init(name: "Al-generated & Al-refined", progress: 3),
                                               .init(name: "Human-written & Al-refined", progress: 3),
                                               .init(name: "Human-written", progress: 90)]
    
    static func decodingJson(_ json:JSON) -> [AIDTextDetectionData]{
        
        var list:[AIDTextDetectionData] = []
        
        if let dic = json["result_details"].dictionary{
            
            if let gptzero = dic["scoreGptZero"]?.intValue{
                list.append(.init(name: "GPT Zero", progress: gptzero))
            }
            if let openai = dic["scoreOpenAI"]?.intValue{
                list.append(.init(name: "Open AI", progress: openai))
            }
            if let writer = dic["scoreWriter"]?.intValue{
                list.append(.init(name: "writer", progress: writer))
            }
            if let crossplag = dic["scoreCrossPlag"]?.intValue{
                list.append(.init(name: "Cross Plag", progress: crossplag))
            }
            if let leaks = dic["scoreCopyLeaks"]?.intValue{
                list.append(.init(name: "Copy Leaks", progress: leaks))
                
            }
            if let sapling = dic["scoreSapling"]?.intValue {
                list.append(.init(name: "Sapling", progress: sapling))
            }
            if let atscale = dic["scoreContentAtScale"]?.intValue{
                list.append(.init(name: "Content At Scale", progress: atscale))
            }
            if let zerogpt = dic["scoreZeroGPT"]?.intValue{
                list.append(.init(name: "Zero GPT", progress: zerogpt))
            }
            
//            if let hum = dic["human"]?.intValue{
//                list.append(.init(name: "Human", progress: hum))
//            }
            
        }
        
        return list.sorted { a, b in
            a.progress > b.progress
        }
        
    }
    
    static func mainInfo(_ json:JSON) -> (result:Float,human:Int){
        var humman = 0
        if let dic = json["result_details"].dictionary{
            if let hum = dic["human"]?.intValue{
                humman = hum
            }
        }
        
        let result = json["result"].floatValue
        
        return (result,humman)
    }

    
    static let exampleJson = "{\n  \"status\" : \"done\",\n  \"model\" : \"xlm_ud_detector\",\n  \"result_categories\" : {\n    \"standard\" : 43,\n    \"free\" : 28,\n    \"advanced\" : 58\n  },\n  \"result\" : 98,\n  \"retry_count\" : 0,\n  \"id\" : \"bd82496c-53d7-48a4-9e5c-9999aa6f62db\",\n  \"result_details\" : {\n    \"scoreGptZero\" : 50,\n    \"scoreZeroGPT\" : 50,\n    \"scoreCrossPlag\" : 0,\n    \"scoreOpenAI\" : 0,\n    \"scoreSapling\" : 50,\n    \"scoreWriter\" : 0,\n    \"scoreCopyLeaks\" : 100,\n    \"scoreContentAtScale\" : 50,\n    \"human\" : 37.5\n  }\n}"
    
    
}


