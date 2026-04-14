const pay = () => {
  if (typeof gon === 'undefined') return
  const payjp = Payjp(gon.public_key)
  const elements = payjp.elements()
  const numberElement = elements.create('cardNumber')
  const expiryElement = elements.create('cardExpiry')
  const cvcElement = elements.create('cardCvc')

  numberElement.mount('#number-form')
  expiryElement.mount('#expiry-form')
  cvcElement.mount('#cvc-form')

  const form = document.getElementById('charge-form')
  form.addEventListener('submit', (e) => {
    e.preventDefault()
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        document.getElementById('charge-form').submit()
      } else {
        const token = response.id
        const renderDom = document.getElementById('charge-form')
        const tokenObj = `<input value="${token}" type="hidden" name="token">`
        renderDom.insertAdjacentHTML('beforeend', tokenObj)
        numberElement.clear()
        expiryElement.clear()
        cvcElement.clear()
        document.getElementById('charge-form').submit()
      }
    })
  })
};

window.addEventListener("turbo:load", pay);