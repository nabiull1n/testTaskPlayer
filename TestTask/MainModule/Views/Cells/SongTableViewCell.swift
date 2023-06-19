//
//  SongTableViewCell.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit.UITableViewCell

final class SongTableViewCell: UITableViewCell {
    
    static let identifer = "SongTableViewCell"
    
    private let songTitleLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let durationSongLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    // MARK: init UITableViewCell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewCell() {
        contentView.addSubview(songTitleLabel)
        contentView.addSubview(durationSongLabel)
        setConstraints()
    }
    
    func dataAssignment (performer: String, song: String, duration: String) {
        songTitleLabel.text = "\(performer) \(song)"
        durationSongLabel.text = duration
    }
}
// MARK: setConstraints
private extension SongTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            songTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            songTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            songTitleLabel.widthAnchor.constraint(equalToConstant: 300),
            songTitleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            durationSongLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            durationSongLabel.widthAnchor.constraint(equalToConstant: 40),
            durationSongLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}
