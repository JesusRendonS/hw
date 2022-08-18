//
//  Prueba 12.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/19/22.
//

/*
 import UIKit

 class DetailViewController: UIViewController {
     
     
 //    static let reuseId = "\(PokemonTableViewCell.self)"
     
 //    var pokemon: PokemonData?
     
     var pokeimage: UIImage?
     var pokeNames: String?
     var pokeTypes: String?
     var pokTy: String?
     var pokIm: Data?
     var AbilFrCache: [String]?
     var MoveFrCache: [String]?
     
     
     //Crate the lazy vars for each of the elements
     
     lazy var pokemonImageview: UIImageView = {
         let imageView = UIImageView(frame: .zero)
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(data: pokIm!)
         imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
         imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
         return imageView
     }()
     
     lazy var titleLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.setContentHuggingPriority(.required, for: .vertical)
         label.textAlignment = NSTextAlignment.center;
         label.textColor = .black
         label.text = pokeNames?.uppercased()
         return label
         
     }()
     
     lazy var typesLabelTitle: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.setContentHuggingPriority(.required, for: .vertical)
         label.textAlignment = NSTextAlignment.center;
         label.setContentCompressionResistancePriority(.required, for: .vertical)
         label.text = "TYPE - ABILITIES - MOVES"
         label.layer.masksToBounds = true
         label.layer.cornerRadius = 20.0
         label.backgroundColor = .black
         label.textColor = .white
         return label
     }()
     
     lazy var typesLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.setContentHuggingPriority(.required, for: .vertical)
         label.textAlignment = NSTextAlignment.center;
         label.setContentCompressionResistancePriority(.required, for: .vertical)
         label.text = pokTy?.uppercased()
         

             label.backgroundColor = .black
             label.textColor = .white

         
         label.layer.masksToBounds = true
         label.layer.cornerRadius = 20.0
         
         return label
     }()
     
     lazy var abilityLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.setContentHuggingPriority(.required, for: .vertical)
         label.textAlignment = NSTextAlignment.center;
         label.setContentCompressionResistancePriority(.required, for: .vertical)
         label.layer.masksToBounds = true
         label.layer.cornerRadius = 20.0
         label.backgroundColor = .black
         label.textColor = .white
         
         return label
     }()
     

     lazy var textView: UITextView = {
         let textMoves = UITextView(frame: .zero)
         textMoves.contentInsetAdjustmentBehavior = .automatic
         textMoves.center = self.view.center
         textMoves.textAlignment = NSTextAlignment.justified
         textMoves.textColor = UIColor.white
         
         textMoves.backgroundColor = .black
         return textMoves
     }()
     
     lazy var movesLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0
         label.setContentHuggingPriority(.required, for: .vertical)
         label.textAlignment = NSTextAlignment.center;
         label.setContentCompressionResistancePriority(.required, for: .vertical)
         label.sizeToFit()
         label.backgroundColor = .systemBlue
         return label
     }()
     
   
     
     init(typeString: String, imaData: Data, abilString: [String], moveString: [String]){
         self.pokTy = typeString
         self.pokIm = imaData
         self.AbilFrCache = abilString
         self.MoveFrCache = moveString
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         if(pokTy == "fire"){
             self.view.backgroundColor = .orange
         }else if(pokTy == "water"){
             self.view.backgroundColor = .blue
         }else if(pokTy == "bug"){
             self.view.backgroundColor = .brown
         }else if(pokTy == "grass"){
             self.view.backgroundColor = .systemGreen
         }else if(pokTy == "normal"){
             self.view.backgroundColor = .gray
         }else if(pokTy == "poison"){
             self.view.backgroundColor = .systemPurple
         }else if(pokTy == "electric"){
             self.view.backgroundColor = .yellow
         }else if(pokTy == "ground"){
             self.view.backgroundColor = .brown
         }else if(pokTy == "fairy"){
             self.view.backgroundColor = .white
         }else if(pokTy == "fighting"){
             self.view.backgroundColor = .lightGray
         }else if(pokTy == "psychic"){
             self.view.backgroundColor = .cyan
         }else if(pokTy == "ghost"){
             self.view.backgroundColor = .black
         }else if(pokTy == "rock"){
             self.view.backgroundColor = .systemBrown
         }else if(pokTy == "ice"){
             self.view.backgroundColor = .blue
         }else if(pokTy == "dragon"){
             self.view.backgroundColor = .orange
         }else {
             self.view.backgroundColor = .systemRed
         }
      
 //        self.view.backgroundColor = .systemRed
         
         let movConj = self.MoveFrCache?.joined(separator: " - ")
         let abilConj = self.AbilFrCache?.joined(separator: " - ")
         
         
         
         
         navigationItem.title = "HELLO TRAINER, THE POKEMON IS:"
         
         
         self.textView.text = movConj?.uppercased()
         self.abilityLabel.text = abilConj?.uppercased()
         
         self.setUpUI()
         
     }
     
     private func setUpUI() {
         
         let elementsStack = UIStackView(frame: .zero)
         elementsStack.translatesAutoresizingMaskIntoConstraints = false
         elementsStack.spacing = 5
         elementsStack.axis = .vertical
         elementsStack.distribution = .fillEqually
         
         let imageStack = UIStackView(frame: .zero)
         imageStack.translatesAutoresizingMaskIntoConstraints = false
         imageStack.spacing = 5
         imageStack.axis = .vertical
         imageStack.distribution = .fillEqually
     
         imageStack.addArrangedSubview(self.titleLabel)
         imageStack.addArrangedSubview(self.pokemonImageview)
         
         let vStackView = UIStackView(frame: .zero)
         vStackView.translatesAutoresizingMaskIntoConstraints = false
         vStackView.spacing = 5
         vStackView.axis = .vertical
         vStackView.distribution = .fillEqually

         
         vStackView.addArrangedSubview(self.typesLabelTitle)
         vStackView.addArrangedSubview(self.typesLabel)
         vStackView.addArrangedSubview(self.abilityLabel)
         vStackView.addArrangedSubview(self.textView)
         
         
         

         let hStackView = UIStackView(frame: .zero)
         hStackView.translatesAutoresizingMaskIntoConstraints = false
         hStackView.spacing = 8
         hStackView.axis = .horizontal
         
         elementsStack.addArrangedSubview(imageStack)
         elementsStack.addArrangedSubview(vStackView)

         hStackView.addArrangedSubview(elementsStack)
         
         self.view.addSubview(hStackView)
         hStackView.bindToSuperView()
         
     }

 }
 
 
 */
