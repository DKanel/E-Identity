//
//  CameraScannerViewController.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 2/12/24.
//

import Foundation
import SwiftUI
struct CameraScannerView: UIViewControllerRepresentable {
    @Binding var scannedText: String // Binding to pass recognized text back to SwiftUI

    func makeUIViewController(context: Context) -> CameraScannerViewController {
        let scannerVC = CameraScannerViewController()
        scannerVC.delegate = context.coordinator // Set the coordinator as the delegate
        return scannerVC
    }

    func updateUIViewController(_ uiViewController: CameraScannerViewController, context: Context) {
        // No updates needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CameraScannerViewControllerDelegate {
        var parent: CameraScannerView

        init(_ parent: CameraScannerView) {
            self.parent = parent
        }

        func didRecognizeText(_ text: String) {
            DispatchQueue.main.async {
                self.parent.scannedText = text
            }
        }
    }
}
