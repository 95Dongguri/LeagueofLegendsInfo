//
//  RankingViewModel.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import RxSwift
import RxCocoa

struct RankingViewModel {
    let disposeBag = DisposeBag()
    
    let rankingListViewModel = RankingListViewModel()
    
    init(_ model: RankingModel = RankingModel()) {
        let rankingResult = model.searchRanking()
            .asObservable()
            .share()
        
        let rankingValue = rankingResult
            .map(model.getRankingValue)
            .filter { $0 != nil }
        
        let rankingErorr = rankingResult
            .map(model.getRankingError)
            .filter { $0 != nil }
        
        let cellData = rankingValue
            .map(model.getRankingListCellData)
        
        cellData
            .bind(to: rankingListViewModel.rankingListCellData)
            .disposed(by: disposeBag)
    }
}
