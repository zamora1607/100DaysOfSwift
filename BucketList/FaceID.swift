//
//  FaceID.swift
//  BucketList
//
//  Created by Ania on 16/12/2020.
//

import SwiftUI
import LocalAuthentication

struct FaceID: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }.onAppear(perform:authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        //problem
                    }
                }
            }
        } else {
            //no biometric
        }
    }
}

struct FaceID_Previews: PreviewProvider {
    static var previews: some View {
        FaceID()
    }
}
