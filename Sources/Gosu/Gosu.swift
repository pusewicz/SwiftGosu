import CGosuFFI

public struct Gosu {
  static var fps: Int32 {
    return Gosu_fps()
  }

  static var version: String {
    return String(cString: Gosu_version())
  }
}
