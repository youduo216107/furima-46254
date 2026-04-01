const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = Number(priceInput.value);
    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    document.getElementById("add-tax-price").innerHTML = tax.toLocaleString();
    document.getElementById("profit").innerHTML = profit.toLocaleString();
  });
};

document.addEventListener("turbo:load", price);
document.addEventListener("turbo:render", price);
price();