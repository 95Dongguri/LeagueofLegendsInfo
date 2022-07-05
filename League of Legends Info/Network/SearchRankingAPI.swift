//
//  SearchRankingAPI.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/05.
//

import Foundation

struct SearchRankingAPI {
    // url: https://kr.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5
    
    static let scheme = "https"
    static let host = "kr.api.riotgames.com"
    static let path = "/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5"
    
    func searchRanking() -> URLComponents {
        var components = URLComponents()
        
        components.scheme = SearchRankingAPI.scheme
        components.host = SearchRankingAPI.host
        components.path = SearchRankingAPI.path
        
        return components
    }
}
