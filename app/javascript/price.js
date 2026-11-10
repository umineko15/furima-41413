document.addEventListener("turbo:load", () => {
  console.log("turbo:load が実行されました");
  const itemPrice = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!itemPrice || !taxPrice || !profit) {
    console.log("価格計算に必要なHTML要素が見つかりません");
    return;
  }

  console.log("価格計算の準備ができました");

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