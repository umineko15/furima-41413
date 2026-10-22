

const pay = () => {
  // ① 購入フォームを取得する
  const form = document.getElementById('charge-form');

  // 購入フォームがないページでは何もしない
  if (!form) return;

  // ② PAY.JPの公開鍵を確認する
  if (typeof gon === 'undefined' || !gon.public_key) {
    console.error('PAY.JPの公開鍵が設定されていません。');
    return;
  }

  // ③ PAY.JPを初期化する
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // ④ カード情報の入力欄を作成する
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // ⑤ 入力欄を画面に表示する
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // ⑥ フォーム送信時の処理
  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    // 二重送信を防ぐ
    const submitButton = form.querySelector('input[type="submit"]');
    if (submitButton) submitButton.disabled = true;

    try {
      // ⑦ カード情報からトークンを作成する
      const response = await payjp.createToken(numberElement);

      // トークン作成に失敗した場合
      if (response.error) {
        console.error(response.error);
        alert('カード情報を確認してください。');

        if (submitButton) submitButton.disabled = false;
        return;
      }

      // ⑧ 古いトークンがあれば削除する
      const existingToken = form.querySelector('input[name="token"]');
      if (existingToken) existingToken.remove();

      // ⑨ 新しいトークンをフォームに追加する
      const tokenInput = document.createElement('input');
      tokenInput.type = 'hidden';
      tokenInput.name = 'token';
      tokenInput.value = response.id;
      form.appendChild(tokenInput);

      // ⑩ カード情報の入力欄をクリアする
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // ⑪ フォームを送信する
      form.submit();

    } catch (error) {
      console.error(error);
      alert('カード情報の処理に失敗しました。もう一度お試しください。');

      if (submitButton) submitButton.disabled = false;
    }
  });
};

// ページ表示時に実行する
window.addEventListener('turbo:load', pay);
window.addEventListener('turbo:render', pay);