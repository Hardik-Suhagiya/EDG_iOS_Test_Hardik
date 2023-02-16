//
//  ProductListController.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 15/02/23.
//

import UIKit
import Toast_Swift
import MBProgressHUD
import SDWebImage

class ProductListController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var tblProducts: UITableView!
    @IBOutlet var viewEmptyWaring: UIView!
    
    //MARK: - Variable
    var arrProducts = [Product]()
    var arrFavProductIds = [String]()
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        arrFavProductIds = getFavouriteList() ?? [String]()
        self.tblProducts.reloadData()
    }
    
    //MARK: - Functions
    func setupUI(){
        self.title = "Products"
        tblProducts.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
    }
    
    //MARK: - Button Click
    @objc func btnFavClicked(_ sender:UIButton){
        let productId = arrProducts[sender.tag].id ?? ""
        if arrFavProductIds.contains(productId){
            arrFavProductIds = arrFavProductIds.filter { $0 != productId }
        }
        else{
            arrFavProductIds.append(productId)
        }
        saveFavouriteList(arrFav: arrFavProductIds)
        let indexPath = IndexPath(item: sender.tag, section: 0)
        tblProducts.reloadRows(at: [indexPath], with: .none)
    }
}
//MARK: - API Call
extension ProductListController{
    func getProducts(){
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        ProductViewModel.shared.fetchProductList { model, errorMsg in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            if errorMsg != nil{
                self.view.makeToast(errorMsg, duration: 1.0, position: .bottom)
                return
            }
            self.arrProducts = model?.products ?? [Product]()
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
}
//MARK: - Tableview Method
extension ProductListController:UITableViewDelegate,UITableViewDataSource{
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
