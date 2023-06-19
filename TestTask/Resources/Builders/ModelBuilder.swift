//
//  ModelBuilder.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit

protocol BuilderProtocol {
    static func craetSongsTableView() -> UIViewController
    static func creatMusicPlayerView(songData: Song, songIndex: Int) -> UIViewController
}

final class ModelBuilder: BuilderProtocol {
    
    static func craetSongsTableView() -> UIViewController {
        let songsArray = [Song(performer: "Eminem",
                               songTitle: "Lose Your self",
                               duration: "4:43"),
                          Song(performer: "Eminem Feat Nate Dogg",
                               songTitle: "'Till I Collapse",
                               duration: "4:57"),
                          Song(performer: "Eminem ft. Dido",
                               songTitle: "Stan (Remastered)",
                               duration: "6:44")]
        let view = SongsTableViewController()
        let presenter = SongsTableViewPresenter(view: view, songsArray: songsArray)
        view.presenter = presenter
        return view
    }
    
    static func creatMusicPlayerView(songData: Song, songIndex: Int) -> UIViewController {
        let view = MusicPlayerViewController()
        let presenter = MusicPlayerPresenter(view: view, songData: songData, songIndex: songIndex)
        view.presenter = presenter
        return view
    }
}
