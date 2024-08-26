//
//  FontPicker.swift
//
//
//  Created by Victor on 26/08/2024.
//

import Environment
import SwiftUI


public struct FontPicker: UIViewControllerRepresentable {
    
    // MARK: Environment
    
    @Environment(\.dismiss) var dismiss
    
    
    // MARK: Coordinator
    
    public class Coordinator: NSObject, UIFontPickerViewControllerDelegate {
        private let dismiss: DismissAction
        
        public init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }
        
        public func fontPickerViewControllerDidCancel(_: UIFontPickerViewController) {
            dismiss()
        }
        
        public func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            Theme.shared.chosenFont = UIFont(descriptor: viewController.selectedFontDescriptor!, size: 0)
            
            dismiss()
        }
    }
    
    
    // MARK: Lifecycle
    
    public init() {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }
    
    public func makeUIViewController(context: Context) -> UIFontPickerViewController {
        let controller = UIFontPickerViewController()
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    public func updateUIViewController(_: UIFontPickerViewController, context _: Context) {}
}

