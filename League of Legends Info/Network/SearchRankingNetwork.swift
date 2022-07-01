//
//  SearchRankingNetwork.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import RxSwift
import RxCocoa

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

class SearchRankingNetwork {
    private let session: URLSession
    let api = SearchRankingAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchRanking() -> Single<Result<Ranking, SearchError>> {
        guard let url = api.searchRanking().url else { return .just(.failure(.invalidURL))}
        
        /*  Request Header
         
         {
         "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36",
         "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
         "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
         "Origin": "https://developer.riotgames.com",
         "X-Riot-Token": "RGAPI-10b489b1-51fb-4893-bd5d-a99ebce77f3c"
         }
         
         */
        
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.setValue("ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7", forHTTPHeaderField: "Accept-Language")
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Accept-Charset")
        request.setValue("https://developer.riotgames.com", forHTTPHeaderField: "Origin")
        request.setValue("RGAPI-10b489b1-51fb-4893-bd5d-a99ebce77f3c", forHTTPHeaderField: "X-Riot-Token")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let rankingData = try JSONDecoder().decode(Ranking.self, from: data)
                    return .success(rankingData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
