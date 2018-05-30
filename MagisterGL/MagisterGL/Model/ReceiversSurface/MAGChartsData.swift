import UIKit
import SceneKit

class MAGChartsData: NSObject
{
  var minUValue: Float = 0.0
  var maxUValue: Float = 0.0
  var receivers: [[SCNVector3]] = []
  var chartsValues: [[SCNVector3]] = []
  
  var minZValue: Float = 0.0
  var maxZValue: Float = 0.0
  
  var maxZModel: Float = 0.0
  var delta: Float = 0.0
  
  
  func updateZValueChartsData(sortedReceivers: [[SCNVector3]])
  {
    self.receivers = sortedReceivers
    
    var resultChartsPoints: [[SCNVector3]] = []
    var tempPoints: [SCNVector3] = []
    
    if (maxZValue > minUValue) {
      delta = fabsf(minUValue) + fabsf(maxZValue)
    }
    //    else {
    //      delta = minUValue - minZValue
    //    }
    
    for chartsLine in receivers
    {
      tempPoints = []
      for vector in chartsLine
      {
        tempPoints.append(SCNVector3Make(vector.x,
                                         vector.y,
                                         Float(MAGRecieversFuncGenerator.uFunc(x: Double(vector.x),
                                                                               y: Double(vector.y),
                                                                               z: Double(vector.z)))))
      }
      resultChartsPoints.append(tempPoints)
    }
    chartsValues = resultChartsPoints
  }
  
  func generateScaleParameter() -> Float
  {
    return (maxZModel - maxZValue) / (maxUValue - minUValue)
  }
  
  func generateChartsValuesWith(firstReceiver: SCNVector3, rnArray: [[Float]], maxZValue: Float, maxZModel: Float)
  {
    var chartsValuesLine: [SCNVector3] = []
    for i in 0..<rnArray.count {
      let vector: SCNVector3 = SCNVector3Make(firstReceiver.x + rnArray[i][0], firstReceiver.y, rnArray[i][1])
      chartsValuesLine.append(vector)
    }
    chartsValues.append(chartsValuesLine)
    minUValue = rnArray.min(by: { (v1, v2) -> Bool in
      return v1[1] < v2[1]
    })![1]
    maxUValue = rnArray.max(by: { (v1, v2) -> Bool in
      return v1[1] < v2[1]
    })![1]
    
    self.maxZModel = maxZModel
    self.maxZValue = maxZValue
  }
  
}
