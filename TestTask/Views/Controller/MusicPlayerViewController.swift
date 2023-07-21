//
//  MusicPlayerViewController.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit

final class MusicPlayerViewController: UIViewController {
    
    var presenter: MusicPlayerViewPresenterProtocol?
    
    private let playerManager = PlayerManager.shared
    private let playerView = MusicPlayerView()
    private var timer: Timer?
    
    private var songInfo: Song? {
        didSet {
            if let songInfo = songInfo {
                playerView.updateSongInformation(songInfo)
            }
        }
    }
    
    private var updatePlayButtonImage: String? {
        didSet {
            if let updatePlayButtonImage = updatePlayButtonImage {
                playerView.updatePlayButtonImage(updatePlayButtonImage)
            }
        }
    }
    // MARK: - loadView
    override func loadView() {
        super.loadView()
        view = playerView
    }
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.assignValues()
        presenter?.validateTrack()
    }
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePlayerView()
        startTimer()
    }
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    private func updatePlayerView() {
        let player = playerManager.player
        let currentTime = player.currentTime
        let formattedTime = currentTime.formattedTimeString()
        
        playerView.update(Float(player.duration),
                          currentTime: Float(currentTime),
                          formattedTime: formattedTime)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        playerView.delegate = self
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let currentTime = self.playerManager.player.currentTime
            let duration = self.playerManager.player.duration
            
            DispatchQueue.main.async {
                let formattedTime = currentTime.formattedTimeString()
                self.playerView.update(Float(duration),
                                       currentTime: Float(currentTime),
                                       formattedTime: formattedTime)
            }
            
            let isEndOfSong = round(currentTime) == round(duration - 1)
            if isEndOfSong {
                self.presenter?.changeTrack(forward: true, completion: { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.songInfo = result
                        self.updatePlayButtonImage = "pause"
                    }
                })
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension MusicPlayerViewController: MusicPlayerViewProtocol {
    func assignValues(_ data: Song) {
        songInfo = data
    }
}

extension MusicPlayerViewController: PlayerControlsViewDelegate {
    func playerDidTapPlayPauseButton(_ playerControlsView: MusicPlayerView) {
        presenter?.playPauseButtonPressed(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updatePlayButtonImage = result
            }
        })
    }
    
    func playerDidTapForwardButton(_ playerControlsView: MusicPlayerView) {
        presenter?.changeTrack(forward: true, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.songInfo = result
                self.updatePlayButtonImage = "pause"
            }
        })
    }
    
    func playerDidTapBackwardButton(_ playerControlsView: MusicPlayerView) {
        presenter?.changeTrack(forward: false, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.songInfo = result
                self.updatePlayButtonImage = "pause"
            }
        })
    }
    
    func playerDidTapCloseButton(_ playerControlsView: MusicPlayerView) {
        dismiss(animated: true, completion: nil)
    }
    
    func playerSliderMoved(_ playControlsView: MusicPlayerView, didSlideSlider value: Float) {
        playerManager.player.currentTime = TimeInterval(value)
        playerManager.player.play()
    }
}
