
const payjp = Payjp(gon.public_key);
const elements = payjp.elements();

const card = elements.create('cardNumber');
card.mount('#number-form');

const expiry = elements.create('cardExpiry');
expiry.mount('#expiry-form');

const cvc = elements.create('cardCvc');
cvc.mount('#cvc-form');

const form = document.getElementById("charge-form");
const submitBtn = document.querySelector("#charge-form input[type='submit']");

form.addEventListener("submit", (e) => {
  e.preventDefault();
  submitBtn.disabled = true;

  payjp.createToken(card).then((response) => {
    if (response.error) {
      alert(response.error.message);

      submitBtn.disabled = false;
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