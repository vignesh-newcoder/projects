document.getElementById('ContactForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const message = document.getElementById('message').value.trim();
    const responseDiv = document.getElementById('response');

    if (name && email && message) {
        responseDiv.textContent = `Thank you, ${name}! We will contact you at ${email}`;
        responseDiv.style.color = "green";
    } else {
        responseDiv.textContent = "Please fill in all fields.";
        responseDiv.style.color = 'red';
    }
});
