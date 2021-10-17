//
//  ArticleRowView.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import SwiftUI

struct ArticleRowView: View {
    
    @State private var isShowAlert: Bool = false
    
    let article: Article
    
    var body: some View {
        HStack {
            Group {
                Text(article.title)
                ZStack {
                    Button("") {
                        isShowAlert = true
                    }
                }
            }
        }.alert(isPresented: $isShowAlert) {
            Alert(
                title: Text(""),
                message: Text("launch safari?"),
                primaryButton: .default(
                    Text("OK"),
                    action: {
                        self.isShowAlert = false
                        guard let url = URL(string: article.url) else { return }
                        UIApplication.shared.open(url)
                    }
                ),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}
