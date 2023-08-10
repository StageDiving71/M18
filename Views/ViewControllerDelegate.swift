//
//  ViewControllerDelegate.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 14.05.2023.
//

import Foundation
import UIKit

protocol ViewControllerDelegate: AnyObject {
//    func setView(_ view: ViewProtocol)
//
//    func numberOfRowsInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    func didSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    func didTapButton()
}

protocol ViewProtocol: AnyObject {
    func reloadTable()
   // func showAlert(title: String, message: String)
}
