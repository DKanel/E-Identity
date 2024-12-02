//
//  CameraHelper.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/12/24.
//

import Foundation
import UIKit
import Vision
import AVFoundation
import NaturalLanguage
class CameraHelper{
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//
//        let request = VNRecognizeTextRequest { (request, error) in
//            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
//
//            for observation in observations {
//                if let recognizedText = observation.topCandidates(1).first?.string {
//                    DispatchQueue.main.async {
//                        self.handleRecognizedText(recognizedText)
//                    }
//                }
//            }
//        }
//
//        request.recognitionLanguages = ["el", "en"]
//        request.recognitionLevel = .accurate
//
//        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
//        do {
//            try requestHandler.perform([request])
//        } catch {
//            print("Error performing text recognition: \(error)")
//        }
//    }
    
    
}
