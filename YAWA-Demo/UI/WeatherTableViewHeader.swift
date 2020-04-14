//
//  WeatherTableViewHeader.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

public protocol WeatherTableHeaderActionProtocol {
    func onButtonTapped(text: String?)
}

class WeatherTableViewHeader: UIView {
    
    let nibName = "WeatherTableViewHeader"
    var delegate: WeatherTableHeaderActionProtocol?
    
    //MARK: - IBOutlets
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fetchButton: UIButton!

    //MARK: - UIView Overided methods
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureXIB()
    }
    
    func configureXIB() {
        customView = configureNib()
        customView.frame = bounds
        customView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(customView)
        
        self.viewAutoLayout()
        
        cityLabel.text = ""
        cityLabel.textColor = UIColor.red
        
        fetchButton.layer.masksToBounds = true
        fetchButton.layer.cornerRadius = 5
        fetchButton.setBackgroundColor(UIColor.red, for: .normal)
        fetchButton.setBackgroundColor(UIColor.lightGray, for: .highlighted) //highlighted/normal/disabled/selected
    }
    
    func configureNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func viewAutoLayout() {
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views = Dictionary(dictionaryLiteral: ("customView",customView), ("textField",textField), ("cityLabel",cityLabel), ("fetchButton",fetchButton)) as [String : Any]
        
        let metrics = Dictionary(dictionaryLiteral: ("padding", 10),("vPadding",20))
        
        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[textField(==120)]-[cityLabel(==80)]-[fetchButton(==80)]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[textField]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[cityLabel]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        let vertical3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-vPadding-[fetchButton]-vPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        
        var viewConstraints = [NSLayoutConstraint]()
        
        viewConstraints += horizontal1
        viewConstraints += vertical1
        viewConstraints += vertical2
        viewConstraints += vertical3
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
    @IBAction private func fetchButtonTapped() {
        print("directionsButtonTapped..")
        delegate?.onButtonTapped(text: textField.text)
    }
}

extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
}
