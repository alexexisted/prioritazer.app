//
//  CheckboxUIStyle.swift
//  prioritizer
//
//  Created by Alexa G on 3/29/25.
//

import Foundation
import SwiftUI

struct CheckboxUIStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
