const payjp = Payjp(pk_test_ecf1558c58c97fd0eaf568ff); // 例: Payjp('pk_test_xxx')
const elements = payjp.elements();
const card = elements.create('card');
card.mount('#number-form');

const form = document.getElementById("charge-form");
form.addEventListener("submit", (e) => {
  e.preventDefault();

  payjp.createToken(card).then((response) => {
    if (response.error) {
      // エラーハンドリング（例：アラート表示など）
    } else {
      const token = response.id;
      const hiddenInput = document.createElement("input");
      hiddenInput.setAttribute("type", "hidden");
      hiddenInput.setAttribute("name", "order_form[token]");
      hiddenInput.setAttribute("value", token);
      form.appendChild(hiddenInput);

      form.submit();
    }
  });
});