const formInput = {
  updated() {
    const inputName = this.el.getAttribute("input_name");
    const input = document.querySelector(`[name="${inputName}"]`);

    const error = document.querySelector(`[phx-feedback-for="${inputName}"]`);

    if(!error)
      return;

    const isErrorHidden = error.classList.contains("phx-no-feedback") 

    if(!isErrorHidden)
      input.classList.add("input-error")
  }
}
export default formInput;
