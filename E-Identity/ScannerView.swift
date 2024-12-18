//
//  ScannerView.swift
//  E-Identity
//
//  Created by Dimitris Kanellidis on 9/12/24.
//

import Foundation
import SwiftUI
struct ScannerView: UIViewControllerRepresentable {
    var onRecognizedText: (String) -> Void

    func makeUIViewController(context: Context) -> ScannerViewController {
        return ScannerViewController(onRecognizedText: onRecognizedText)
    }

    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
}
