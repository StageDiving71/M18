//
//  MovieViewController.swift
//  
//
//  Created by Владимир Бурлинов on 11.04.2023.
//

import UIKit
import SnapKit

struct CellWithImageAndTitleViewModel {
    
    let image: UIImage
    //фывыфвыв
}

class MovieViewController: UIViewController {
    
    let indicator = UIActivityIndicatorView()
 
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 500, y: 500, width: 300, height: 300))
        image.center = view.center
        return image
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()

        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(indicator)
        indicator.center = view.center
        setupConstraints()
    }
    
    func configure1(with model: Film) {
        self.labelName.text = model.nameEn
        self.labelTitle.text = model.nameRu
    }
    
    private func setupConstraints() {
        view.addSubview(labelName)
        view.addSubview(labelTitle)
        self.labelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.topMargin.equalTo(imageView.snp_bottomMargin).inset(-20)
        }
        
        self.labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.topMargin.equalTo(labelName.snp_bottomMargin).inset(-20)
        }
    }
    
    func configure(_ viewModel: Film) {
        //        labelTitle.text = viewModel.title
        //        image.image = viewModel.image
        imageView.image = UIImage(contentsOfFile: viewModel.posterURL)
    }
}
