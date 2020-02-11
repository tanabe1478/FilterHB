//
//  FilteringWordCell.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/12.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models
import RealmSwift

class FilteringWordCell: UITableViewCell, InstantiatableFromNib {
    @IBOutlet weak private var wordLabel: UILabel!
    var index: Int!
    weak var dataSource: FilteringWordCellDataSource? {
        didSet { setLayout() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setLayout() {
        guard let dataSource = dataSource else { return }
        wordLabel.text = dataSource.wordList[index].word
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

protocol FilteringWordCellDataSource: AnyObject {
    var wordList: Results<FilterWord>! { get set }
}
