//
//  SongsTableViewPresenter.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import Foundation

protocol SongsTableViewProtocol: AnyObject {
    func setSongs(_ songsArray: [Song])
}

protocol SongsTableViewPresenterProtocol: AnyObject {
    init(view: SongsTableViewProtocol, songsArray: [Song])
    
    func configureSongs()
}

final class SongsTableViewPresenter: SongsTableViewPresenterProtocol {
    weak var view: SongsTableViewProtocol?
    
    var songsArray: [Song]
    
    required init(view: SongsTableViewProtocol, songsArray: [Song]) {
        self.view = view
        self.songsArray = songsArray
    }
    
    func configureSongs() {
        view?.setSongs(songsArray)
    }
}
