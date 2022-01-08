const onMountExecJS = {
  mounted() {
    setTimeout(()=>{
      window.liveSocket.execJS(
        this.el,
        this.el.getAttribute("on-mount-js")
      )
    })
  }
}
export default onMountExecJS;
