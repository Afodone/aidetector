//
//  HorizontalTextCollectionView.swift
//  AIDetector
//
//  Created by yong on 2025/7/26.
//


import UIKit

class AIDHorizontalTextCollectionView: UIView {

    private var collectionView: UICollectionView!
    private var items: [String] = []
    var selectedIndex: Int = -1
    
    var itemSelected: ((Int) -> Void)?
    var itemFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet { collectionView.reloadData() }
    }
    var itemTextColor: UIColor = .darkGray {
        didSet { collectionView.reloadData() }
    }
    var selectedItemTextColor: UIColor = .white {
        didSet { collectionView.reloadData() }
    }
    var selectedItemBackgroundColor: UIColor = .systemBlue {
        didSet { collectionView.reloadData() }
    }
    var itemSpacing: CGFloat = 12 {
        didSet {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = itemSpacing
            }
        }
    }
    var itemPadding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) {
        didSet { collectionView.reloadData() }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AIDTextCollectionViewCell.self, forCellWithReuseIdentifier: "AIDTextCollectionViewCell")
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

    
    func configure(with items: [String], selectedIndex: Int = 0) {
        self.items = items
        self.selectedIndex = selectedIndex
        collectionView.reloadData()
        

        DispatchQueue.main.async {
            self.collectionView.scrollToItem(
                at: IndexPath(item: selectedIndex, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
        }
    }
    
    func selectItem(at index: Int, animated: Bool = true) {
        guard index >= 0 && index < items.count else { return }
        
        let previousIndex = selectedIndex
        selectedIndex = index
        

        if previousIndex != index {
            collectionView.reloadItems(at: [
                IndexPath(item: previousIndex, section: 0),
                IndexPath(item: index, section: 0)
            ])
        }
        

        collectionView.scrollToItem(
            at: IndexPath(item: index, section: 0),
            at: .centeredHorizontally,
            animated: animated
        )
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension AIDHorizontalTextCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AIDTextCollectionViewCell", for: indexPath) as! AIDTextCollectionViewCell
        let isSelected = indexPath.item == selectedIndex
        
        cell.configure(
            with: items[indexPath.item],
            isSelected: isSelected,
            font: itemFont,
            textColor: itemTextColor,
            selectedTextColor: selectedItemTextColor,
            selectedBackgroundColor: selectedItemBackgroundColor,
            padding: itemPadding
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.item]
        let isSelected = indexPath.item == selectedIndex
        
        // 计算文本宽度
        let attributes: [NSAttributedString.Key: Any] = [
            .font: itemFont
        ]
        let textWidth = (text as NSString).size(withAttributes: attributes).width + 10
        
        // 计算单元格宽度 (文本宽度 + 左右内边距)
        let cellWidth = textWidth + itemPadding.left + itemPadding.right
        
        // 高度固定，可根据需要调整
        let cellHeight: CGFloat = self.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(at: indexPath.item)
        itemSelected?(indexPath.item)
    }
}



class AIDTextCollectionViewCell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        layer.cornerRadius = self.height/2
        layer.masksToBounds = true
        label.textAlignment = .center
    }
    
    func configure(
        with text: String,
        isSelected: Bool,
        font: UIFont,
        textColor: UIColor,
        selectedTextColor: UIColor,
        selectedBackgroundColor: UIColor,
        padding: UIEdgeInsets
    ) {
        label.text = text
        label.font = font
        
        if isSelected {
            label.textColor = selectedTextColor
            backgroundColor = selectedBackgroundColor
        } else {
            label.textColor = textColor
            backgroundColor = aid_181818
        }
        

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding.left),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.right),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.top),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        backgroundColor = .clear
    }
}
