/** script.js **/
let input = document.getElementById('searchInputJob');
let table = document.getElementById('dataTableJob');
let rows = table.getElementsByTagName('tr');
let noMatchMessage = document.getElementById('noMatch');

input.addEventListener('input', function () {
  
    let filter = input
        .value
        .toLowerCase();
    let matchFound = false;

    for (let i = 1; i < rows.length; i++) {
        let row = rows[i];
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