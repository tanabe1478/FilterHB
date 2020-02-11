//
//  SettingViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import UIKit
import Models
import RealmSwift

class SettingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource = UserListDataSource()

    @IBAction func tappedBackButton(_ sender: Any) {
        self.dismiss(animated: true)
        print(#function)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: BlockUserListCell.nibName, bundle: nil), forCellReuseIdentifier: BlockUserListCell.nibName)
        tableView.keyboardDismissMode = .onDrag
        guard let nameList = (try? Realm())?.objects(BlockUser.self) else { fatalError() }
        dataSource.nameList = nameList
        tableView.delegate = self
        tableView.dataSource = dataSource

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedCheckButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension SettingViewController: UITableViewDelegate {

}
