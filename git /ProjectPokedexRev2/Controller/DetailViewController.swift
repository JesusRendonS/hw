//
//  DetailViewController.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var id: URL?
    var pokenames: Pokemon?
    var pokeSprite: UIImage?
    var poketype: [LiteralType]
    var pokeAbility: [Ability]
    var pokeMoves: [Move]
    var namae: String?
    
    

    lazy var NameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemMint
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15.0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var TypeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemMint
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15.0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    
    lazy var Sprite: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    
    lazy var AbilityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemMint
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15.0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var pokeMovesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Moves", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.movesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let network: NetworkManager = .init()

    let shinyEncounter = Int.random(in: 1..<5) //4269
   
   
    let text: String
    
    init(text: String) {
        self.text = text
        self.poketype = []
        self.pokeMoves = []
        self.pokeAbility = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func movesButtonPressed() {
        self.PresentMoves()
    }
    
    func PresentMoves(){
        let moves = pokeMoves.compactMap { $0.move.name }.reduce("") { partialResult, move in
            return partialResult + move + "\n"
        }
        
        let alert = UIAlertController(title: namae, message: moves, preferredStyle: .alert)
        let action = UIAlertAction(title: "Back to Pokémon", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.setUpUI()
        namae = self.text
        self.NameLabel.text = namae?.capitalized
        self.title = namae?.capitalized
        print(shinyEncounter)
        
    }
    
    
    
    
    
    private func setUpUI() {
        
        self.view.addSubview(self.Sprite)
        self.view.addSubview(self.NameLabel)
        self.view.addSubview(self.TypeLabel)
        self.view.addSubview(self.AbilityLabel)
        self.view.addSubview(self.pokeMovesButton)

        self.Sprite.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.Sprite.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.Sprite.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.Sprite.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        self.NameLabel.topAnchor.constraint(equalTo: self.Sprite.bottomAnchor, constant: 8).isActive = true
        self.NameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.NameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.NameLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.TypeLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        self.TypeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.TypeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.TypeLabel.topAnchor.constraint(equalTo: self.NameLabel.bottomAnchor,constant: 8).isActive = true
        
        self.AbilityLabel.topAnchor.constraint(equalTo: self.TypeLabel.bottomAnchor, constant: 8).isActive = true
        self.AbilityLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.AbilityLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.AbilityLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.pokeMovesButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.pokeMovesButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.pokeMovesButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.pokeMovesButton.topAnchor.constraint(equalTo: self.AbilityLabel.bottomAnchor, constant: 8).isActive = true
        

        func fetching(){
            self.network.fetchPage(urlStr: "https://pokeapi.co/api/v2/pokemon/\(self.text)") { result in

                switch result {
                case .success(let page):
                   // print(page)
                    
                    DispatchQueue.main.async { [self] in
                        if(shinyEncounter == 3)
                        {
                            self.id = page.sprites.frontShiny
                        }
                        else{
                            self.id = page.sprites.frontDefault

                        }
                        
                        
                        self.poketype = page.types
                        self.pokeMoves = page.moves
                        self.pokeAbility = page.abilities
                                                
                        let TypeNames = self.poketype.map {
                            $0.type.name
                        }.joined(separator: ", ")
                
                        let AbilityNames = self.pokeAbility.map {
                            $0.ability.name
                        }.joined(separator: ", ")
                        
                    
                        self.TypeLabel.text = "\(TypeNames)".capitalized
                        self.AbilityLabel.text = "\(AbilityNames)".capitalized
                        self.Sprite.loadFrom(URLAdress: self.id?.absoluteString ?? "")
                       
                    }

                case .failure(let error):
                    print(error)
                }
            }
        }
        fetching()
        
    }
    
}

extension UIImageView {
    func loadFrom(URLAdress: String) {
        guard let url = URL(string: URLAdress) else {
            return
        }
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self.image = loadedImage
                }
            }
        }
    }
    
    
}


