//
//  RankingListViewModel.swift
//  League of Legends Info
//
//  Created by κΉλν on 2022/07/02.
//

import RxSwift
import RxCocoa

struct RankingListViewModel {
    let rankingListCellData = PublishSubject<[RankingListCellData]>()
    let cellData: Driver<[RankingListCellData]>
    
    init() {
        self.cellData = rankingListCellData
            .asDriver(onErrorJustReturn: [])
    }
}
