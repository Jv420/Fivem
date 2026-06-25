window.addEventListener('message', function(event) {
  const data = event.data;
  if (data.action === 'toggle') {
    document.getElementById('hud').style.display = data.show ? 'flex' : 'none';
  }
  if (data.action === 'update') {
    document.getElementById('pid').textContent = data.id;
    document.getElementById('hp').textContent = data.health;
    document.getElementById('armor').textContent = data.armor;
    document.getElementById('street').textContent = data.street || 'Onbekend';
  }
});
