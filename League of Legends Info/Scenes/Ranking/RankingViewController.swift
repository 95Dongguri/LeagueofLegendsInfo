//
//  RankingViewController.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RankingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let listView = RankingListView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        let rankingResult = SearchRankingNetwork().searchRanking()
            .asObservable()
            .share()
        
        let rankingValue = rankingResult
            .compactMap { data -> Ranking? in
                guard case .success(let value) = data else { return nil }
                
                return value
            }
        
        let rankingError = rankingResult
            .compactMap { data -> String? in
                guard case .failure(let error) = data else { return nil }
                
                return error.localizedDescription
            }
        
        let cellData = rankingValue
            .map { ranking -> [RankingListCellData] in
                return ranking.entries
                    .map { entry in
                        RankingListCellData(
                            summonerName: entry.summonerName,
                            leaguePoints: entry.leaguePoints,
                            wins: entry.wins,
                            losses: entry.losses
                        )
                    }
                    .sorted { $0.leaguePoints > $1.leaguePoints }
            }
            .bind(to: listView.cellData)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "소환사 랭킹"
        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(listView)
        
        listView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
