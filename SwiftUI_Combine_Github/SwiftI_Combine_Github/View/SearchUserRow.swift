//
//  SearchUserRow.swift
//  SwiftUI_Combine_Github
//
//  Created by Ian on 2021/12/04.
//

import SwiftUI

struct SearchUserRow: View {

    // MARK: - Properties
    @ObservedObject var viewModel: SearchUserViewModel
    @State var user: User

    var body: some View {

        HStack {
            viewModel.userImages[user]
                .map { image in
                    Image(uiImage: image)
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.black, lineWidth: 1))
                }

            Text(user.login)
                .font(.system(size: 10).bold())

            Spacer()
        }
        .frame(height: 60)
    }
}
