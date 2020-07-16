import { gameHandler } from './game'

document.addEventListener("DOMContentLoaded", () => {
  document.querySelector('#game-container')
          .addEventListener('load', gameHandler());
})
