
//
//  FacialExpression.swift
//  FaceIt
//
//  Created by CS193p Instructor.
//  Copyright © 2015-16 Stanford University. All rights reserved.
//

import Foundation

// UI-independent representation of a facial expression

struct FacialExpression
{
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows: Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        var sadder:Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        var happier:Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var sadder:FacialExpression{
        return FacialExpression(eyes:self.eyes, mouth:self.mouth.sadder)
    }
    
    var happier:FacialExpression{
        return FacialExpression(eyes:self.eyes, mouth:self.mouth.happier)
    }
    var eyes: Eyes
   // var eyeBrows: EyeBrows
    var mouth: Mouth
}
