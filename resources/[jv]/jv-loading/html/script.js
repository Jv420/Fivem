const tips = [
  'Tip: blijf in character tijdens roleplay.',
  'Tip: gebruik /report als je hulp nodig hebt.',
  'Tip: verdien geld met legale jobs en bouw je imperium.',
  'Tip: respecteer staff en andere spelers.',
  'Tip: join Discord voor updates en regels.'
];

let progress = 20;
let index = 0;
const progressBar = document.getElementById('progress');
const tip = document.getElementById('tip');

setInterval(() => {
  progress += Math.floor(Math.random() * 8) + 3;
  if (progress > 96) progress = 96;
  progressBar.style.width = progress + '%';
}, 900);

setInterval(() => {
  index = (index + 1) % tips.length;
  tip.textContent = tips[index];
}, 3500);
