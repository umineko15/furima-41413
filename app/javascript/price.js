const setupPriceCalculation = () => {
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

  if (itemPrice.dataset.priceCalculationInitialized === "true") {
    calculatePrice();
    return;
  }

  itemPrice.addEventListener("input", calculatePrice);
  itemPrice.dataset.priceCalculationInitialized = "true";

  calculatePrice();
};

document.addEventListener("turbo:load", setupPriceCalculation);
document.addEventListener("turbo:render", setupPriceCalculation);