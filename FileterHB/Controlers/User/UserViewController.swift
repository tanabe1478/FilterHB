//
//  UserViewController.swift
//
//
//  Created by 田辺信之 on 2019/02/17.
//
import UIKit
import Models
import RealmSwift

class UserViewController: UIViewController {
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: UserBookmarkCell.nibName, bundle: nil), forCellReuseIdentifier: UserBookmarkCell.nibName)
        }
    }

    var dataSource = UserDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = self
        guard let realm = try? Realm() else { fatalError() }
        let nameList = realm.objects(BlockUser.self)
        BlockUser.hasUser(userName: dataSource.userId, list: nameList) { status in
            if status {
                self.blockButton.isSelected = true
                self.blockButton.setTitle("Unblock", for: .selected)
            } else {
                self.blockButton.isSelected = false
                self.blockButton.setTitle("Block", for: .normal)
            }
        }
        dataSource.getRSS(tableView: tableView, urlString: dataSource.urlString!)
    }

    @IBAction func tappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tappedBlockButton(_ sender: Any) {
        guard let realm = try? Realm() else { fatalError() }
        let nameList = realm.objects(BlockUser.self)
        if blockButton.isSelected {
            BlockUser.deleteUser(userName: dataSource.userId, realm: realm, list: nameList)
        } else {
            BlockUser.addUser(userName: dataSource.userId, realm: realm)
        }
        blockButton.isSelected.toggle()
        print(#function)
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

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let urlString = dataSource.rssItems?[indexPath.row].url else {
            return
        }
        let tabvc = WebTabController()
        tabvc.setVC(urlString: urlString)
        self.navigationController?.pushViewController(tabvc, animated: true)
    }
}
