//
//  ContentView.swift
//  KeyboardLanguage
//
//  Created by Krzysztof Czura on 29/12/2023.
//

import Foundation
import UIKit
import SwiftUI

class SpecificLanguageTextField: UITextField {
    
    var language: String? {
        didSet {
            if self.isFirstResponder{
                self.resignFirstResponder();
                self.becomeFirstResponder();
            }
        }
    }
    
    override var textInputMode: UITextInputMode? {
        if let language = self.language {
            for inputMode in UITextInputMode.activeInputModes {
                if let inputModeLanguage = inputMode.primaryLanguage, inputModeLanguage == language {
                    return inputMode
                }
            }
        }
        return super.textInputMode
    }
    
}

struct SpecificLanguageTextFieldView: UIViewRepresentable {

    let placeHolder: String
    var language: String = "en-US"
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField{
        let textField = SpecificLanguageTextField(frame: .zero)
        textField.placeholder = self.placeHolder
        textField.text = self.text
        textField.language = self.language
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
    }

}

import SwiftUI

struct ContentView: View {
    @State var englishText: String = ""
    @State var deutscherText: String = ""
    @State var polskiTekst: String = ""
    var body: some View {
        SpecificLanguageTextFieldView(placeHolder: "English", language: "en-GB", text: $englishText)
        SpecificLanguageTextFieldView(placeHolder: "deutsch", language: "de-DE", text: $deutscherText)
        SpecificLanguageTextFieldView(placeHolder: "polski", language: "pl-PL", text: $polskiTekst)
    }
}

#Preview {
    ContentView()
}
