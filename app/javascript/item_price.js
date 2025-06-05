document.addEventListener("turbo:load", function () {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", function () {
    const price = parseInt(priceInput.value, 10);

    if (!isNaN(price)) {
      const tax = Math.floor(price * 0.1);
      const profit = price - tax;

      document.getElementById("add-tax-price").textContent = tax.toLocaleString();
      document.getElementById("profit").textContent = profit.toLocaleString();
    } else {
      document.getElementById("add-tax-price").textContent = "-";
      document.getElementById("profit").textContent = "-";
    }
  });
});