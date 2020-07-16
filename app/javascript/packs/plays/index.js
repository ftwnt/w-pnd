const resetTimer = () => {
  return [10, 0]
}

const setGameValues = (timer, src) => {
  document.getElementById('current-timer-val').innerHTML = timer
  let img = document.getElementById('current-img')
  img.src = src
  img.style.display = 'block'
}

const getImageUrl = (idx) => {
  return gon.gameCollection[idx].url
}

const gameHandler = () => {
  if (gon.gameCollection.length === 0) { return }

  let [timer, idx] = resetTimer()
  let imgSrc = getImageUrl(idx)
  setGameValues(timer, imgSrc)

  setInterval(() => {
    if (timer === 1) {
      [timer, idx] = resetTimer()
    } else {
      timer--
      idx++
    }

    imgSrc = getImageUrl(idx)
    setGameValues(timer, imgSrc)
  }, 1000)
}

document.addEventListener("DOMContentLoaded", () => {
  document.querySelector('#game-container')
          .addEventListener('load', gameHandler());
})
