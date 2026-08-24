const itemPrice = document.getElementById("item-price");

if (itemPrice) {
  itemPrice.addEventListener("input", () => {
    const price = Number(itemPrice.value);

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    document.getElementById("add-tax-price").textContent = tax;
    document.getElementById("profit").textContent = profit;
  });
}