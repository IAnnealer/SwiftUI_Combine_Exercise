//
//  SearchUserBar.swift
//  SwiftUI_Combine_Github
//
//  Created by Ian on 2021/12/04.
//

import SwiftUI

struct SearchUserBar: View {

    // MARK: - Properties

    @Binding var text: String
    @State var action: () -> Void

    var body: some View {
        ZStack {
            Color.gray.opacity(0.6)
                .cornerRadius(15)
                .padding([.leading, .trailing], 4)

            HStack {
                TextField("Search User", text: $text)
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(8)

                Button(action: action,
                       label: { Text("Search") })
                    .font(.system(size: 10).bold())
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding([.leading, .trailing], 10)
        }
        .frame(height: 70)
    }
}
