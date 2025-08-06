//
//  TextRecognizer.swift
//  AIDetector
//
//  Created by yong on 2025/8/2.
//


import UIKit
import Vision

class AIDTextRecognizer {
    // 识别完成回调
    typealias RecognitionHandler = (Result<[String], Error>) -> Void
    
    // 单例模式
    static let shared = AIDTextRecognizer()
    private init() {}
    
    // 识别图片中的文本
    func recognizeText(in image: UIImage, completion: @escaping RecognitionHandler) {
        guard let cgImage = image.cgImage else {
            completion(.failure(TextRecognitionError.invalidImage))
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.processRecognitionResults(from: request, completion: completion)
        }
        
        // 设置识别参数（可选）
        request.recognitionLevel = .accurate // 或 .fast
        request.usesLanguageCorrection = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // 处理识别结果
    private func processRecognitionResults(from request: VNRequest, completion: @escaping RecognitionHandler) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            completion(.success([]))
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            // 获取置信度最高的候选文本
            return observation.topCandidates(1).first?.string
        }
        
        DispatchQueue.main.async {
            completion(.success(recognizedStrings))
        }
    }
    
    // 错误类型
    enum TextRecognitionError: Error {
        case invalidImage
        case noTextFound
    }
}
