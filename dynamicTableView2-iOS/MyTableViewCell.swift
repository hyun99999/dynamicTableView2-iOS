//
//  MyTableViewCell.swift
//  DynamicTableViewTutorial
//
//  Created by kimhyungyu on 2021/01/07.
//

import Foundation
//mytableviewcell.xib nib 파일을 연결하기 위한 파일
import UIKit

class MyTableViewCell: UITableViewCell {
    //셀이 렌더링 될떄
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("mytableviewcell -awakefromnib() called")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width/2
    }
}
