// The Swift Programming Language
// https://docs.swift.org/swift-book

import CGosuFFI

let updateInterval: Double = 1000 / 60
let version = String(cString: Gosu_version())

let window = Gosu_Window_create(800, 600, Gosu_WF_WINDOWED, updateInterval)
let windowWidth = Gosu_Window_width(window)
let windowHeight = Gosu_Window_height(window)
let windowUpdateInterval = Gosu_Window_update_interval(window)
let color = Gosu_Color_create_argb(255, 255, 0, 0)
let font = Gosu_Font_create(16, "Arial", Gosu_FF_BOLD, Gosu_BM_DEFAULT)

Gosu_Window_set_caption(window, "Hello, SwiftGosu v\(version)!")

var data: UnsafeMutableRawPointer!

func update(data: UnsafeMutableRawPointer?) {
  if Gosu_button_down(Int32(Gosu_KB_ESCAPE)) == 1 {
    print("ESC pressed, closing window...")
    Gosu_Window_close_immediately(window)
  }
}

func draw(data: UnsafeMutableRawPointer?) {
  Gosu_draw_line(0, 0, color, 100, 100, color, 0, Gosu_BM_DEFAULT)

  Gosu_Font_draw_text(font, "Hello, SwiftGosu!", 10, 10, 0, 1, 1, color, Gosu_BM_DEFAULT)
  Gosu_Font_draw_text(font, "FPS: \(Gosu_fps())", 10, 24, 0, 1, 1, color, Gosu_BM_DEFAULT)
}

Gosu_Window_set_update(window, update, data)
Gosu_Window_set_draw(window, draw, data)

print("Window size: \(windowWidth)x\(windowHeight)@\(windowUpdateInterval)ms")
Gosu_Window_show(window)

Gosu_Font_destroy(font)

print("Bye!")
