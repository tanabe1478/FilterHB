//
//  FIltersViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/12.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models
import RealmSwift

class FiltersViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    var editingField: UITextField?
    var dataSource = FiltersDataSource()

    @IBOutlet weak var wordTextField: UITextField!

    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var formContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var formContainerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        wordTextField.delegate = self
        endButton.isEnabled = false
        endButton.isHidden = true
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: FilteringWordCell.nibName, bundle: nil), forCellReuseIdentifier: FilteringWordCell.nibName)
        tableView.keyboardDismissMode = .onDrag

        // database
        if let realm = try? Realm() {
            dataSource.realm = realm
        }
        dataSource.wordList = dataSource.realm.objects(FilterWord.self)
        //        dataSource.token = dataSource.wordList.observe { [weak self] _ in
        //            self?.tableView.reloadData()
        //        }
    }

    @IBAction func tapAddButton(_ sender: Any) {
        wordTextField.becomeFirstResponder()

    }

    @IBAction func tapEndButton(_ sender: Any) {
        editingField?.resignFirstResponder()
        editingField?.text = nil
    }

}

extension FiltersViewController: UITextFieldDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(FiltersViewController.handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(FiltersViewController.handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
        guard editingField != nil else { return }
        let userInfo = notification.userInfo!
        guard let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        self.formContainerBottomConstraint.constant = keyboardScreenEndFrame.height
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
        self.formContainerBottomConstraint.constant = 0.0
        UIView.animate(withDuration: 2.0) {
            self.view.layoutIfNeeded()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 追加

        guard let text = editingField?.text, !(text == "") else { return true }

        self.tableView.beginUpdates()
        let latRowIndex = self.tableView.numberOfRows(inSection: 0)
        let indexPath = IndexPath(row: latRowIndex, section: 0)
        // 最後の次に挿入
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        //self.dataSource.words.append(text)
        FilterWord.addWord(word: text, realm: self.dataSource.realm)
        self.tableView.endUpdates()
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        editingField?.text = nil
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        editingField = textField
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        editingField = textField
        endButton.isEnabled = true
        endButton.isHidden = false
        return true
    }

}
