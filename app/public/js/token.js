document.getElementById('token-form').addEventListener('submit', function(event) {
  event.preventDefault();
  
  const tokenInput = document.getElementById('token-input');
  const tokenValue = tokenInput.value.trim();
  
  if (tokenValue) {
    window.location.href = '/' + encodeURIComponent(tokenValue);
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const queryParams = new URLSearchParams(window.location.search);
  const token = queryParams.get('token');
  if (token) {
    const tokenInput = document.getElementById('token-input');
    tokenInput.value = decodeURIComponent(token);
    document.getElementById('token-form').dispatchEvent(new Event('submit'));
  }
});
