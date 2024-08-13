document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('csv-form');
  const notice = document.getElementById('upload-notice');

  form.addEventListener('submit', function (event) {
    event.preventDefault();

    const formData = new FormData(form);

    fetch(form.action, {
      method: 'POST',
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        notice.classList.remove('d-none');
        notice.textContent = 'Arquivo enviado para processamento.';
      } else {
        notice.classList.remove('alert-success');
        notice.classList.add('alert-danger');
        notice.textContent = 'Erro ao enviar o arquivo.';
      }
    })
    .catch(error => {
      console.error('Error:', error);
      notice.classList.remove('alert-success');
      notice.classList.add('alert-danger');
      notice.textContent = 'Erro ao enviar o arquivo.';
    });
  });
});
