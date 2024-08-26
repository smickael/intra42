//
//  Tabs.swift
//  intra42
//
//  Created by Mickaël on 03/04/2024.
//

import SwiftUI

struct Tabs: View {
    let options: [String]
    let optionsContents: [AnyView]
    @Namespace var underline
    @State private var selectedOption: Int = 0 // Default to the first option
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(options.indices, id: \.self) { index in
                    let option = options[index]
                    VStack {
                        Button {
                            withAnimation {
                                selectedOption = index
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(option)
                                    .foregroundColor(selectedOption == index ? .primary : .secondary)
                            }
                        }
                        
                        ZStack {
                            Rectangle().fill(Color.primary)
                                .frame(height: 1)
                                .opacity(0)
                            
                            if selectedOption == index {
                                Rectangle().fill(Color.primary)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "option\(index)", in: underline)
                            }
                        }
                    }
                }
            }
            optionsContents[selectedOption]
        }
    }
}

#Preview {
    Tabs(options: ["Tab 1", "Tab 2", "Tab 3"],
                     optionsContents: [
                        AnyView(Text("Content of Tab 1")),
                        AnyView(Text("Content of Tab 2")),
                        AnyView(Text("Content of Tab 3"))
                     ])
}
