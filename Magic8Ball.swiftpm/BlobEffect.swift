//
//  BlobEffect.swift
//  Magic8Ball
//
//  Created by Daniel Moreno on 4/7/25.
//

import SwiftUI

struct BlobShape: Shape {
    var phase: CGFloat
    var intensity: CGFloat = 1.0

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let points = 24  // More points = smoother blob
        let variation: CGFloat = 0.04

        var path = Path()
        var vertices: [CGPoint] = []

        for i in 0..<points {
            let percent = CGFloat(i) / CGFloat(points)
            let angle = percent * .pi * 2

            let offset = (
                sin(angle + phase) * 1.5 +                      // main wobble
                cos(angle * 1.5 + phase) * 0.6 +                // second wave, wider
                sin(angle * 3.0 + phase) * 0.3 +                // more ripples
                cos(angle * 5.0 + phase * 1.2) * 0.2 +          // fast detail
                sin(angle * 7.0 - phase * 0.8) * 0.1            // super fine grain
            ) * variation * 1.4 * intensity
            
            let adjustedRadius = radius * (1 + offset)

            let x = center.x + adjustedRadius * cos(angle)
            let y = center.y + adjustedRadius * sin(angle)
            vertices.append(CGPoint(x: x, y: y))
        }

        path.move(to: vertices[0])

        for i in 0..<vertices.count {
            let current = vertices[i]
            let next = vertices[(i + 1) % vertices.count]
            let mid = CGPoint(x: (current.x + next.x) / 2,
                              y: (current.y + next.y) / 2)
            path.addQuadCurve(to: mid, control: current)
        }

        path.closeSubpath()
        return path
    }

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
}
