// source: Drifting Ruby
import { Controller} from "stimulus"
import jsQR from 'jsqr'

export default class extends Controller {
  static targets = ["canvas","output"]

  initialize() {
    let _this = this
    navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" }})
      .then(function (stream) {
        _this.steam = stream
        _this.video().srcObject = stream
        _this.video().play()
      })

    setInterval(function() {
      _this.tick()
    }, 50)
  }

  disconnect() {
   if (this.stream != undefined) {
     this.stream.getTracks().forEach(function (track) {
       track.stop()
     })
   }
  }

  video() {
    if (this._video == undefined) {
      this._video = document.createElement("video")
    }
    return this._video
  }

  canvas() {
    if (this._canvas == undefined) {
      this._canvas = this.canvasTarget.getContext('2d')
    }
    return this._canvas
  }

  tick() {
    if (this.video().readyState === this.video().HAVE_ENOUGH_DATA) {
      this.canvas().drawImage(this.video(), 0, 0, this.canvasTarget.width, this.canvasTarget.height)
      let imageData = this.canvas().getImageData(0, 0, this.canvasTarget.width, this.canvasTarget.height)
      let code = jsQR(imageData.data, imageData.width, imageData.height, {
        inversionAttempts: 'dontInvert'
      })
      if (code) {
        this.outputTarget.value = code.data
        this.canvasTarget.hidden = true
        this.disconnect()
      }
    }
  }
}