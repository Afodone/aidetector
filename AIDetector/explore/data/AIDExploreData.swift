//
//  AIDExploreData.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import Foundation

struct AIDExploreData{
    
    let title:String
    let subtitle:String
    let icon:String
    let datas:[AIDExploreContentData]
    
    static let datas:[AIDExploreData] = [.init(title: "Fake IDs", subtitle: "Spoofed identity documents are used to bypass identity verification.", icon: "explore_01",datas: data1),
                                         .init(title: "Fake Photo Evidence", subtitle: "Altered photos for false claims or reports.", icon: "explore_02",datas: data2),
                                         .init(title: "Deepfake Images", subtitle: "Synthetic media represents someone in altered or fabricated situations.", icon: "explore_03",datas: data3)]

    static let data1:[AIDExploreContentData] = [
        .init(title: "Fake IDs Elevated by AI: Identity Verification Faces New Threats", content: "", type: .boldTitle),
        .init(title: "Spoofed identity documents have long been used to bypass age restrictions, commit financial fraud, or facilitate illegal immigration. However, the explosive growth of artificial intelligence technology has elevated the realism and accessibility of fake IDs to unprecedented levels.", content: "", type: .content),
        .init(title: "How AI Empowers Fake ID Production?", type: .boldTitle),
        .init(title: "Photo Generation: ", content: "GANs (Generative Adversarial Networks) synthesize non-existent yet photorealistic facial images to bypass biometric detection",type: .dotTitleContent),
        .init(title: "Information Manipulation: ", content: "NLP models automatically generate logically consistent false personal data (names/addresses/education backgrounds)",type: .dotTitleContent),
        .init(title: "Document Forgery: ", content: "Image-generating AI (e.g., diffusion models) accurately replicate security features (holograms, UV patterns)",type: .dotTitleContent),
        .init(title: "Voice Cloning: ", content: "Voiceprint synthesis technology mimics ID holders' speech to deceive phone verification",type: .dotTitleContent),
        .init(title: "Traditional Defenses Are Failing", type: .boldTitle),
        .init(title: "According to the 2023 Global Financial Crime Compliance Survey:", type: .content),
        .init(title: "67% of institutions reported over 200% YoY growth in AI-forged documents",content: "200%", type: .dotContent),
        .init(title: "Traditional OCR systems showed 41% false-negative rates against deepfake IDs", content: "41%", type: .dotContent),
        .init(title: "Cases of 3D masks bypassing static biometrics (e.g., facial recognition) increased 500%", content: "500%", type: .dotContent)
    ]
    
    
    
    
    
    
    
    
    static let data2:[AIDExploreContentData] = [
        .init(title: "Fake Photo Evidence: Altered Photos for False Claims or Reports", type: .boldTitle),
        .init(title: "With the rapid advancement of artificial intelligence, the barrier to creating fake photos has dropped to an unprecedented level. Today, AI tools can generate photorealistic images in seconds—from staged accident scenes and fabricated medical records to manufactured celebrity scandals and \"evidence.\" These deceptive images are being weaponized for insurance fraud, public opinion manipulation, judicial perjury, and other illegal activities, severely undermining societal trust.", type: .content),
        .init(title: "The Expanding Chain of Harm", type: .boldTitle),
        .init(title: "Insurance Fraud: ", content: "Fabricated photos of car crashes or property damage to claim high compensation;",type: .dotTitleContent),
        .init(title: "Fake News: ", content: "Spliced images of politicians to incite social division;",type: .dotTitleContent),
        .init(title: "Judicial Perjury: ", content: "Altered timestamps/locations to create false alibis;",type: .dotTitleContent),
        .init(title: "Emotional Blackmail: ", content: "Synthetic intimate images for extortion.",type: .dotTitleContent),
        .init(title: "Conclusion", type: .boldTitle),
        .init(title: "Technology itself is neutral; human intent defines its impact. To combat the flood of fake photos, we must fortify technical defenses while rebuilding consensus on the value of truth. Only through legal deterrence, platform accountability, and public vigilance can we protect the integrity of reality.", type: .content)
        
    ]
    
    
    
    
    
    static let data3:[AIDExploreContentData] = [
        .init(title: "Deepfake Images: The Double-Edged Sword of Synthetic Media", type: .boldTitle),
        .init(title: "With the rapid advancement of AI, deepfake technology has evolved from a niche tool to a widespread threat. By leveraging algorithms like generative adversarial networks (GANs), it can fabricate hyper-realistic images and videos, seamlessly grafting anyone's face onto another's body or altering their speech and actions. While initially used for entertainment (e.g., movie dubbing or virtual influencers), its misuse now permeates multiple domains:",content: "deepfake technology", type: .content),
        .init(title: "Fraud & Blackmail: ", content: "Scammers create fake nude images or compromising videos for extortion.",type: .dotTitleContent),
        .init(title: "Political Sabotage: ", content: "Fabricated speeches of leaders incite social unrest or manipulate elections.",type: .dotTitleContent),
        .init(title: "Erosion of Trust: ", content: "Authentic evidence is dismissed as \"deepfakes,\" undermining social credibility.",type: .dotTitleContent),
        .init(title: "The Hidden Cost", type: .boldTitle),
        .init(title: "Victims face irreversible reputational damage, while society grapples with \"reality collapse.\" Current laws and detection tech lag behind; many countries lack specialized deepfake legislation, and AI-generated content remains difficult to trace.", type: .content),
        .init(title: "As AI democratizes, combating deepfakes requires global collaboration. Only through tech innovation, legal rigor, and media literacy can we defend the boundary between truth and illusion.", type: .content)
        
    ]
    
    
    
}

enum AIDExploreDataType{
    case boldTitle
    case content
    case dotTitleContent
    case dotContent
    
}

struct AIDExploreContentData{
    let title:String
    var content:String = ""
    let type:AIDExploreDataType
}


