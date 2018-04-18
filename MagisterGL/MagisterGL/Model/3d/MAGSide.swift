//
//  MAGSide.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 05.03.18.
//  Copyright © 2018 Хохлова Татьяна. All rights reserved.
//


import Foundation
import SceneKit


enum PositionType {
   case Left
   case Front
   case Bottom
   case Right
   case Back
   case Top
}


class MAGSide: NSObject
{
   /**
    Массив одной стороны шестигранника - 4 точки (+1 center)
    */
   var positions: [SCNVector3] = []
   var positionType: PositionType
   var isVisible: Bool
   var material: Int
   var colors: [SCNVector3] = []
   
   init(positions: [SCNVector3],
        positionType: PositionType,
        material: Int,
        isVisible: Bool)
   {
      self.positions = positions
      self.positionType = positionType
      self.material = material
      self.isVisible = isVisible
      
      self.positions.append(
         MAGSide.getCenterFor(first: positions[0], second: positions[2]))
   }
   
   static func getCenterFor(first: SCNVector3, second: SCNVector3) -> SCNVector3
   {
      let x: Float = (first.x + second.x) / 2
      let y: Float = (first.y + second.y) / 2
      let z: Float = (first.z + second.z) / 2
      return SCNVector3Make(x, y, z)
   }
   
   func normalsArray() -> [SCNVector3]
   {
      switch positionType
      {
      case .Left:
         return [SCNVector3Make(-1, 0, 0),
                 SCNVector3Make(-1, 0, 0),
                 SCNVector3Make(-1, 0, 0),
                 SCNVector3Make(-1, 0, 0)]
         
      case .Front:
         return [SCNVector3Make(0, 1, 0),
                 SCNVector3Make(0, 1, 0),
                 SCNVector3Make(0, 1, 0),
                 SCNVector3Make(0, 1, 0)]
         
      case .Bottom:
         return [SCNVector3Make( 0, 0, -1),
                 SCNVector3Make( 0, 0, -1),
                 SCNVector3Make( 0, 0, -1),
                 SCNVector3Make( 0, 0, -1)]
         
      case .Right:
         return [SCNVector3Make( 1, 0, 0),
                 SCNVector3Make( 1, 0, 0),
                 SCNVector3Make( 1, 0, 0),
                 SCNVector3Make( 1, 0, 0)]
         
      case .Back:
         return [SCNVector3Make( 0, -1, 0),
                 SCNVector3Make( 0, -1, 0),
                 SCNVector3Make( 0, -1, 0),
                 SCNVector3Make( 0, -1, 0)]
         
      case .Top:
         return [SCNVector3Make( 0, 0, 1),
                 SCNVector3Make( 0, 0, 1),
                 SCNVector3Make( 0, 0, 1),
                 SCNVector3Make( 0, 0, 1)]
      }
   }
   
   //   func indicesArray(addValue: Int32) -> [Int32]
   //   {
   //      return [0 + addValue, 3 + addValue, 1 + addValue,
   //              3 + addValue, 2 + addValue, 1 + addValue]
   //   }
   
   func indicesArray(addValue: Int32) -> [Int32]
   {
      return [0 + addValue, 3 + addValue, 4 + addValue,
              3 + addValue, 2 + addValue, 4 + addValue,
              2 + addValue, 1 + addValue, 4 + addValue,
              1 + addValue, 0 + addValue, 4 + addValue]
   }
   
   func generateCenterColor()
   {
      var resColor: SCNVector3 = SCNVector3Zero
      if (colors.count > 1) {
         for color in colors {
            resColor.x += color.x
            resColor.y += color.y
            resColor.z += color.z
         }
         resColor.x /= Float(colors.count)
         resColor.y /= Float(colors.count)
         resColor.z /= Float(colors.count)
      }
      self.colors.append(resColor)
   }
}
