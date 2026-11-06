document.addEventListener("turbo:load", () => {
  const itemPrice = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!itemPrice || !taxPrice || !profit) return;

  const calculatePrice = () => {
    const price = Number(itemPrice.value);

    const tax = Math.floor(price * 0.1);
    const profitAmount = price - tax;

    taxPrice.textContent = tax;
    profit.textContent = profitAmount;
  };

  itemPrice.addEventListener("input", calculatePrice);
  calculatePrice();
});