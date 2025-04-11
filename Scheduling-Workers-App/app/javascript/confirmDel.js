const deleteButton = document.getElementById('delete-link');

deleteButton.addEventListener('click', function (event) {
  // Mostra il dialogo di conferma
  const userConfirmed = window.confirm('Sei sicuro di voler eliminare questo elemento?');

  if (!userConfirmed) {
    // Se l'utente annulla, preveniamo l'azione del bottone
    event.preventDefault();
    alert('Eliminazione annullata!');
  } else {
    // Altrimenti, procedi con l'azione
    alert('Elemento eliminato!');
  }
});
