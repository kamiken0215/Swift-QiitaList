//
//  ArticleViewModel.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation
import Combine

class ArticleViewModel: ObservableObject {
    
    @Published var title: String = "Article View"
    @Published var tag: CurrentValueSubject = CurrentValueSubject<String, Never>("")
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    
    private var articleRequest = ArticleRequest()
    private var cancellables = Set<AnyCancellable>()
    
    func subscribeArticles() {
        
        tag.debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: {_ in
                if (!self.isLoading) {
                    self.searchArticles()
                }
            })
            .store(in: &cancellables)
    }
    
    func searchArticles() {
        isLoading = true
        articleRequest.search(tag: tag.value)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { response in
                self.articles = response
            })
            .store(in: &cancellables)
    }
    
    func fetchArticles() {
        isLoading = true
        articleRequest.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                    case .finished:
                        print("finished")
                        self.isLoading = false
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isLoading = false
                }
                
            }, receiveValue: { response in
                self.articles = response
            })
            .store(in: &cancellables)
    }
}
