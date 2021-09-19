//  Created by TCode on 19/9/21.

import UIKit

/// `CardBackgroundView` is inspired from: https://github.com/jboullianne/CreditCardView

class CardBackgroundView: UIView {

    // TODO Add Card background type as a parameter when configuring the VC to allow the integrator the option to customize it.

    // Holds Templates For Credit Card Background
    public enum CCBackgroundTemplate {
        case basic(UIColor, UIColor, UIColor)
        case flat(UIColor)
        case curve(UIColor, UIColor, UIColor, UIColor, UIColor)
        case gradient(UIColor, UIColor)
    }

    // Template Used When Creating Card
    var template: CCBackgroundTemplate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // Used to credit background from template
    init(frame: CGRect, template: CCBackgroundTemplate) {
        super.init(frame: frame)
        setupView()
        self.template = template
    }

    func setupView() {
        template = .flat(UIColor(red: 72/255, green: 47/255, blue: 183/255, alpha: 1.0))
        backgroundColor = .clear
        self.layer.masksToBounds = true
    }

    override public func draw(_ rect: CGRect) {
        // Drawing code

        if let template = template {
            switch template {
            case .basic(_, _, _):
                drawBasicTemplate(rect: rect, template: template)
            case .flat(_):
                drawFlatTemplate(rect: rect, template: template)
            case .curve(_, _, _, _, _):
                drawCurveTemplate(rect: rect, template: template)
            case .gradient(_, _):
                drawGradientTemplate(rect: rect, template: template)
            }
        }
    }

