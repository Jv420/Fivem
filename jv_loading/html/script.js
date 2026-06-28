const tips = [
    'Blijf in character en geef anderen ruimte om hun verhaal te spelen.',
    'Gebruik je microfoon duidelijk en speel realistisch.',
    'Respect staat boven alles, ook buiten roleplay situaties.',
    'Maak scenario\'s leuk voor jezelf én voor andere spelers.',
    'Nieuwe speler? Vraag hulp aan staff of andere inwoners.'
];

const loadingLines = [
    'Serverbestanden laden...',
    'Voertuigen voorbereiden...',
    'Delfzijl kaart opbouwen...',
    'Roleplay systemen starten...',
    'Bijna klaar om te spelen...'
];

const progressFill = document.getElementById('progressFill');
const percentText = document.getElementById('percentText');
const loadingText = document.getElementById('loadingText');
const tipText = document.getElementById('tipText');

let progress = 0;
let tipIndex = 0;
let lineIndex = 0;

function updateProgress() {
    const boost = Math.random() * 7 + 2;
    progress = Math.min(progress + boost, 99);

    progressFill.style.width = `${progress}%`;
    percentText.textContent = `${Math.floor(progress)}%`;

    if (progress > 18 && lineIndex === 0) lineIndex = 1;
    if (progress > 38 && lineIndex === 1) lineIndex = 2;
    if (progress > 58 && lineIndex === 2) lineIndex = 3;
    if (progress > 78 && lineIndex === 3) lineIndex = 4;

    loadingText.textContent = loadingLines[lineIndex];

    if (progress < 99) {
        setTimeout(updateProgress, 650 + Math.random() * 450);
    }
}

function rotateTips() {
    tipIndex = (tipIndex + 1) % tips.length;
    tipText.style.opacity = '0';

    setTimeout(() => {
        tipText.textContent = tips[tipIndex];
        tipText.style.opacity = '1';
    }, 250);
}

window.addEventListener('message', (event) => {
    if (!event.data || event.data.eventName !== 'loadProgress') return;

    const realProgress = Math.floor(event.data.loadFraction * 100);
    progress = Math.max(progress, realProgress);
    progressFill.style.width = `${progress}%`;
    percentText.textContent = `${progress}%`;

    if (progress >= 100) {
        loadingText.textContent = 'Welkom in Delfzijl!';
    }
});

setInterval(rotateTips, 5200);
updateProgress();
