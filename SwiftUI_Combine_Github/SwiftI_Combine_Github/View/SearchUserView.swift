//
//  SearchUserView.swift
//  SwiftUI_Combine_Github
//
//  Created by Ian on 2021/12/04.
//

import SwiftUI

struct SearchUserView: View {

    // MARK: - Properties
    @ObservedObject var viewModel = SearchUserViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchUserBar(text: $viewModel.name, action: {
                    viewModel.search()
                })

                List(viewModel.users) { user in
                    SearchUserRow(viewModel: viewModel, user: user)
                        .onAppear(perform: { viewModel.fetchImage(for: user) })
                }
            }
            .navigationBarTitle(Text("Users"))
        }
    }
}
