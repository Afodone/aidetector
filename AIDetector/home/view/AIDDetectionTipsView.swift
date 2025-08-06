//
//  AIDDetectionTipsView.swift
//  AIDetector
//
//  Created by yong on 2025/8/3.
//

import UIKit

class AIDDetectionTipsView:UIView{
    
    var data:[AIDTextDetectionData] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var collectionView:UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        backgroundColor = .clear
    }
    
    
    func showBlur(){
        self.addSubview(blurEffectView)
        blurEffectView.frame = self.bounds
    }
     private func setupCollectionView() {

         let view = self
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.itemSize = CGSize(width: (view.frame.width - 0) / 4, height: 44)
         layout.minimumLineSpacing = 10
         layout.minimumInteritemSpacing = 0
//         layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

         collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.backgroundColor = .clear
         
         view.addSubview(collectionView)

         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
    
    
    lazy var blurEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.layer.cornerRadius = 12
        blurEffectView.layer.masksToBounds = true
        
        return blurEffectView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
extension AIDDetectionTipsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCollectionViewCell
       
        let model = data[indexPath.row]
        cell.titleLabel.text = model.name
        
        //70%及以上返回红色，31-69黄色，0-30绿色
        
        if model.progress >= 70{
            cell.imgView.image = .tdImgRed
        }else if model.progress >= 31 && model.progress < 70{
            cell.imgView.image = .tdImgYellow
        }else{
            cell.imgView.image = .tdImgGreen
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item: \(data[indexPath.item])")
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 30) / 2
//        return CGSize(width: width, height: 100)
//    }
}
class MyCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = aid_999999
        label.font = AIDFont.font(12)
        return label
    }()
    
    let imgView: UIImageView = {
        let view = UIImageView()
        view.image = .tdImgRed
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        layer.cornerRadius = 8
        
        addSubview(titleLabel)
        addSubview(imgView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            imgView.widthAnchor.constraint(equalToConstant: 24),
            imgView.heightAnchor.constraint(equalToConstant: 24),
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
