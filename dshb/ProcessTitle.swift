//
// ProcessTitle.swift
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

import Darwin

public struct ProcessTitle {
    
    var title    : [String]
    let colour   : Int32
    var winCoords: Window
    
    private var titlePadding = String()
    var numChar = 0
    
    
    init(title: [String], winCoords: Window, colour: Int32) {
        self.title     = title
        self.colour    = colour
        self.winCoords = winCoords
        
        computeTitleSpacing()
    }
    
    
    mutating func draw() {
        move(winCoords.pos.y, winCoords.pos.x)
        attrset(colour)
        computeTitleSpacing()
        
        // TODO: Trailing or overflow space
        var str = String()
        for stat in title {
            str += stat + titlePadding
        }
        addstr(str)
    }
    
    
    mutating func resize(winCoords: Window) {
        self.winCoords = winCoords
        computeTitleSpacing()
        draw()
    }
    
    
    private mutating func computeTitleSpacing() {
        numChar = 0
        for stat in title {
            numChar += countElements(stat)
        }
        
        titlePadding = String()
        let spaceLength =  Int(floor(Double(Int(winCoords.length) - numChar) / Double(title.count)))
        
        for var i = 0; i < spaceLength; ++i {
            titlePadding.append(UnicodeScalar(" "))
        }
    }
}
