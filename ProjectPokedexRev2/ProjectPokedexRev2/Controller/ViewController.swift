//
//  ViewController.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.dataSource = self
        table.delegate = self
        table.register(PokeTableViewCell.self, forCellReuseIdentifier: PokeTableViewCell.reuseID)
        return table
    }()
    
    var number: Int = 0
    let network: NetworkManager = .init()
    var poke: [ResultName] = []
    var pokeType: [LiteralType] = []
    var pokename: [Pokemon] = []
    var pokeAbility: [Ability] = []
    var pokeMove: [Move] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       MusicPlayer.shared.startBackgroundMusic()

        self.setUpUI()
        self.network.fetchMainPage(urlStr: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151") { result in
            
            switch result {
            case .success(let page):
                self.poke = page.results
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.title = "Pokédex!"
        self.view.addSubview(self.table)
        self.table.bindToSuperView()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.poke.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeTableViewCell.reuseID, for: indexPath) as? PokeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(names: self.poke[indexPath.row])
        
        self.network.fetchPage(urlStr: "https://pokeapi.co/api/v2/pokemon/\(indexPath.row + 1)") { result in

            switch result {
            case .success(let page):

                self.pokeAbility = page.abilities
                self.pokeType = page.types
                self.pokeMove = page.moves
                if let firstType = page.types.first {
                    DispatchQueue.main.async {
                        cell.configure(types: firstType)
                    }
                } else {
                }
              
                    
                    
                
                
            case .failure(let error):
                print(error)
            }
        }
                
        self.network.fetchImageData(urlStr: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.row + 1).png") { result in
                    
            switch result {
            case .success(let imageData):
                    
                DispatchQueue.main.async {
                    cell.progImageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
}
        
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        var nc: UIViewController = UIViewController()
        nc = DetailViewController(text: self.poke[indexPath.row].name)
        self.navigationController?.pushViewController(nc, animated: true)
        
    }
}

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "Pokecenter", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func startCryMusic() {
        if let bundle = Bundle.main.path(forResource: "https://github.com/kuo22/pokemon-cries/blob/master/public/cries/2.wav", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
