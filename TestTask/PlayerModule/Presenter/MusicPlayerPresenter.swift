//
//  MusicPlayerPresenter.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import AVFoundation

protocol MusicPlayerViewProtocol: AnyObject {
    func assignValues(_ data: Song)
}

protocol MusicPlayerViewPresenterProtocol: AnyObject {
    init(view: MusicPlayerViewProtocol, songData: Song, songIndex: Int)
    
    func playPauseButtonPressed(completion: @escaping (String) -> Void)
    func forwardButtonPressed(completion: @escaping (Song) -> Void)
    func backButtonPressed(completion: @escaping (Song) -> Void)
    
    func validateTrack()
    func startTrackPlayback()
    func assignValues()
}

final class MusicPlayerPresenter: MusicPlayerViewPresenterProtocol {
    weak var view: MusicPlayerViewProtocol?
    var songData: Song
    var trackIndex: Int
    
    private let userDefaults = UserDefaults.standard
    private let playerManager = PlayerManager.shared
    private var isTapped = true
    
    required init(view: MusicPlayerViewProtocol, songData: Song, songIndex: Int) {
        self.view = view
        self.songData = songData
        self.trackIndex = songIndex
    }
    
    func playPauseButtonPressed(completion: @escaping (String) -> Void) {
        if isTapped {
            completion("play")
            playerManager.player.pause()
        } else {
            completion("pause")
            playerManager.player.play()
        }
        isTapped.toggle()
    }
    
    func forwardButtonPressed(completion: @escaping (Song) -> Void) {
        if trackIndex < playerManager.songsArray.count - 1 {
            trackIndex += 1
        } else {
            trackIndex = 0
        }
        let nextSong = playerManager.songsArray[trackIndex]
        completion(nextSong)
        startTrackPlayback()
        isTapped = true
    }
    
    func backButtonPressed(completion: @escaping (Song) -> Void) {
        if trackIndex > 0 {
            trackIndex -= 1
        } else {
            trackIndex = playerManager.songsArray.count - 1
        }
        let previousSong = playerManager.songsArray[trackIndex]
        completion(previousSong)
        startTrackPlayback()
        isTapped = true
    }
    
    func validateTrack() {
        if trackIndex == userDefaults.object(forKey: "index") as? Int && playerManager.player.isPlaying {
            return
        } else {
            startTrackPlayback()
        }
    }
    
    func startTrackPlayback() {
        playerManager.playSound(index: trackIndex)
        playerManager.player.play()
    }
    
    func assignValues() {
        view?.assignValues(songData)
    }
}
