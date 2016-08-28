//
//  TcpClient.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 23/07/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

public class TcpClient {
    
    var socket: GCDAsyncSocket!
    
    init() {
        
    }
    
    public func connect() {
        let queue = dispatch_queue_create("socket_queue", nil)
        self.socket = GCDAsyncSocket(delegate: self, delegateQueue: queue)
        do {
            try self.socket.connectToHost("192.168.1.203", onPort: 8765)
        } catch {
            print("error, cannot connect")
        }
    }
    
    public func updateSpeed(let speedLeft: Int, let speedRight: Int) {
        let strMessage = "engines_pow:\(speedLeft):\(speedRight)"
        self.sendMessage(strMessage)
    }
    
    public func close() {
        let strMessage = "bye"
        self.sendMessage(strMessage)
    }
    
    private func sendMessage(strMessage: String) {
        if let msg = strMessage.stringByAppendingString("\n").dataUsingEncoding(NSUTF8StringEncoding) {
            self.socket.writeData(msg, withTimeout: 1, tag: 1)
        }
    }
}


extension TcpClient: GCDAsyncSocketDelegate {
    @objc public func socket(sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("connected")
        if let msg = "hello robot".dataUsingEncoding(NSUTF8StringEncoding) {
            sock.writeData(msg, withTimeout: 1, tag: 0)
        }
    }
    
    @objc public func socket(sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("ready")
    }
}