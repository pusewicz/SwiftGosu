import CGosuFFI

public enum WindowFlags: UInt32 {
  case windowed = 0
  case fullscreen = 1
  case resizable = 2
  case borderless = 4
}

public class Window {
  private var window: OpaquePointer?

  public var width: Int32 {
    get { return Gosu_Window_width(window) }
    set(newValue) { Gosu_Window_set_width(window, newValue) }
  }

  public var height: Int32 {
    get { return Gosu_Window_height(window) }
    set(newValue) { Gosu_Window_set_height(window, newValue) }
  }

  public var isFullscreen: Bool {
    get { return Gosu_Window_is_fullscreen(window) }
    set(newValue) { Gosu_Window_set_fullscreen(window, newValue) }
  }

  public var isResizable: Bool {
    get { return Gosu_Window_is_resizable(window) }
    set(newValue) { Gosu_Window_set_resizable(window, newValue) }
  }

  public var updateInterval: Double {
    get { return Gosu_Window_update_interval(window) }
    set(newValue) { Gosu_Window_set_update_interval(window, newValue) }
  }

  public var caption: String {
    get { return String(cString: Gosu_Window_caption(window)) }
    set(newValue) { Gosu_Window_set_caption(window, newValue) }
  }

  public var mouseX: Double {
    get { return Gosu_Window_mouse_x(window) }
    set { Gosu_Window_set_mouse_x(window, newValue) }
  }

  public var mouseY: Double {
    get { return Gosu_Window_mouse_y(window) }
    set { Gosu_Window_set_mouse_y(window, newValue) }
  }

  public init(
    width: Int32, height: Int32, flags: WindowFlags = .windowed, updateInterval: Double = 1000 / 60
  ) {
    // guard type(of: self) != Window.self else {
    //   fatalError("Window cannot be instantiated directly, please subclass it.")
    // }
    window = Gosu_Window_create(width, height, flags.rawValue, updateInterval)
  }

  public func draw() {}
  public func update() {}
  // public func buttonDown(_ buttonId: UInt32) -> Bool {}
  // public func buttonUp(_ buttonId: UInt32) -> Bool {}
  public func needsRedraw() -> Bool { true }
  public func needsCursor() -> Bool { false }
  public func close() {
    closeImmediately()
  }
  public func closeImmediately() {
    Gosu_Window_close_immediately(window)
  }
  public func show() {
    Gosu_Window_show(window)
  }
  public func drop(_ path: String) {}
  public func resize(width: Int32, height: Int32, fullscreen: Bool?) {
    Gosu_Window_resize(window, width, height, fullscreen ?? isFullscreen)
  }
  public func tick() {
    Gosu_Window_tick(window)
  }

  func getUpdatePointer() -> @convention(c) (_ data: UnsafeMutableRawPointer?) -> Void {
    return { [weak self] _data in
      // if let data {
      //   print("update(data: \(data))")
      // }
      self?.update()
    }
  }

  func setUpdate() {
    Gosu_Window_set_update(window, getUpdatePointer(), nil)
  }

  // TODO: Verify that this is needed
  deinit {
    Gosu_Window_destroy(window)
  }
}
