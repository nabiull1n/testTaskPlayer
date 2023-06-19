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
    // MARK: loadView
    override func loadView() {
        super.loadView()
        view = playerView
    }
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.assignValues()
        presenter?.validateTrack()
    }
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePlayerView()
        startTimer()
    }
    // MARK: viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    private func updatePlayerView() {
        let formattedTime = updateFormattedTimeLabel(playerManager.player.currentTime)
        playerView.songDurationSlider.maximumValue = Float(playerManager.player.duration)
        playerView.songDurationSlider.value = Float(playerManager.player.currentTime)
        playerView.currentTimeLabel.text = formattedTime
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
    
    private func updateSongInformation(_ result: Song) {
        playerView.songTitleLabel.text = result.songTitle
        playerView.performerLabel.text = result.performer
        playerView.songDurationLabel.text = result.duration
    }
    
    private func updatePlayButtonImage(_ result: String) {
        playerView.playButton.setImage(UIImage(systemName: "\(result)"), for: .normal)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let formattedTime = self.updateFormattedTimeLabel(self.playerManager.player.currentTime)
                self.playerView.songDurationSlider.maximumValue = Float(self.playerManager.player.duration)
                self.playerView.songDurationSlider.value = Float(self.playerManager.player.currentTime)
                self.playerView.currentTimeLabel.text = formattedTime
            }
            
            if round(self.playerManager.player.currentTime) == round(self.playerManager.player.duration - 1) {
                self.presenter?.forwardButtonPressed(completion: { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.updateSongInformation(result)
                        self.updatePlayButtonImage("pause")
                    }
                })
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateFormattedTimeLabel(_ time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        return formattedTime
    }
}

extension MusicPlayerViewController: MusicPlayerViewProtocol {
    func assignValues(_ data: Song) {
        playerView.songTitleLabel.text = data.songTitle
        playerView.performerLabel.text = data.performer
        playerView.songDurationLabel.text = data.duration
    }
}

extension MusicPlayerViewController: PlayerControlsViewDelegate {
    func playerDidTapPlayPauseButton(_ playerControlsView: MusicPlayerView) {
        presenter?.playPauseButtonPressed(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updatePlayButtonImage(result)
            }
        })
    }
    
    func playerDidTapForwardButton(_ playerControlsView: MusicPlayerView) {
        presenter?.forwardButtonPressed(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateSongInformation(result)
                self.updatePlayButtonImage("pause")
            }
        })
    }
    
    func playerDidTapBackwardButton(_ playerControlsView: MusicPlayerView) {
        presenter?.backButtonPressed(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateSongInformation(result)
                self.updatePlayButtonImage("pause")
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
