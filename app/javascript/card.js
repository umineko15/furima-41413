

const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    // 二重送信を防ぐため、トークン取得中はボタンを無効化
    const submitButton = form.querySelector('button[type="submit"]');
    if (submitButton) submitButton.disabled = true;

    try {
      const response = await payjp.createToken(numberElement);

      if (response.error) {
        console.error(response.error);

        if (submitButton) submitButton.disabled = false;
        form.submit();
        return;
      }

      const existingToken = form.querySelector('input[name="token"]');
      if (existingToken) existingToken.remove();

      const tokenInput = document.createElement('input');
      tokenInput.type = 'hidden';
      tokenInput.name = 'token';
      tokenInput.value = response.id;
      form.appendChild(tokenInput);

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit();
    } catch (error) {
      console.error(error);
      alert('カード情報の処理に失敗しました。もう一度お試しください。');
      if (submitButton) submitButton.disabled = false;
    }
  });
};

window.addEventListener('turbo:load', pay);
window.addEventListener("turbo:render", pay);