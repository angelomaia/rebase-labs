document.addEventListener('DOMContentLoaded', function () {
    const resultsPerPage = 5;
    const resultsContainer = document.getElementById('test-list');
    const results = Array.from(resultsContainer.getElementsByClassName('result-item'));
    const totalResults = results.length;
    const totalPages = Math.ceil(totalResults / resultsPerPage);
    let currentPage = 1;
  
    const paginationControlsTop = {
      container: document.getElementById('pagination-controls-top'),
      prevButton: null,
      nextButton: null,
      pageInfo: null
    };
  
    const paginationControlsBottom = {
      container: document.getElementById('pagination-controls-bottom'),
      prevButton: null,
      nextButton: null,
      pageInfo: null
    };
  
    function showPage(page) {
        results.forEach(result => result.style.display = 'none');
  
        const startIndex = (page - 1) * resultsPerPage;
        const endIndex = startIndex + resultsPerPage;
  
        results.slice(startIndex, endIndex).forEach(result => result.style.display = 'block');
  
        updatePaginationControls(paginationControlsTop);
        updatePaginationControls(paginationControlsBottom);
    }
  
    function updatePaginationControls(controls) {
        const { container } = controls;
  
        container.innerHTML = '';
  
        controls.prevButton = document.createElement('button');
        controls.prevButton.innerText = 'Anterior';
        controls.prevButton.classList.add('btn', 'btn-primary');
        controls.prevButton.addEventListener('click', () => {
            if (currentPage > 1) {
                currentPage--;
                showPage(currentPage);
            }
        });
        if (currentPage === 1) {
            controls.prevButton.disabled = true;
        }
        container.appendChild(controls.prevButton);
  
        controls.pageInfo = document.createElement('span');
        controls.pageInfo.innerText = `Página ${currentPage} de ${totalPages}`;
        controls.pageInfo.style.margin = '0 10px';
        container.appendChild(controls.pageInfo);
  
        controls.nextButton = document.createElement('button');
        controls.nextButton.innerText = 'Próxima';
        controls.nextButton.classList.add('btn', 'btn-primary');
        controls.nextButton.addEventListener('click', () => {
            if (currentPage < totalPages) {
                currentPage++;
                showPage(currentPage);
            }
        });
        if (currentPage === totalPages) {
            controls.nextButton.disabled = true;
        }
        container.appendChild(controls.nextButton);
    }
  
    showPage(currentPage);
  });
  