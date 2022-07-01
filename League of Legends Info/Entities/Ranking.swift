//
//  Ranking.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import Foundation

struct Ranking: Decodable {
    let entries: [Entries]
}

struct Entries: Decodable {
    let summonerName: String
    let leaguePoints: Int
    let wins: Int
    let losses: Int
}
