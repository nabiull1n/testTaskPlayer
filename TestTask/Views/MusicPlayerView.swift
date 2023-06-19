//
//  MusicPlayerView.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//
import UIKit.UIView

protocol PlayerControlsViewDelegate: AnyObject {
    func playerDidTapPlayPauseButton(_ playerControlsView: MusicPlayerView)
    func playerDidTapForwardButton(_ playerControlsView: MusicPlayerView)
    func playerDidTapBackwardButton(_ playerControlsView: MusicPlayerView)
    func playerDidTapCloseButton(_ playerControlsView: MusicPlayerView)
    func playerSliderMoved(_ playControlsView: MusicPlayerView, didSlideSlider value: Float)
}

final class MusicPlayerView: UIView {
    
    private let screenHeight = UIScreen.main.bounds.height
    
    weak var delegate: PlayerControlsViewDelegate?
    
    let canselButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = 2
        button.configuration = configuration
        return button
    }()
    
    let songTitleLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let performerLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let currentTimeLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .left
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let songDurationLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let songDurationSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 100
        slider.value = 0
        slider.setThumbImage(UIImage(), for: .normal)
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        return slider
    }()
    
    private let labelsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 250
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let backwardButton: CustomButton = {
        let button = CustomButton(title: "backward.end")
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let playButton: CustomButton = {
        let button = CustomButton(title: "pause")
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let forwardButton: CustomButton = {
        let button = CustomButton(title: "forward.end")
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let buttonsContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    // MARK: init MusicPlayerView
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(canselButton)
        addSubview(songTitleLabel)
        addSubview(performerLabel)
        addSubview(currentTimeLabel)
        addSubview(songDurationLabel)
        addSubview(songDurationSlider)
        
        labelsContainer.addArrangedSubview(currentTimeLabel)
        labelsContainer.addArrangedSubview(songDurationLabel)
        buttonsContainer.addArrangedSubview(backwardButton)
        buttonsContainer.addArrangedSubview(playButton)
        buttonsContainer.addArrangedSubview(forwardButton)
        containerView.addArrangedSubview(labelsContainer)
        containerView.addArrangedSubview(songDurationSlider)
        
        addSubview(containerView)
        addSubview(buttonsContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    @objc func closeButtonTapped() {
        delegate?.playerDidTapCloseButton(self)
    }
    
    @objc func sliderMoved(sender: UISlider) {
        delegate?.playerSliderMoved(self, didSlideSlider: sender.value)
    }
    
    @objc func playButtonTapped() {
        delegate?.playerDidTapPlayPauseButton(self)
    }
    
    @objc func backwardButtonTapped() {
        delegate?.playerDidTapBackwardButton(self)
    }
    
    @objc func forwardButtonTapped() {
        delegate?.playerDidTapForwardButton(self)
    }
    // MARK: setConstraints
    private func setConstraints() {
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            canselButton.topAnchor.constraint(equalTo: (superview.safeAreaLayoutGuide.topAnchor), constant: 15),
            canselButton.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            
            songTitleLabel.topAnchor.constraint(equalTo: canselButton.bottomAnchor, constant: screenHeight * 0.4),
            songTitleLabel.centerXAnchor.constraint(equalTo: superview.centerXAnchor ),
            songTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            songTitleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            performerLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 5),
            performerLabel.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            performerLabel.heightAnchor.constraint(equalToConstant: 30),
            performerLabel.widthAnchor.constraint(equalToConstant: 250),
            
            containerView.topAnchor.constraint(equalTo: performerLabel.bottomAnchor, constant: screenHeight * 0.03),
            containerView.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            
            buttonsContainer.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: screenHeight * 0.06),
            buttonsContainer.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            buttonsContainer.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
