//
//  SongsTableViewController.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit
import AVFoundation

protocol TableDelegate: AnyObject {
    func didSelectItem(withData data: Song, trackIndex: Int)
}

final class SongsTableViewController: UIViewController {
    
    var presenter: SongsTableViewPresenterProtocol?
    private var songsArray: [Song] = []
    weak var delegate: TableDelegate?
    
    private let songsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifer)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.configureSongs()
        PlayerManager.shared.setArray(songsArray)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(songsTableView)
        songsTableView.delegate = self
        songsTableView.dataSource = self
        setConstraints()
    }
}

extension SongsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = songsArray[indexPath.row]
        let trackIndex = indexPath.row
        let secondViewController = ModelBuilder.creatMusicPlayerView(songData: data, songIndex: trackIndex)
        present(secondViewController, animated: true, completion: nil)
    }
}

extension SongsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifer,
                                                       for: indexPath) as? SongTableViewCell else
                                                       { return UITableViewCell() }
        let song = songsArray[indexPath.row]
       
        cell.updateUI(song)
        
        return cell
    }
}

extension SongsTableViewController: SongsTableViewProtocol {
    func setSongs(_ songsArray: [Song]) {
        self.songsArray = songsArray
    }
}
// MARK: setConstraints
private extension SongsTableViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            songsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            songsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
