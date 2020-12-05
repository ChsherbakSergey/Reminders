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
        label.textColor = .white
        return label
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.dateStyle = .short
        formatter.string(from: Date())
        return formatter
    }()
    
    private let reminderLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the photoImageView
        titleLabel.frame = CGRect(x: 15, y: 12.5, width: contentView.width - 30, height: 20)
        reminderLabel.frame = CGRect(x: 15, y: 32.5, width: contentView.width - 30, height: 70)
        dateLabel.frame = CGRect(x: 15, y: contentView.bottom - 40, width: contentView.width - 30, height: 27.5)
        dateLabel.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        reminderLabel.text = nil
        dateLabel.text = nil
        contentView.backgroundColor = nil
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
        contentView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Configures the cell with the provided model
    public func congigure(with model: Reminder) {
        titleLabel.text = model.title
        reminderLabel.text = model.reminder
        dateLabel.text = formatter.string(from: model.date)
        contentView.backgroundColor = model.color
    }
    
}
