//
//  RankingListCell.swift
//  League of Legends Info
//
//  Created by 김동혁 on 2022/07/01.
//

import UIKit
import SnapKit

class RankingListCell: UITableViewCell {
    let summonerNameLabel = UILabel()
    let leaguePointsLabel = UILabel()
    let winsLabel = UILabel()
    let lossesLabel = UILabel()
    let winrateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        summonerNameLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        leaguePointsLabel.font = .systemFont(ofSize: 24.0, weight: .semibold)
        leaguePointsLabel.textColor = .gray
        
        winsLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        winsLabel.textColor = .systemBlue
        
        lossesLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        lossesLabel.textColor = .systemPink
        
        winrateLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        winrateLabel.textColor = .systemPink
        
        [summonerNameLabel, leaguePointsLabel, winsLabel, lossesLabel, winrateLabel].forEach {
            contentView.addSubview($0)
        }
        
        summonerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(32.0)
        }
        
        leaguePointsLabel.snp.makeConstraints {
            $0.top.equalTo(summonerNameLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        winsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32.0)
            $0.top.equalTo(summonerNameLabel.snp.bottom).offset(5.0)
        }
        
        lossesLabel.snp.makeConstraints {
            $0.leading.equalTo(winsLabel.snp.trailing).offset(32.0)
            $0.top.equalTo(winsLabel.snp.top)
        }
        
        winrateLabel.snp.makeConstraints {
            $0.top.equalTo(winsLabel.snp.top)
            $0.trailing.equalToSuperview().inset(48.0)
        }
    }
    
    func setData(_ data: RankingListCellData) {
        summonerNameLabel.text = data.summonerName
        leaguePointsLabel.text = "C1 \(data.leaguePoints) LP"
        winsLabel.text = "\(data.wins)W"
        lossesLabel.text = "\(data.losses)L"
        
        let rate = round(Double(data.wins) / Double((data.wins + data.losses)) * 100)
        let winrate = String(format: "%.f", rate)
        
        winrateLabel.text = winrate + "%"
    }
}
