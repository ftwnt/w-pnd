import * as elements from './dataElements'

const resetTimer = () => {
  return [10, 0]
}

const setGameValues = (timer, src, id) => {
  elements.timerElement().innerHTML = timer
  elements.timerInput().value = timer

  elements.imageElement().src = src
  elements.imageElement().style.display = 'block'
  elements.imageInput().value = id
}

const imageObj = (idx) => {
  return gon.gameCollection[idx]
}

export const gameHandler = () => {
  if (gon.gameCollection.length === 0) { return }

  let [timer, idx] = resetTimer()
  setGameValues(timer, imageObj(idx).url, imageObj(idx).id)

  setInterval(() => {
    if (timer === 1) {
      [timer, idx] = resetTimer()
    } else {
      timer--
      idx++
    }

    setGameValues(timer, imageObj(idx).url, imageObj(idx).id)
  }, 1000)
}
