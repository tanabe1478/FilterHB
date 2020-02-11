//
//  BlockUserListCell.swift
//  FileterHB
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import UIKit
import Models
import RealmSwift

class BlockUserListCell: UITableViewCell, InstantiatableFromNib {
    @IBOutlet weak private var userNameLabel: UILabel!
    var index: Int!
    weak var dataSource: BlockUserListCellDataSource? {
        didSet { setLayout() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func setLayout() {
        guard let dataSource = dataSource  else { return }
        userNameLabel.text = dataSource.nameList[index].userName
    }
}

protocol BlockUserListCellDataSource: AnyObject {
    var nameList: Results<BlockUser>! { get set }
}
