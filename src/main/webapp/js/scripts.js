
/* FILTER */
function filter(type) {
    let products = document.getElementsByClassName("product-card");

    for (let i = 0; i < products.length; i++) {
        if (type === "all") {
            products[i].style.display = "block";
        } else {
            if (products[i].classList.contains(type)) {
                products[i].style.display = "block";
            } else {
                products[i].style.display = "none";
            }
        }
    }
}

/* SEARCH */
function searchProduct() {
    let input = document.getElementById("searchBox").value.toLowerCase();
    let products = document.getElementsByClassName("product-card");

    for (let i = 0; i < products.length; i++) {
        let name = products[i].getElementsByTagName("h3")[0].innerText.toLowerCase();

        if (name.includes(input)) {
            products[i].style.display = "block";
        } else {
            products[i].style.display = "none";
        }
    }
}

function toggleMenu() {
    const menu = document.getElementById("dropdownMenu");

    if (menu.style.display === "block") {
        menu.style.display = "none";
    } else {
        menu.style.display = "block";
    }
}

// close menu when click outside
window.onclick = function(event) {
    if (!event.target.matches('.user-icon')) {
        const menu = document.getElementById("dropdownMenu");
        if (menu) {
            menu.style.display = "none";
        }
    }
}