//
//  ProductDetailController.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 16/02/23.
//

import UIKit
import SDWebImage
import Cosmos

class ProductDetailController: UIViewController {
    //MARK: - Outlet
    
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewRatting: CosmosView!
    
    //MARK: - Variable
    var product : Product?
    var arrFavProductIds = [String]()
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    //MARK: - Functions
    static func shared() -> ProductDetailController?{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailController") as? ProductDetailController
    }
    
    func setupUI(){
        self.title = "Details"
        imgProduct.layer.cornerRadius = self.imgProduct.bounds.height / 2
        imgProduct.layer.borderWidth = 1
        imgProduct.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupData(){
        arrFavProductIds = getFavouriteList() ?? [String]()
        if let url = URL(string: product?.imageURL ?? ""){
            imgProduct.sd_setImage(with:url , completed: nil)
        }
        lblProductName.text =  product?.title
        lblPrice.text = "\(product?.price?[0].value ?? 0.0)"
        if arrFavProductIds.contains(product?.id ?? ""){
            btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else{
            btnFavourite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        viewRatting.rating = product?.ratingCount ?? 0.0
    }
    
    //MARK: - Button Click
    @IBAction func btnFavClicked(_ sender: Any) {
        let productId = product?.id ?? ""
        if arrFavProductIds.contains(productId){
            arrFavProductIds = arrFavProductIds.filter { $0 != productId }
            btnFavourite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else{
            arrFavProductIds.append(productId)
            btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        saveFavouriteList(arrFav: arrFavProductIds)
    }
}
