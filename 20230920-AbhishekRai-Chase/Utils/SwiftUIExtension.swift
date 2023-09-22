//
//  SwiftUIExtension.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 22/09/23.
//

import Foundation
import SwiftUI

extension View {
    func titleModifier() -> some View {
        modifier(TextModifier())
    }
}
