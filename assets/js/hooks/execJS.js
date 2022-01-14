const excecJSAfter = {
  updated() {
    if(this.el.hasAttribute("exec"))
      setTimeout(()=>{
        window.liveSocket.execJS(
          this.el,
          this.el.getAttribute("exec-js")
        )
      })
  }
}
export default excecJSAfter;
