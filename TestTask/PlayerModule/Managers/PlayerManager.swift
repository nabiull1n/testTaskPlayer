//
//  PlayerManager.swift
//  TestTask
//
//  Created by Денис Набиуллин on 09.06.2023.
//

import AVFoundation

final class PlayerManager { 
    
    static let shared = PlayerManager()
    private init() {}
    
    var player = AVAudioPlayer()
    private let userDefaults = UserDefaults.standard
    
    var songsArray: [Song] = []
    
    func setArray(_ array: [Song]) {
        songsArray = array
    }
    
    func playSound(index: Int) {
        let songByIndex = songsArray[index]
        let fullNameSong = "\(songByIndex.performer) - \(songByIndex.songTitle)"
        
        guard let url = Bundle.main.url(forResource: fullNameSong, withExtension: "mp3") else { return }
        
        if index == userDefaults.object(forKey: "index") as? Int && player.isPlaying {
            return
        } else {
            do {
                player = try AVAudioPlayer(contentsOf: url)
            } catch {
                print(error.localizedDescription)
            }
            userDefaults.set(index, forKey: "index")
            userDefaults.synchronize()
            return
        }
    }
}
