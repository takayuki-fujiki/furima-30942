window.addEventListener('load', () => {
  const inputPrice = document.getElementById("item-price");
  inputPrice.addEventListener("input", () => {
    const inputValue = inputPrice.value;
    //console.log(inputValue);
    const insentive = document.getElementById("add-tax-price");
    insentive.innerHTML = Math.floor(inputPrice.value / 10 );
  
    const profit = document.getElementById("profit");
    profit.innerHTML = (inputPrice.value - Math.floor(inputPrice.value / 10 ))  ;  
  })
})