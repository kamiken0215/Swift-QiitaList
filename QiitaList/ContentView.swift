//
//  ContentView.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("ArticleView", destination: ArticleView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
