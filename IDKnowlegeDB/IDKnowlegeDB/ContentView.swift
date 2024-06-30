//
//  ContentView.swift
//  IDKnowlegeDB
//
//  Created by Alexey on 28.06.2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world! Hahahah")
      Button(
        "KNOPKA",
        action: {
          let mle = MemoryLayoutExample()
          mle.compareStructures()
        }
      )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
