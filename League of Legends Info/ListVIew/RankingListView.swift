//
//  RankingListView.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import UIKit
import RxSwift
import RxCocoa

class RankingListView: UITableView {
    let disposeBag = DisposeBag()
    
    let cellData = PublishSubject<[RankingListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "RankingListCell", for: index) as! RankingListCell
                cell.setData(data)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        backgroundColor = .white
        register(RankingListCell.self, forCellReuseIdentifier: "RankingListCell")
        separatorStyle = .singleLine
        rowHeight = 90.0
    }
}
