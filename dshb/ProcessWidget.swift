//
// ProcessWidget.swift
// dshb
//
// The MIT License
//
// Copyright (C) 2014, 2015  beltex <https://github.com/beltex>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public struct ProcessWidget: Widget {
    
    private var meters = [Meter]()
    var title : ProcessTitle
    var win   : Window
    
    let titleStats = ["PID", "COMMAND", "PPID", "PGID", "UID", "ARCH", "STATUS"]
    
    //var p : ProcessTitle
    
    init(win: Window = Window()) {
        self.win = win
        
        // Title init
        let titleCoords = Window(length: Int(COLS),
                                 pos: (x:win.pos.x, y:win.pos.y))
        title = ProcessTitle(title: titleStats,
                            winCoords: titleCoords,
                            colour: COLOR_PAIR(5))
        
        
//        p = ProcessTitle(title: [""], winCoords: Window(length: Int(COLS),
//            pos: (x:win.pos.x, y:win.pos.y + 1)), colour:COLOR_PAIR(Int32(4)))
    }
    
    mutating func draw() {
        let procList = ProcessAPI.list()
//        p.title = [String(procList[0].pid), String(procList[0].command), String(procList[0].ppid),
//                   String(procList[0].pgid), String(procList[0].uid), String(procList[0].arch), String(procList[0].status)]
        //p.draw()
        
        var yShift = 1
        for proc in procList {
            if (win.pos.y + yShift) > Int32(COLS) {
                break
            }
            let t = [String(proc.pid), String(proc.command), String(proc.ppid),
                String(proc.pgid), String(proc.uid), String(proc.arch), String(proc.status)]
            var p2 = ProcessTitle(title: t, winCoords: Window(length: Int(COLS),
                pos: (x:win.pos.x, y:win.pos.y + yShift)), colour: COLOR_PAIR(Int32(4)))
            
            p2.draw()
            yShift++
        }
    }
    
    mutating func resize(newCoords: Window) -> Int32 {
        win = newCoords
        title.resize(win)
        
        //p.resize(Window(length: win.length, pos: (x: win.pos.x, y: win.pos.y + 1)))

        return win.pos.y + 1 // Becuase of title
    }
}