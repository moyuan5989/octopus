

import Foundation





enum BgChoosing: Int {
    case bg1,bg2,bg3,bg4,bg5,bg6,bg7
    
}

enum DiffucultyChoosing: Int {
    case easy,medium,hard
    
}


class Model:NSObject {
    
    class var sharedInstance:Model{
        struct Static{
            static var instance:Model?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token){
            Static.instance = Model()
        }
        return Static.instance!
        
    }
    
    var rateBool = false
    var ShieldAddBool = false
    var bgcount = 0
    
    var totalscore = 0
    var ADCount = 0 
    var score = 0
    var shieldBool = false
    var highcore = 0
    var sound = true
    
}