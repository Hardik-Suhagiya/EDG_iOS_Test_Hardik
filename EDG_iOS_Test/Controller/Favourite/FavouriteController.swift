//
//  FavouriteController.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 16/02/23.
//

import UIKit
import SDWebImage

class FavouriteController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var tblProducts: UITableView!
    @IBOutlet var viewEmptyWaring: UIView!
    
    //MARK: - Variable
    var arrProducts = [Product]()
    var arrFavProductIds = [String]()
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        arrFavProductIds = getFavouriteList() ?? [String]()
        arrProducts = ProductViewModel.shared.arrProducts
        arrProducts = arrProducts.filter({ product in
            return arrFavProductIds.contains(product.id ?? "")
        })
        self.tblProducts.reloadData()
        if self.arrProducts.count == 0{
            self.tblProducts.backgroundView = self.viewEmptyWaring
        }
        else
        {
            self.tblProducts.backgroundView = nil
        }
    }
    
    //MARK: - Functions
    func setupUI(){
        self.title = "Favourite"
        tblProducts.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
    }
    
    //MARK: - Button Click
    @objc func btnFavClicked(_ sender:UIButton){
        let productId = arrProducts[sender.tag].id ?? ""
        arrFavProductIds = arrFavProductIds.filter { $0 != productId }
        saveFavouriteList(arrFav: arrFavProductIds)
        arrProducts.remove(at: sender.tag)
        self.tblProducts.reloadData()
        if self.arrProducts.count == 0{
            self.tblProducts.backgroundView = self.viewEmptyWaring
        }
        else
        {
            self.tblProducts.backgroundView = nil
        }
    }
}

//MARK: - Tableview Method
extension FavouriteController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? ProductListCell
        if cell != nil{
            if let url = URL(string: arrProducts[indexPath.row].imageURL ?? ""){
                cell!.imgProduct.sd_setImage(with:url , completed: nil)
            }
            cell!.lblProductName.text = arrProducts[indexPath.row].title
            cell!.lblPrice.text = "Price : " + "\(arrProducts[indexPath.row].price?[0].value ?? 0.0)"
            cell!.btnFavourite.tag = indexPath.row
            cell!.btnFavourite.addTarget(self, action: #selector(self.btnFavClicked(_:)), for: .touchUpInside)
            if arrFavProductIds.contains(arrProducts[indexPath.row].id ?? ""){
                cell!.btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            else{
                cell!.btnFavourite.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = ProductDetailController.shared(){
            vc.product = arrProducts[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
