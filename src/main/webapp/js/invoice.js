// Retrieve the stored data from localStorage
let orderId = localStorage.getItem('orderId');
let paymentMethod = localStorage.getItem('paymentMethod');
let name = localStorage.getItem('cardHolder');  // Using cardHolder as the name now

let  product= "Laptop";

// Populate the invoice page with the data
document.getElementById('order-id').innerText = orderId;
document.getElementById('payment-method').innerText = paymentMethod;
document.getElementById('name').innerText = name;
document.getElementById('product').innerText = product;

// Option to go back to the home page
document.getElementById('go-home').addEventListener('click', function() {
    window.location.href = 'home.html';  // Adjust this to your actual home page URL
});

// Print Invoice functionality
document.getElementById('print-invoice').addEventListener('click', function() {
    window.print();  // Trigger the print dialog to print the invoice
});
document.getElementById('print-invoice').addEventListener('click', function() {
    // Get the invoice content
    const invoiceContent = document.getElementById('invoice-content').innerHTML;
    const originalContent = document.body.innerHTML;

    // Replace the body content with the invoice content
    document.body.innerHTML = invoiceContent;

    // Trigger the print dialog
    window.print();

    // Restore the original content after printing
    document.body.innerHTML = originalContent;
});

