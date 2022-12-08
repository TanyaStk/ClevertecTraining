//
//  ViewController.swift
//  ClevertecTraining
//
//  Created by Tanya Samastroyenka on 07.12.2022.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    private let languages = [(lang: "English", code: "en"),
                             (lang: "Russian", code: "ru"),
                             (lang: "Belarusian", code: "be-BY")]
    
    private lazy var selectedLanguage = languages[0]
    
    private let logoImageView: UIImageView = {
        let image = UIImage(named: "LogoIcon")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(named: "UIElementsColor")
        return imageView
    }()
    
    private let greetingTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hello!"
        textView.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textView.textColor = UIColor(named: "TextColor")
        textView.textAlignment = .center
        textView.backgroundColor = UIColor(named: "UIElementsColor")
        textView.clipsToBounds = true
        textView.layer.cornerRadius = Constants.cornerRadius
        return textView
    }()
    
    private let languagePicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tintColor = UIColor(named: "TextColor")
        pickerView.setValue(UIColor(named: "UIElementsColor"), forKey: "textColor")
        return pickerView
    }()
    
    private let lightModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Light", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIElementsColor")
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                         action: #selector(setLightMode),
                         for: .touchUpInside)
        return button
    }()
    
    private let darkModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dark", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIElementsColor")
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                         action: #selector(setDarkMode),
                         for: .touchUpInside)
        return button
    }()

    private let defaultModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Default", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIElementsColor")
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                         action: #selector(setDefaultMode),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(Constants.offset)
        [self.lightModeButton,
         self.darkModeButton,
         self.defaultModeButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        addSubviews()
        setConstraints()
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(greetingTextView)
        view.addSubview(languagePicker)
        view.addSubview(buttonsStackView)
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(logoImageView.snp.width)
        }
        
        greetingTextView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
            make.top.equalTo(logoImageView.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constants.heightMultiplier)
        }
        
        languagePicker.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Constants.heightMultiplier)
            make.top.equalTo(greetingTextView.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
            make.height.equalToSuperview().multipliedBy(Constants.heightMultiplier)
            make.top.equalTo(languagePicker.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
        }
    }
    
    private func changeLanguage(lang: String) {
        greetingTextView.text = "Hello!".localized(lang)
        lightModeButton.setTitle("Light".localized(lang), for: .normal)
        darkModeButton.setTitle("Dark".localized(lang), for: .normal)
        defaultModeButton.setTitle("Default".localized(lang), for: .normal)
        languagePicker.reloadAllComponents()
    }
    
    @objc func setLightMode() {
        overrideUserInterfaceStyle = .light
    }
    
    @objc func setDarkMode() {
        overrideUserInterfaceStyle = .dark
    }
    
    @objc func setDefaultMode() {
        overrideUserInterfaceStyle = .unspecified
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].lang.localized(selectedLanguage.code)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeLanguage(lang: languages[row].code)
        selectedLanguage = languages[row]
    }
}
