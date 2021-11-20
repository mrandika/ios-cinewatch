//
//  CastPresenter.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

import CWCommon
import CWMovieDetail

 public class CastPresenter: ObservableObject {
     private var cancellables: Set<AnyCancellable> = []
     private let castUseCase: CastUseCase

     @Published var casts: [CastModel] = []

     @Published var isLoading: Bool = false
     @Published var isError: Bool = false
     @Published var error: Error = EmptyError.empty

     public init(castUseCase: CastUseCase) {
         self.castUseCase = castUseCase
     }

     func fetchCasts(id: Int) {
         self.isLoading = true
         self.isError = false
         self.error = EmptyError.empty

         castUseCase.getCast(movieId: id)
             .receive(on: RunLoop.main)
             .sink(receiveCompletion: { completion in
                 switch completion {
                 case .failure(let error):
                     self.isError = true
                     self.isLoading = false
                     self.error = error
                 case .finished:
                     self.isLoading = false
                 }
             }, receiveValue: { casts in
                 self.casts = casts
             }).store(in: &cancellables)
    }
 }
