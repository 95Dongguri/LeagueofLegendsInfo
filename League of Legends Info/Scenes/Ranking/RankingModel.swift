//
//  RankingModel.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import RxSwift

struct RankingModel {
    let network = SearchRankingNetwork()
    
    func searchRanking() -> Single<Result<Ranking, SearchError>> {
        return network.searchRanking()
    }
    
    func getRankingValue(_ result: Result<Ranking, SearchError>) -> Ranking? {
        guard case .success(let value) = result else { return nil }
        
        return value
    }
    
    func getRankingError(_ result: Result<Ranking, SearchError>) -> String? {
        guard case .failure(let error) = result else { return nil }
        
        return error.message
    }
    
    func getRankingListCellData(_ value: Ranking?) -> [RankingListCellData] {
        guard let value = value else { return [] }
        
        return value.entries
            .map {
                return RankingListCellData(
                    summonerName: $0.summonerName,
                    leaguePoints: $0.leaguePoints,
                    wins: $0.wins,
                    losses: $0.losses
                )
            }
            .sorted { $0.leaguePoints > $1.leaguePoints }
    }
}
