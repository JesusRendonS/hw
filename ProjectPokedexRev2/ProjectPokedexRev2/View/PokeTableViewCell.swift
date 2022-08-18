//
//  PokeTableViewCell.swift
//  ProjectPokedexRev2
//
//  Created by Consultant on 7/16/22.
//

import UIKit

class PokeTableViewCell: UITableViewCell {

    static  let reuseID = "\(PokeTableViewCell.self)"
    
    var pokemon: Pokemon?
    
    lazy var progImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemMint
        return imageView
    }()
    
    lazy var progTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .systemRed
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var progMidLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.text = "hola"
        return label
    }()
    
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        self.backgroundColor = .clear
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually

        vStackView.addArrangedSubview(self.progTopLabel)
        vStackView.addArrangedSubview(self.progMidLabel)

        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 8
        hStackView.axis = .horizontal

        
        hStackView.addArrangedSubview(self.progImageView)
        hStackView.addArrangedSubview(vStackView)

        self.progImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.progImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        self.contentView.addSubview(hStackView)
        hStackView.bindToSuperView()
    }
    func configure(names: ResultName){
        self.progTopLabel.text = names.name.capitalized
    }
    func configure(types: LiteralType){
        self.progMidLabel.text = types.type.name.capitalized
    }

}

