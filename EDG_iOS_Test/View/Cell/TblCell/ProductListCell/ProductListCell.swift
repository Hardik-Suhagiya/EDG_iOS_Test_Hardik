//
//  ProductListCell.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 16/02/23.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var viewBase: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: -  functions
    func setupUI(){
        viewBase.layer.cornerRadius = 8
        viewBase.layer.borderWidth = 1
        viewBase.layer.borderColor = UIColor.lightGray.cgColor
        imgProduct.layer.cornerRadius = self.imgProduct.bounds.height / 2
        imgProduct.layer.borderWidth = 1
        imgProduct.layer.borderColor = UIColor.lightGray.cgColor
        btnAddToCart.layer.cornerRadius = 4
    }
}
