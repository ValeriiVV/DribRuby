//
//  ShotTableViewCell.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 03.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import UIKit

protocol ShotTableViewCellDelegate {
    func openFullScreenImage(imageView: UIImageView)
}

class ShotTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView        : UIImageView!
    @IBOutlet weak var blurView             : UIView!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var descriptionLabel     : UILabel!
    
    var delegate: ShotTableViewCellDelegate?
    
    var titleText: String = "" {
        didSet {
            if titleText == "" {
                titleLabel.text = "Title"
            }
                
            else {
                titleLabel.text = titleText
            }
        }
    }
    var descriptionWithHTML: String = "" {
        didSet {
            let clearedSting = descriptionWithHTML.html2String
            
            if clearedSting == "" {
                descriptionLabel.text = "The description is empty. Thanks to the author for that"
            }
            else {
                descriptionLabel.text = clearedSting.replacingOccurrences(of: "\n", with: "")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBlurEffect()
        
        let imageGestures = UITapGestureRecognizer.init(target: self, action: #selector(imageTapped))
        mainImageView.addGestureRecognizer(imageGestures)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        mainImageView.image = nil
    }
}

extension ShotTableViewCell {
    
    func imageTapped() {
        delegate?.openFullScreenImage(imageView: mainImageView)
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffectView)
        
        blurView.layer.zPosition = 1
        titleLabel.layer.zPosition = 2
        descriptionLabel.layer.zPosition = 3
    }
}

