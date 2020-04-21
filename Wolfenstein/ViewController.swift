//
//  ViewController.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    let panRecognizer = UIPanGestureRecognizer()

    var world = World(
        player: Player(position: Vector(x: 2.5, y: 2.5),
                       velocity: Vector(x: 0, y: 0),
                       direction: Vector(x: 1, y: 0)),
        map: loadMap()!)

    var previousTime: Double = CACurrentMediaTime()

    var joystickVector: Vector {
        let joystickRadius: Double = 40.0

        let translation = panRecognizer.translation(in: view)
        let vector = Vector(x: Double(translation.x), y: Double(translation.y))
        let result = vector / max(joystickRadius, vector.length)
        panRecognizer.setTranslation(CGPoint(x: result.x * joystickRadius, y: result.y * joystickRadius), in: view)
        return result
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addGestureRecognizer(panRecognizer)
        imageView.layer.magnificationFilter = .nearest

        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
    }

    @objc func update(_ displayLink: CADisplayLink) {
//        var renderer = Renderer(width: 256, height: 256)
        var renderer = Renderer3D(width: 256, height: 256)
        let timestep = displayLink.timestamp - previousTime

        world.update(timestep: timestep, input: joystickVector)
        renderer.draw(world: world)

        previousTime = displayLink.timestamp
        imageView.image = UIImage(bitmap: renderer.bitmap)
    }
}

func loadMap() -> Tilemap? {
    guard let url = Bundle.main.url(forResource: "map", withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
            return nil
    }
    return try? JSONDecoder().decode(Tilemap.self, from: data)
}

extension UIImage {
    convenience init?(bitmap: Bitmap) {
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        let bytesPerPixel = MemoryLayout<Color>.stride
        let bytesPerRow = bitmap.width * bytesPerPixel

        guard let providerRef = CGDataProvider(data: Data(bytes: bitmap.pixels, count: bitmap.height * bytesPerRow) as CFData) else {
            return nil
        }

        guard let cgImage = CGImage(
            width: bitmap.width,
            height: bitmap.height,
            bitsPerComponent: 8,
            bitsPerPixel: bytesPerPixel * 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: alphaInfo.rawValue),
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        ) else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}

