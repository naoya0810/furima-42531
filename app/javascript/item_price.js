// document.addEventListener("turbo:load", function () {
//   const priceInput = document.getElementById("item-price");
//   if (!priceInput) return;

//   priceInput.addEventListener("input", function () {
//     const price = parseInt(priceInput.value, 10);

//     if (!isNaN(price)) {
//       const tax = Math.floor(price * 0.1);
//       const profit = price - tax;

//       document.getElementById("add-tax-price").textContent = tax.toLocaleString();
//       document.getElementById("profit").textContent = profit.toLocaleString();
//     } else {
//       document.getElementById("add-tax-price").textContent = "-";
//       document.getElementById("profit").textContent = "-";
//     }
//   });
// });
function setupPriceCalc() {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value);

    if (isNaN(price) || price < 300 || price > 9999999) {
      taxOutput.textContent = "";
      profitOutput.textContent = "";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    taxOutput.textContent = tax;
    profitOutput.textContent = profit;
  });
}

// Turboによる画面描画に対応
document.addEventListener("turbo:load", setupPriceCalc);
document.addEventListener("turbo:render", setupPriceCalc);