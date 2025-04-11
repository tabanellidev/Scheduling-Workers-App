let checkboxes = document.querySelectorAll("input[type='checkbox']");
let cbActual = document.querySelectorAll('input[type=checkbox]:not([class=auto])');

cbActual.forEach(
    cb => {
      cb.addEventListener('change', (event)=>{
        if(!event.target.checked)
          document.getElementById('check-all')
            .checked = false;
        else{
          if( [...cbActual].every(cb => cb.checked === true) )
             document.getElementById('check-all')
              .checked = true;
        }
      });
    }
  );
  
  function checkAll(myCheckBox) {
    if (myCheckBox.checked == true) {
      checkboxes.forEach(function(checkbox) {
        checkbox.checked = true;
      });
    } else {
      checkboxes.forEach(function(checkbox) {
        checkbox.checked = false;
      });
    }
  }