// The Swift Programming Language
// https://docs.swift.org/swift-book

import CGosuFFI

class GameWindow: Window {
  init(width: Int32, height: Int32) {
    super.init(width: width, height: height)
  }

  public override func update() {
    if Gosu_button_down(Int32(Gosu_KB_ESCAPE)) == 1 {
      print("ESC pressed, closing window...")
      close()
    }
  }

  public override func draw() {
    Gosu_draw_line(0, 0, color, 100, 100, color, 0, Gosu_BM_DEFAULT)
    Gosu_Font_draw_text(font, "Hello, SwiftGosu!", 10, 10, 0, 1, 1, color, Gosu_BM_DEFAULT)
    Gosu_Font_draw_text(font, "FPS: \(Gosu_fps())", 10, 24, 0, 1, 1, color, Gosu_BM_DEFAULT)
  }
}

let window = GameWindow.init(width: 640, height: 480)
let color = Gosu_Color_create_argb(255, 255, 0, 0)
let font = Gosu_Font_create(16, "Arial", Gosu_FF_BOLD, Gosu_BM_DEFAULT)

window.caption = "Hello, SwiftGosu v\(Gosu.version)!"

// var data: UnsafeMutableRawPointer!

// func update(data: UnsafeMutableRawPointer?) {
//   if Gosu_button_down(Int32(Gosu_KB_ESCAPE)) == 1 {
//     print("ESC pressed, closing window...")
//     Gosu_Window_close_immediately(window)
//   }
// }

// func draw(data: UnsafeMutableRawPointer?) {
//   Gosu_draw_line(0, 0, color, 100, 100, color, 0, Gosu_BM_DEFAULT)

//   Gosu_Font_draw_text(font, "Hello, SwiftGosu!", 10, 10, 0, 1, 1, color, Gosu_BM_DEFAULT)
//   Gosu_Font_draw_text(font, "FPS: \(Gosu_fps())", 10, 24, 0, 1, 1, color, Gosu_BM_DEFAULT)
// }

// Gosu_Window_set_update(window, update, data)
// Gosu_Window_set_draw(window, draw, data)

print("Window size: \(window.width)x\(window.height)@\(window.updateInterval)ms")
window.show()

Gosu_Font_destroy(font)

print("Bye!")