    private func drawBasicTemplate(rect: CGRect, template: CCBackgroundTemplate) {
        // Credit Card Background
        if case .basic(let c1, let c2, let c3) = template {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = rect
            gradientLayer.colors = [c1.cgColor, c2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.cornerRadius = 10.0
            self.layer.insertSublayer(gradientLayer, at: 0)

            // Pink Side Clip
            let sideClip = CAShapeLayer()
            let sideClipPath = UIBezierPath()
            sideClipPath.addArc(withCenter: CGPoint(x: 10, y: rect.height - 10), radius: 10.0, startAngle: CGFloat.pi / 2.0, endAngle: CGFloat.pi, clockwise: true)
            sideClipPath.addLine(to: CGPoint(x: 0, y: rect.height / 3.0 ))
            sideClipPath.addLine(to: CGPoint(x: rect.width/10.0 * 4.5, y: rect.height))
            sideClipPath.close()

            sideClip.path = sideClipPath.cgPath
            sideClip.fillColor = c3.cgColor
            self.layer.insertSublayer(sideClip, at: 1)

            let column1 = CAGradientLayer()
            column1.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height/8.0)
            column1.setAffineTransform(CGAffineTransform(rotationAngle: -1 * CGFloat.pi / 4.0).concatenating(CGAffineTransform(translationX: rect.width/8.0, y: rect.height/2.0)))
            column1.colors = [c2.withAlphaComponent(0.7).cgColor, c2.withAlphaComponent(0).cgColor]
            column1.startPoint = CGPoint(x: 0, y: 0.5)
            column1.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(column1, at: 1)

            let column2 = CAGradientLayer()
            column2.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height/4.0)
            column2.setAffineTransform(CGAffineTransform(rotationAngle: -1 * CGFloat.pi / 4.0))
            column2.colors = [c1.withAlphaComponent(0.5).cgColor, c1.withAlphaComponent(0.2).cgColor]
            column2.startPoint = CGPoint(x: 0.2, y: 0)
            column2.endPoint = CGPoint(x: 0.7, y: 1.0)
            self.layer.insertSublayer(column2, at: 1)

            self.layer.masksToBounds = true
            self.backgroundColor = UIColor.clear
        }

    }

    func drawFlatTemplate(rect: CGRect, template: CCBackgroundTemplate) {
        if case .flat(let color) = template {
            self.layer.backgroundColor = color.cgColor
        }
    }

    // Note: This is a long function and should normally be split into multiple smaller functions.
    // However, since this code is not my own creation, I am delaying the beautify process to focus on other, more important aspects of the demo project.
    
    // swiftlint:disable:next function_body_length
    func drawCurveTemplate(rect: CGRect, template: CCBackgroundTemplate) {
        if case .curve(let c1, let c2, let c3, let c4, let c5) = template {
            // Credit Card Background
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = rect
            gradientLayer.colors = [c1.cgColor, c2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.cornerRadius = 10.0
            self.layer.insertSublayer(gradientLayer, at: 0)

            let topCurveLayer = CAShapeLayer()
            let topCurve = UIBezierPath()
            topCurve.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            topCurve.addQuadCurve(to: CGPoint(x: 0, y: -1 * (rect.height/6)), controlPoint: CGPoint(x: rect.width/3, y: (rect.height/4) * 3))
            topCurve.addLine(to: CGPoint(x: 0, y: rect.height))
            topCurve.close()
            topCurveLayer.path = topCurve.cgPath
            topCurveLayer.fillColor = c3.cgColor

            let middleCurveLayer = CAShapeLayer()
            let middleCurve = UIBezierPath()
            middleCurve.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            middleCurve.addQuadCurve(to: CGPoint(x: 0, y: (rect.height/3)), controlPoint: CGPoint(x: rect.width/3, y: (rect.height/4) * 3))
            middleCurve.addLine(to: CGPoint(x: 0, y: rect.height))
            middleCurve.close()
            middleCurveLayer.path = middleCurve.cgPath
            middleCurveLayer.fillColor = c4.cgColor

            let bottomCurveLayer = CAShapeLayer()
            let bottomCurve = UIBezierPath()
            bottomCurve.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            bottomCurve.addQuadCurve(to: CGPoint(x: 0, y: 2 * (rect.height/3)), controlPoint: CGPoint(x: rect.width/3, y: (rect.height/8) * 7))
            bottomCurve.addLine(to: CGPoint(x: 0, y: rect.height))
            bottomCurve.close()
            bottomCurveLayer.path = bottomCurve.cgPath
            bottomCurveLayer.fillColor = c5.cgColor

            self.layer.insertSublayer(bottomCurveLayer, at: 1)
            self.layer.insertSublayer(middleCurveLayer, at: 1)
            self.layer.insertSublayer(topCurveLayer, at: 1)

            let column1 = CAGradientLayer()
            column1.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height/6.0)
            let secondCgAffineTransform = CGAffineTransform(translationX: -1 * rect.width/8.0, y: rect.height/2.0)
            column1.setAffineTransform(CGAffineTransform(rotationAngle: -1 * CGFloat.pi / 4.0).concatenating(secondCgAffineTransform))
            column1.colors = [c2.withAlphaComponent(0.4).cgColor, c1.withAlphaComponent(0.4).cgColor]
            column1.startPoint = CGPoint(x: 0, y: 0.5)
            column1.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(column1, at: 1)

            let column2 = CAGradientLayer()
            column2.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height/6.0)
            column2.setAffineTransform(CGAffineTransform(rotationAngle: -1 * CGFloat.pi / 4.0).concatenating(CGAffineTransform(translationX: rect.width/8.0, y: rect.height/2.0)))
            column2.colors = [c2.withAlphaComponent(0.4).cgColor, c1.withAlphaComponent(0.4).cgColor]
            column2.startPoint = CGPoint(x: 0, y: 0.5)
            column2.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(column2, at: 1)
        }
    }

    func drawGradientTemplate(rect: CGRect, template: CCBackgroundTemplate) {
        switch template {
        case .gradient(let startColor, let endColor):
            // Credit Card Background
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = rect
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.cornerRadius = 10.0
            self.layer.insertSublayer(gradientLayer, at: 0)
            return
        default:
            break
        }

    }
}
