const deleteButton = document.getElementById('copy-link');

deleteButton.addEventListener('click', function (event) {
  // Mostra il dialogo di conferma
  const userConfirmed = window.confirm('Sei sicuro di voler copiare?');

  if (!userConfirmed) {
    // Se l'utente annulla, preveniamo l'azione del bottone
    event.preventDefault();
    alert('Copia annullata!');
  } else {
    // Altrimenti, procedi con l'azione
    alert('Elemento copiato!');
  }
});
