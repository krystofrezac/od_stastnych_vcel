const excecJSAfter = {
  mounted() {
    setTimeout(()=>{
      window.liveSocket.execJS(
        this.el,
        this.el.getAttribute("after-js")
      )
    }, +this.el.getAttribute("after"))
  }
}
export default excecJSAfter;
