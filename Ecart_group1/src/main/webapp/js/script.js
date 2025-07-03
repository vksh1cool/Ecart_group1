document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const customerNameInput = document.querySelector("input[placeholder='Customer Name']");
    const emailInput = document.querySelector("input[placeholder='Email']");
    const phoneInput = document.querySelector("input.phone-number");
    const passwordInput = document.querySelector("input[placeholder='Password']");
    const confirmPasswordInput = document.querySelector("input[placeholder='Confirm Password']");
    const resetButton = document.querySelector("button[type='reset']");
    const registerButton = document.querySelector("button[type='submit']");

    function validateCustomerName() {
        const customerName = customerNameInput.value.trim();
        const nameRegex = /^[a-zA-Z\s]+$/;
        if (!nameRegex.test(customerName)) {
            alert("Customer name can only contain letters.");
            return false;
        }
        return true;
    }

    function validateEmail() {
        const email = emailInput.value.trim();
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            alert("Please enter a valid email address.");
            return false;
        }
        return true;
    }

    function validatePhoneNumber() {
        const phoneNumber = phoneInput.value.trim();
        const phoneRegex = /^[0-9]+$/;
        if (!phoneRegex.test(phoneNumber)) {
            alert("Phone number can only contain digits.");
            return false;
        }
        return true;
    }

    function validatePassword() {
        const password = passwordInput.value.trim();
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$/;
        if (!passwordRegex.test(password)) {
            alert("Password must be between 8-12 characters, with at least one uppercase letter, one lowercase letter, one digit, and one special character.");
            return false;
        }
        return true;
    }

    function validateConfirmPassword() {
        const password = passwordInput.value.trim();
        const confirmPassword = confirmPasswordInput.value.trim();
        if (password !== confirmPassword) {
            alert("Passwords do not match.");
            return false;
        }
        return true;
    }

    resetButton.addEventListener("click", function() {
        form.reset();
    });

    form.addEventListener("submit", function(event) {
        if (!validateCustomerName() || !validateEmail() || !validatePhoneNumber() || !validatePassword() || !validateConfirmPassword()) {
            event.preventDefault();
        } else {
            alert("Form submitted successfully!");
        }
    });
});
