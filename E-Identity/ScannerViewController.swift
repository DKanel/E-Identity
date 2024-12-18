//
//  ScannerViewController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/12/24.
//

import Foundation
import UIKit
import AVFoundation
import Vision
class ScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var captureSession: AVCaptureSession?
    private var onRecognizedText: (String) -> Void
    private let textRequest = VNRecognizeTextRequest()
    private var lastScanTime: Date = Date.distantPast
    
    init(onRecognizedText: @escaping (String) -> Void) {
        self.onRecognizedText = onRecognizedText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        configureTextRecognition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }
    
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("No camera available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let session = AVCaptureSession()
            session.addInput(input)
            
            let output = AVCaptureVideoDataOutput()
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "CameraOutputQueue"))
            session.addOutput(output)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }
            captureSession = session
        } catch {
            print("Failed to set up camera: \(error)")
        }
    }
    
    private func configureTextRecognition() {
        textRequest.recognitionLanguages = ["en"] // English for Greek transliteration
        textRequest.usesLanguageCorrection = true
        textRequest.recognitionLevel = .accurate
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let now = Date()
        if now.timeIntervalSince(lastScanTime) < 3.0 {
            return
        }
        lastScanTime = now
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try requestHandler.perform([textRequest])
            processTextRecognitionResults()
        } catch {
            print("Error during text recognition: \(error)")
        }
    }
    
    private func processTextRecognitionResults() {
        guard let results = textRequest.results as? [VNRecognizedTextObservation] else { return }
        
        var fullText = ""
        for observation in results {
            if let topCandidate = observation.topCandidates(1).first {
                fullText += topCandidate.string + "\n"
            }
        }
        
        DispatchQueue.main.async {
            self.onRecognizedText(fullText)
            //            self.dismiss(animated: true, completion: nil)
        }
    }
}
