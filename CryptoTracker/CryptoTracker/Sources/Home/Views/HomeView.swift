//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/18.
//

import SwiftUI

struct HomeView: View {

    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                homeHeader
                Spacer(minLength: 0)
            }
        }
    }
}

private extension HomeView {
    var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(content: {
                    CircleButtonAnimationView(animate: $showPortfolio)
                })

            Spacer()

            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)

            Spacer()

            CircleButtonView(iconName: "chevron.right")
                .onTapGesture {
                    withAnimation(.none, {
                        showPortfolio.toggle()
                    })
                }
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
        }
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
    }
}
