function openNav() {
    document.querySelector('.sidebar').style.width = "250px";
    document.querySelector('.main').style.marginLeft = "250px";
}

function closeNav() {
    document.querySelector('.sidebar').style.width = "0";
    document.querySelector('.main').style.marginLeft = "0";
}