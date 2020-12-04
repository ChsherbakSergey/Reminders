//
//  ReminderCollectionViewCell.swift
//  Reminders
//
//  Created by Sergey on 12/5/20.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ReminderCollectionViewCell"
    
    //View that will be displayed on this cell
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let reminderLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.layer.borderWidth = 1
        label.layer.backgroundColor = UIColor.label.cgColor
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frmae of the photoImageView
        titleLabel.frame = CGRect(x: 5, y: 5, width: contentView.width - 10, height: 20)
        reminderLabel.frame = CGRect(x: 5, y: 35, width: contentView.width - 10, height: 50)
        dateLabel.frame = CGRect(x: 10, y: contentView.bottom - 40, width: contentView.width - 20, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        reminderLabel.text = nil
        dateLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        accessibilityLabel = "Reminder"
        accessibilityHint = "Double-tap to open reminder"
        //Adding subview
        contentView.addSubview(titleLabel)
        contentView.addSubview(reminderLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Configures the cell with the provided model
    public func congigure(with model: Reminder) {
        titleLabel.text = model.title
        reminderLabel.text = model.reminder
    }
    
}
