//
//  NoCitySelectedView.swift
//  NooroTakeHome
//
//  Created by Peyton Shetler on 12/31/24.
//

import SwiftUI

struct NoCitySelectedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("No City Selected")
                .font(.system(size: 30, weight: .bold, design: .default))
            Text("Please Search For A City")
                .font(.system(size: 15, weight: .bold, design: .default))
        }
    }
}

#Preview {
    NoCitySelectedView()
}
