//
//  WeatherTableViewCell.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import SnapKit

internal let kWeatherTableViewCellReuseIdentifier = "WeatherTableViewCell"

class WeatherTableViewCell: UITableViewCell {
    
    private let kLabelsTopBottomMargin: CGFloat = 10
    private let kLabelsLeftRightMargin: CGFloat = 20
    
    // MARK: public class
    
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateContents(topText: String?, middleText: String?, bottomText: String?) {
        topLabel.text = topText
        middleLabel.text = middleText
        buttomLabel.text = bottomText
        updateComponentConstraint()
    }
    
    // MARK: private class
    
    private func initView() {
        addSubview(topLabel)
        addSubview(middleLabel)
        addSubview(buttomLabel)
        buildConstraints()
    }
    
    private func buildConstraints() {
        topLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
        }
        
        middleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
        }
        
        buttomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(middleLabel.snp.bottom).offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.bottom.equalToSuperview().offset(-kLabelsTopBottomMargin)
        }
    }
    
    private func updateComponentConstraint() {
        topLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
        }
        
        middleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
        }
        
        buttomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(middleLabel.snp.bottom).offset(kLabelsTopBottomMargin)
            make.left.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.right.equalToSuperview().offset(kLabelsLeftRightMargin)
            make.bottom.equalToSuperview().offset(-kLabelsTopBottomMargin)
        }
    }
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var buttomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    // MARK: Overridefromsuperclass
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        topLabel.text = nil
        middleLabel.text = nil
        buttomLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
