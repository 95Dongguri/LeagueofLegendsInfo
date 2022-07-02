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
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: RankingViewModel) {
        listView.bind(viewModel.rankingListViewModel)
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
