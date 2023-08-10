//
//  Presenter.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 14.05.2023.
//

import Foundation

protocol ViewPresenterProtocol: AnyObject {
    
    func setView(_ view: ModelViewControllerProtocol)
    
    func setupData(with data: ([Film]))
    
    func numberOfRowInSection(_ section: Int) -> Int
    
    func titleForRow(at indexPath: IndexPath) -> String
    
    
    
}

final class ViewControllerPresenter: ViewPresenterProtocol {
    

    private var testData: [Film] = []
    
    var setData123 = [Film]()
    
    private weak var view: ModelViewControllerProtocol?
    
    private var model: Welcome?
    
    func setView(_ view: ModelViewControllerProtocol) {
        self.view = view
    }
    
    func setupData(with data: ([Film])) {
        self.testData = data
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        return testData.count
    }
    
    func titleForRow(at indexPath: IndexPath) -> String {
        let txt = testData[indexPath.row].nameEn
        return txt
    }
    
    private func showAlert(for model: Film) {
        
        let alertTitle: String = model.nameEn
        let alertMessage: String = model.description
        
       // view?.showAlert(title: alertTitle, message: alertMessage)
        view?.reloadTable()
    }
    
    
    
    
}
//final class Presenter: ViewPresenterProtocol {
//    
//    private weak var view: ViewProtocol?
//    
//    private var model = [Result1]()
//    
//    
//    func setView(_ view: ViewProtocol) {
//        self.view = view
//    }
//    
//    func numberOfRowsInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        model.count
//    }
//    
//    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        
//        return cell
//    }
//    
//    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = MovieViewController()
//        vc.indicator.startAnimating()
//        guard let apiURL = URL(string: model[indexPath.row].image) else { return }
//        
//        vc.configure1(with: model[indexPath.row])
//        
//        URLSession.shared.dataTask(with: apiURL) { data, _, _ in
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                vc.imageView.image = UIImage(data: data)
//                vc.indicator.stopAnimating()
//            }
//        }.resume()
//        
//        vc.title = model[indexPath.row].title
//        view?.reloadTable()
//        
//        let navCont = UINavigationController()
//        navCont.pushViewController(vc, animated: true)
//    }
//    
//    
//    weak private var viewDelegate: ViewControllerDelegate?
//    //var getData = Welcome
//}

