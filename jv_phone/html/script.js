let services = [];
let contacts = [];
let selectedService = null;

const phone = document.getElementById('phone');
const modal = document.getElementById('modal');
const serviceList = document.getElementById('serviceList');
const contactList = document.getElementById('contactList');
const closeBtn = document.getElementById('closeBtn');
const cancelBtn = document.getElementById('cancelBtn');
const sendBtn = document.getElementById('sendBtn');
const serviceMessage = document.getElementById('serviceMessage');
const modalTitle = document.getElementById('modalTitle');
const modalDesc = document.getElementById('modalDesc');
const serverName = document.getElementById('serverName');
const cityName = document.getElementById('cityName');
const timeEl = document.getElementById('time');

function resourceName() {
    return typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'jv_phone';
}

function post(name, data = {}) {
    return fetch(`https://${resourceName()}/${name}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data)
    });
}

function renderServices() {
    serviceList.innerHTML = '';
    services.forEach(service => {
        const button = document.createElement('button');
        button.className = 'service-card';
        button.innerHTML = `
            <div class="icon" style="box-shadow: 0 0 24px ${service.color}55">${service.icon}</div>
            <div>
                <h3>${service.label}</h3>
                <p>${service.description}</p>
            </div>
        `;
        button.addEventListener('click', () => openModal(service));
        serviceList.appendChild(button);
    });
}

function renderContacts() {
    contactList.innerHTML = '';
    contacts.forEach(contact => {
        const card = document.createElement('div');
        card.className = 'contact-card';
        card.innerHTML = `
            <div>
                <h3>${contact.name}</h3>
                <p>${contact.service}</p>
            </div>
            <span class="contact-number">${contact.number}</span>
        `;
        card.addEventListener('click', () => {
            const service = services.find(item => item.id === contact.service);
            if (service) openModal(service);
        });
        contactList.appendChild(card);
    });
}

function openModal(service) {
    selectedService = service;
    modalTitle.textContent = service.label;
    modalDesc.textContent = service.description;
    serviceMessage.value = '';
    modal.classList.remove('hidden');
    serviceMessage.focus();
}

function closeModal() {
    selectedService = null;
    modal.classList.add('hidden');
}

function setup(data) {
    services = data.services || services;
    contacts = data.contacts || contacts;
    serverName.textContent = data.serverName || 'Delfzijl RP';
    cityName.textContent = data.cityName || 'Delfzijl';
    renderServices();
    renderContacts();
}

function updateClock() {
    const now = new Date();
    timeEl.textContent = now.toLocaleTimeString('nl-NL', { hour: '2-digit', minute: '2-digit' });
}

window.addEventListener('message', (event) => {
    const data = event.data || {};

    if (data.action === 'setup') setup(data);
    if (data.action === 'open') {
        setup(data);
        phone.classList.remove('hidden');
    }
    if (data.action === 'close') {
        phone.classList.add('hidden');
        closeModal();
    }
});

document.querySelectorAll('.tab').forEach(tab => {
    tab.addEventListener('click', () => {
        document.querySelectorAll('.tab').forEach(item => item.classList.remove('active'));
        document.querySelectorAll('.page').forEach(item => item.classList.remove('active'));
        tab.classList.add('active');
        document.getElementById(tab.dataset.page).classList.add('active');
    });
});

closeBtn.addEventListener('click', () => post('closePhone'));
cancelBtn.addEventListener('click', closeModal);

sendBtn.addEventListener('click', async () => {
    if (!selectedService) return;

    await post('requestService', {
        service: selectedService.id,
        message: serviceMessage.value
    });

    closeModal();
    post('closePhone');
});

document.addEventListener('keyup', (event) => {
    if (event.key === 'Escape') {
        if (!modal.classList.contains('hidden')) {
            closeModal();
        } else {
            post('closePhone');
        }
    }
});

setInterval(updateClock, 1000);
updateClock();
