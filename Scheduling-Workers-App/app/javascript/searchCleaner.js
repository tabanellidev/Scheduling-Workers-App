

let inputCleaner = document.getElementById('searchInputCleaner');
let tableCleaner = document.getElementById('dataTableCleaner');
let rowsCleaner = tableCleaner.getElementsByTagName('tr');
let noMatchMessageCleaner = document.getElementById('noMatchCleaners');


function search() {

    let filter = inputCleaner
        .value
        .toLowerCase();
    let matchFound = false;

    for (let i = 1; i < rowsCleaner.length; i++) {
        let row = rowsCleaner[i];
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
        noMatchMessageCleaner.style.display = 'block';
    } else {
        noMatchMessageCleaner.style.display = 'none';
    }
}


inputCleaner.addEventListener('input', () => search());



let table = document.getElementById('dataTableCleaner');
let rows = table.getElementsByTagName('tr');
let noMatchMsg = document.getElementById('noMatchCleaners');

let currentInput = inputCleaner;
let currentHandler = null;

function filterTable(input) {
    let filter = input.value.toLowerCase();
    let matchFound = false;

    for (let i = 1; i < rows.length; i++) {
        let row = rows[i];
        let cells = row.getElementsByTagName('td');
        let found = false;

        for (let j = 0; j < cells.length; j++) {
            let cell = cells[j];
            if (cell.textContent.toLowerCase().includes(filter)) {
                found = true;
                matchFound = true;
                break;
            }
        }

        row.style.display = found ? '' : 'none';
    }

    noMatchMsg.style.display = matchFound ? 'none' : 'block';
}

function attachFilter(input) {
    if (currentInput && currentHandler) {
        currentInput.removeEventListener('input', currentHandler);
    }

    currentInput = input;
    currentHandler = () => filterTable(input);
    input.addEventListener('input', currentHandler);

    // Pulizia: reset input e mostra tutto
    input.value = '';
    input.focus();

    for (let i = 1; i < rows.length; i++) {
        rows[i].style.display = '';
    }

    noMatchMsg.style.display = 'none';
}



let counter = 1

function add(){
    $('#addNewFormation').click(function(){
        let temp_id = 'searchInputCleaner'+counter
        $('div#formationSet').append('<div class ="FormationsForm" style="display:flex; flex-flow:row"> <div style="width:93%; margin-top:4px; margin-right:5px"> <input type="number" class="form-control" id="'+temp_id+'" name="collegues['+counter+']"  placeholder="Inserisci l\'addetto">  </div> '+
            '<div style="width:5%;"> <button class="removeNewFormation" type="button" style="height:90%; margin-top:4px">[-]</button> </div>  </div>');
        
        temp = document.getElementById(temp_id)
        attachFilter(temp)    
        counter++
    });


    $("div#formationSet").on('click', '.removeNewFormation', function(){
        $(this).closest('.FormationsForm').remove();
        counter--
    });
}

$(document).ready(add());