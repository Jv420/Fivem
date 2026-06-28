let vehicles = [];
let payments = [];
let selectedPayment = 'cash';
let currency = '€';

const app = document.getElementById('app');
const vehicleGrid = document.getElementById('vehicleGrid');
const paymentList = document.getElementById('paymentList');
const closeBtn = document.getElementById('closeBtn');

function resourceName() {
    return typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'jv_cardealer';
}

function post(name, data = {}) {
    return fetch(`https://${resourceName()}/${name}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(data)
    });
}

function money(value) {
    return `${currency}${Number(value).toLocaleString('nl-NL')}`;
}

function renderPayments() {
    paymentList.innerHTML = '';
    payments.forEach(payment => {
        const btn = document.createElement('button');
        btn.className = `payment-btn ${payment.id === selectedPayment ? 'active' : ''}`;
        btn.textContent = payment.label;
        btn.addEventListener('click', () => {
            selectedPayment = payment.id;
            renderPayments();
        });
        paymentList.appendChild(btn);
    });
}

function renderVehicles() {
    vehicleGrid.innerHTML = '';
    vehicles.forEach(vehicle => {
        const card = document.createElement('article');
        card.className = 'vehicle-card';
        card.innerHTML = `
            <div class="car-art">🚗</div>
            <h3>${vehicle.label}</h3>
            <div class="category">${vehicle.category} • ${vehicle.model}</div>
            <div class="price">${money(vehicle.price)}</div>
            <button class="buy-btn">Kopen</button>
        `;
        card.querySelector('.buy-btn').addEventListener('click', () => {
            post('buyVehicle', {
                model: vehicle.model,
                payment: selectedPayment
            });
        });
        vehicleGrid.appendChild(card);
    });
}

window.addEventListener('message', event => {
    const data = event.data || {};
    if (data.action === 'open') {
        vehicles = data.vehicles || [];
        payments = data.payments || [];
        currency = data.currency || '€';
        selectedPayment = payments[0] ? payments[0].id : 'cash';
        renderPayments();
        renderVehicles();
        app.classList.remove('hidden');
    }

    if (data.action === 'close') {
        app.classList.add('hidden');
    }
});

closeBtn.addEventListener('click', () => post('close'));

document.addEventListener('keyup', event => {
    if (event.key === 'Escape') post('close');
});
