//
//  AIDConstant.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit


let aid_guidComplete = "aid_guide_complete"


let aid_9CA3AF = aidHexColor("#9CA3AF")
let aid_8B5CEF:UIColor = aidHexColor("#8B5CEF")
let aid_000000:UIColor = aidHexColor("#000000")
let aid_FFFFFF:UIColor = aidHexColor("#FFFFFF")
let aid_FE76F5:UIColor = aidHexColor("#FE76F5")
let aid_999999:UIColor = aidHexColor("#999999")
let aid_181818:UIColor = aidHexColor("#181818")
let aid_9843B5:UIColor = aidHexColor("#9843B5")
let aid_C9C9C9:UIColor = aidHexColor("#C9C9C9")

let aid_292929:UIColor = aidHexColor("#292929")
let aid_6F6F6F:UIColor = aidHexColor("#6F6F6F")
let aid_1A1A1A:UIColor = aidHexColor("#1A1A1A")
let aid_FF5D61:UIColor = aidHexColor("#FF5D61")
let aid_363636:UIColor = aidHexColor("#363636")

/*
 包名 com.content.detector
 App ID 6749672669
 Contact 邮箱 yarakalma@yeah.net
 隐私条款 https://www.freeprivacypolicy.com/live/5b90c1f8-c567-4663-a97b-da7f543e2716
 使用条款 https://www.freeprivacypolicy.com/live/fe09ef82-b7ed-4dc5-9dac-79169a904732
 */
let aid_rateUrl = "itms-apps://itunes.apple.com/app/id\(6749672669)?action=write-review"
let aid_termUrl = "https://www.freeprivacypolicy.com/live/fe09ef82-b7ed-4dc5-9dac-79169a904732"
let aid_shareUrl = "itms-apps://itunes.apple.com/app/id\(6749672669)?action=write-review"
let aid_policayUrl = "https://www.freeprivacypolicy.com/live/5b90c1f8-c567-4663-a97b-da7f543e2716"
let aid_contactEmail = "yarakalma@yeah.net"


func aidHexColor(_ hexString:String) -> UIColor{
    var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    formattedString = formattedString.replacingOccurrences(of: "#", with: "")
    
    guard let hexValue = UInt64(formattedString, radix: 16) else {
        return .black
    }
    
    let red, green, blue: CGFloat
    
    switch formattedString.count {
    case 3: // RGB (12-bit)
        red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
        green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
        blue = CGFloat(hexValue & 0x00F) / 15.0
    case 6: // RRGGBB (24-bit)
        red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        blue = CGFloat(hexValue & 0x0000FF) / 255.0
    case 8: // RRGGBBAA (32-bit)
        red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
    default:
        return .black
    }
    
    return .init(red: red, green: green, blue: blue, alpha: 1)
}
