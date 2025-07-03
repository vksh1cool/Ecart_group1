/**
 * 
 */
 
 /**
 * 
 */
 
 
const main = () =>{
    const profile = document.getElementById("profile");
    profile.style.display = 'flex';
}
const end = () =>{
    const profile = document.getElementById("profile");
    profile.style.display = 'none';
}





const totalDisplay = document.querySelector('.cart-summary h3');
const cartItemsContainer = document.querySelector('.cart-items');

// Initialize an array to hold cart items
let cartItems = [
    { name: "Product 1", price: 25.00, quantity: 1 },
    { name: "Product 2", price: 45.00, quantity: 2 },
    { name: "Product 3", price: 30.00, quantity: 1 }
];

// Function to update the total price
function updateTotal() {
    const total = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    totalDisplay.innerText = `Total: $${total.toFixed(2)}`;
}

// Function to render cart items
function renderCartItems() {

    cartItemsContainer.innerHTML = '';

    cartItems.forEach((item, index) => {
        const cartItemDiv = document.createElement('div');
        cartItemDiv.classList.add('cart-item');
        cartItemDiv.innerHTML = `
            <img src="https://via.placeholder.com/100" alt="${item.name}">
            <div class="item-details">
                <h3>${item.name}</h3>
                <p>Price: $${item.price.toFixed(2)}</p>
                <div class="quantity-control">
                    <button class="quantity-btn" data-index="${index}" data-action="decrease">-</button>
                    <input type="text" value="${item.quantity}" readonly>
                    <button class="quantity-btn" data-index="${index}" data-action="increase">+</button>
                </div>
            </div>
            <button class="delete-btn" data-index="${index}">Delete</button>
        `;
        cartItemsContainer.appendChild(cartItemDiv);
    });

    updateTotal();
}


function handleQuantityChange(e) {
    const index = e.target.dataset.index;
    const action = e.target.dataset.action;

    if (action === 'increase') {
        cartItems[index].quantity++;
    } else if (action === 'decrease' && cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
    }
    
    renderCartItems();
}

function handleDelete(e) {
    const index = e.target.dataset.index;
    cartItems.splice(index, 1);
    renderCartItems();
}

renderCartItems();



document.addEventListener('click', (e) => {
    if (e.target.classList.contains('quantity-btn')) {
        handleQuantityChange(e);
    } else if (e.target.classList.contains('delete-btn') || e.target.closest('.delete-btn')) {
        handleDelete(e);
    }
});



const back = ()=>{
	window.history.back();
}