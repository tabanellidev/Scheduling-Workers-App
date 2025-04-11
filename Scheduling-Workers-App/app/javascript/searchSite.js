/** script.js **/
let input = document.getElementById('searchInputSite');
let tableS = document.getElementById('dataTableSite');
let rowsS = tableS.getElementsByTagName('tr');
let noMatchMessage = document.getElementById('noMatchSites');

input.addEventListener('input', function () {
  
    let filter = input
        .value
        .toLowerCase();
    let matchFound = false;

    for (let i = 1; i < rowsS.length; i++) {
        let row = rowsS[i];
        let cells = row
            .getElementsByTagName('td');
        let found = false;

        for (let j = 0; j < cells.length; j++) {
            let cell = cells[j];
            if (cell.textContent.toLowerCase().indexOf(filter) > -1) {
                found = true;
                matchFound = true;
                break;
            }
        }

        if (found) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    }

    if (!matchFound) {
        noMatchMessage.style.display = 'block';
    } else {
        noMatchMessage.style.display = 'none';
    }
});
