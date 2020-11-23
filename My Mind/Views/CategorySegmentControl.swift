//
//  CustomSegmentControl.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

protocol CategorySegmentControlDelegate: AnyObject {
    func didSelect(type: CategoryType)
}

public class CategorySegmentControl: UIView {
    
    private var categories: [CategoryType] = []
    private var buttons: [UIButton] = []

    
    let textColor: UIColor = .gray
    let selectorTextColor: UIColor = .brandWhite
    
    weak var delegate: CategorySegmentControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, categories: [CategoryType], delegate: CategorySegmentControlDelegate) {
        self.init(frame: frame)
        self.categories = categories
        self.delegate = delegate
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    
    func setIndex(index:Int) {
        buttons.forEach { (button) in
            button.setTitleColor(textColor, for: .normal)
        }
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        layoutSubviews()
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            btn.layer.borderWidth = 0

            if btn == sender {
                selectedIndex = buttonIndex
                delegate?.didSelect(type: categories[buttonIndex])
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.layer.borderWidth = 1

            }
        }
    }
}

//Configuration View
private extension CategorySegmentControl {
     func updateView() {
        createButton()
        configStackView()
    }
    
     func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        for button in buttons {
            button.addConstraintsForSize(width: (self.frame.width/CGFloat(buttons.count)) - sizeConstants.offset, height: sizeConstants.buttonHeight)
        }
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.setIdentifier(Identifiers.segmentControlStack)
        addSubview(stack)
        addConstraints(for: stack, value: sizeConstants.padding)
    }
    
     func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category.rawValue.capitalized, for: .normal)
            button.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0
            button.layer.borderColor = UIColor.brandPurple.cgColor
            button.setIdentifier(Identifiers.button(category))
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].layer.borderWidth = 1

    }
}

extension CategorySegmentControl {
    struct sizeConstants {
        static let padding = CGFloat(5.0)
        static let offset = CGFloat(20)
        static let buttonHeight = CGFloat(30)

    }
}

extension CategorySegmentControl {
    enum Identifiers: AccessibilityIdentifying {
        case segmentControlStack
        case button(CategoryType)
    }
}
