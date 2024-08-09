document.addEventListener('DOMContentLoaded', function () {
  const resultsPerPage = 10;
  const resultsContainer = document.getElementById('test-list');
  const results = Array.from(resultsContainer.getElementsByClassName('result-item'));
  const totalResults = results.length;
  const totalPages = Math.ceil(totalResults / resultsPerPage);
  let currentPage = 1;

  function showPage(page) {
      results.forEach(result => result.style.display = 'none');

      const startIndex = (page - 1) * resultsPerPage;
      const endIndex = startIndex + resultsPerPage;

      results.slice(startIndex, endIndex).forEach(result => result.style.display = 'block');

      updatePaginationControls();
  }

  function updatePaginationControls() {
      const paginationContainer = document.getElementById('pagination-controls');
      paginationContainer.innerHTML = '';

      const prevButton = document.createElement('button');
      prevButton.innerText = 'Anterior';
      prevButton.classList.add('btn', 'btn-primary');
      prevButton.addEventListener('click', () => {
          if (currentPage > 1) {
              currentPage--;
              showPage(currentPage);
          }
      });
      if (currentPage === 1) {
          prevButton.disabled = true;
      }
      paginationContainer.appendChild(prevButton);

      const pageInfo = document.createElement('span');
      pageInfo.innerText = `Página ${currentPage} de ${totalPages}`;
      pageInfo.style.margin = '0 10px';
      paginationContainer.appendChild(pageInfo);

      const nextButton = document.createElement('button');
      nextButton.innerText = 'Próxima';
      nextButton.classList.add('btn', 'btn-primary');
      nextButton.addEventListener('click', () => {
          if (currentPage < totalPages) {
              currentPage++;
              showPage(currentPage);
          }
      });
      if (currentPage === totalPages) {
          nextButton.disabled = true;
      }
      paginationContainer.appendChild(nextButton);
  }

  showPage(currentPage);
});
