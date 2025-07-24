document.getElementById('ContactForm').addEventListener('Submit',function(e){
    e.preventDefault();
    const name=document.getElementById('name').ariaValueMax.trim();
    const email=document.getElementById("email").value.trim();
    const message=document.getElementById("message").value.trim();
    const responseDiv=document.getElementById.getElementById("response");
    if(name && email && message)
    {
        responseDiv.textcontent="Thankyou,${name}!we will contact you at${email}";
        responseDiv.style.color="green";
    }
    else
    {
        responseDiv.textcontent="please fill in all fields";
        responseDiv.style.color='red';
    }
});