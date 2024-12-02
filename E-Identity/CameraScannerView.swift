import AVFoundation
import Vision
import UIKit

protocol CameraScannerViewControllerDelegate: AnyObject {
    func didRecognizeText(_ text: String)
}
class CameraScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: CameraScannerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Cannot access camera: \(error)")
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add video input")
            return
        }

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            print("Could not add video output")
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            for observation in observations {
                if let recognizedText = observation.topCandidates(1).first?.string {
                    DispatchQueue.main.async {
                        self.handleRecognizedText(recognizedText)
                    }
                }
            }
        }

        request.recognitionLanguages = ["el", "en"]
        request.recognitionLevel = .accurate

        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error performing text recognition: \(error)")
        }
    }
    
    func handleRecognizedText(_ text: String) {
        let namePattern = "ΟΝΟΜΑ\\s*:\\s*(\\w+)"
        let surnamePattern = "ΕΠΩΝΥΜΟ\\s*:\\s*(\\w+)"
        let licenseNumberPattern = "ΑΡΙΘΜΟΣ\\s*:\\s*(\\d+)"
        
        let name = matchRegex(pattern: namePattern, in: text)
        let surname = matchRegex(pattern: surnamePattern, in: text)
        let licenseNumber = matchRegex(pattern: licenseNumberPattern, in: text)

        print("Name: \(name ?? "Not Found")")
        print("Surname: \(surname ?? "Not Found")")
        print("License Number: \(licenseNumber ?? "Not Found")")
    }

    func matchRegex(pattern: String, in text: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let match = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        if let range = match?.range(at: 1), let swiftRange = Range(range, in: text) {
            return String(text[swiftRange])
        }
        return nil
    }
    
    func stopSession() {
        captureSession.stopRunning()
        captureSession = nil
    }
    
}
