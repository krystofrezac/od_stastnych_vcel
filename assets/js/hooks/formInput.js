const formInput = {
  updated() {
    const inputName = this.el.getAttribute("input_name");
    const input = document.querySelector(`[name="${inputName}"]`);

    const error = document.querySelector(`[phx-feedback-for="${inputName}"]`);

    if(!error)
      return;

    const isErrorHidden = error.classList.contains("phx-no-feedback") 

    const nodeName = input.nodeName

    if(!isErrorHidden){
      if(nodeName == "INPUT")
        input.classList.add("input-error")
      if(nodeName == "TEXTAREA")
        input.classList.add("textarea-error")
    }
  }
}
export default formInput;
