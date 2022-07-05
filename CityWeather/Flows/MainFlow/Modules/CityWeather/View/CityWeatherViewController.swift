//
//  CityWeatherViewController.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import UIKit
import MapKit

final class CityWeatherViewController: UIViewController, StoryboardLoadable, CityWeatherViewInput {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var headerContainerView: UIView!
    private var headerImageView: UIImageView!
    
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!
    
    private var stackView: UIStackView!
    
    private var descriptionImageView = UIImageView(image: UIImage(systemName: "info.circle"))
    private var currentTempImageView = UIImageView(image: UIImage(systemName: "thermometer"))
    private var minMaxTempImageView = UIImageView(image: UIImage(systemName: "thermometer"))
    private var humidityImageView = UIImageView(image: UIImage(systemName: "humidity"))
    private var windSpeedImageView = UIImageView(image: UIImage(systemName: "wind"))
    
    private var descriptionLabel = UILabel()
    private var currentTempLabel = UILabel()
    private var minMaxTempLabel = UILabel()
    private var humidityLabel = UILabel()
    private var windSpeedLabel = UILabel()
    
    private lazy var labelsImageViews: [(label: UILabel, imageView: UIImageView)] = [
        (descriptionLabel, descriptionImageView),
        (currentTempLabel, currentTempImageView),
        (minMaxTempLabel, minMaxTempImageView),
        (humidityLabel, humidityImageView),
        (windSpeedLabel, windSpeedImageView)
    ]
        
    private var headerViewHeightConstant: CGFloat {
        view.bounds.height / 3
    }
    
    var presenter: CityWeatherViewOutput?
    var initialLocation: Coordinates?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        configureUI()
        presenter?.viewDidFinishLoading(with: initialLocation)
    }
    
    func configureUI(with vmodel: WeatherInfoViewModel) {
        descriptionLabel.text = vmodel.description
        currentTempLabel.text = vmodel.currentTemp
        minMaxTempLabel.text = vmodel.minMaxTemp
        humidityLabel.text = vmodel.humidity
        windSpeedLabel.text = vmodel.windSpeed
        
        labelsImageViews.forEach { $0.imageView.isHidden = false }
    }
}

// MARK: - Private
private extension CityWeatherViewController {
    
    func configureUI() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        
        headerContainerView = createHeaderContainerView()
        headerImageView = createHeaderImageView()
        headerContainerView.addSubview(headerImageView)
        
        stackView = createMainStackView()
        
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        arrangeConstraints()
        
        takeSnapshot(of: initialLocation)
    }
    
    func createHorizontalStackView(label: UILabel, imageView: UIImageView) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.isHidden = true
        let imageViewConstraints: [NSLayoutConstraint] = [
            imageView.widthAnchor.constraint(equalToConstant: 27),
            imageView.heightAnchor.constraint(equalToConstant: 27)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    func createHeaderContainerView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createMainStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
                
        labelsImageViews.forEach {
            let hstack = createHorizontalStackView(label: $0.label, imageView: $0.imageView)
            stackView.addArrangedSubview(hstack)
        }
        
        return stackView
    }

    func createHeaderImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        
        return imageView
    }
    
    func arrangeConstraints() {

        headerTopConstraint = headerContainerView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerHeightConstraint = headerContainerView.heightAnchor
            .constraint(equalToConstant: headerViewHeightConstant)
        let headerContainerViewConstraints: [NSLayoutConstraint] = [
            headerTopConstraint,
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            headerHeightConstraint
        ]
        NSLayoutConstraint.activate(headerContainerViewConstraints)

        let headerImageViewConstraints: [NSLayoutConstraint] = [
            headerImageView.topAnchor
                .constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor
                .constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor
                .constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor
                .constraint(equalTo: headerContainerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(headerImageViewConstraints)

        let stackConstraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(stackConstraints)
    }
    
    func takeSnapshot(of coordinates: Coordinates?) {
        
        guard let requiredCoords = coordinates else {
            return
        }
        
        let location = CLLocation(latitude: requiredCoords.lat, longitude: requiredCoords.lon)

        let options = MKMapSnapshotter.Options()

        options.camera = MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 1000, pitch: 0, heading: 0)
        options.size = CGSize(width: view.bounds.width, height: headerViewHeightConstant)

        let snapshotter = MKMapSnapshotter(options: options)

        snapshotter.start { [weak self] (snapshot, error) in
            guard error == nil, let snapshot = snapshot else { return }

            UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
            snapshot.image.draw(at: .zero)

            let titleAttributes = self?.titleAttributes()
            let annotation = MKPointAnnotation()
            annotation.title = self?.title
            annotation.coordinate = location.coordinate

            let point = snapshot.point(for: annotation.coordinate)
            self?.drawPin(point: point, annotation: annotation)

            if let title = annotation.title {
                self?.drawTitle(title: title, at: point, attributes: titleAttributes!)
            }

            let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
            self?.headerImageView.image = compositeImage
            UIGraphicsEndImageContext()
        }
    }
    
    private func drawTitle(title: String, at point: CGPoint, attributes: [NSAttributedString.Key: NSObject]) {
        let titleSize = title.size(withAttributes: attributes)
        title.draw(
            with: CGRect(
                x: point.x - titleSize.width / 2.0,
                y: point.y + 1,
                width: titleSize.width,
                height: titleSize.height),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil)
    }

    func titleAttributes() -> [NSAttributedString.Key: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let titleFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        let attributes = [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        return attributes
    }

    func drawPin(point: CGPoint, annotation: MKAnnotation) {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "whatever")
        annotationView.contentMode = .scaleAspectFit
        annotationView.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        annotationView.drawHierarchy(
            in: CGRect(
                x: point.x - annotationView.bounds.size.width / 2.0,
                y: point.y - annotationView.bounds.size.height,
                width: annotationView.bounds.width,
                height: annotationView.bounds.height),
            afterScreenUpdates: true)
    }
}

// MARK: - UIScrollViewDelegate
extension CityWeatherViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = headerViewHeightConstant - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / headerViewHeightConstant
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = headerViewHeightConstant - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
    }
}
