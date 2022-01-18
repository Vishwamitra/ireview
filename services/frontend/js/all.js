const starsHtml = (num) => { 
    var result = ''
    Array.from(Array(num).keys()).forEach((star, j) => {
        result += `<img class='star' src='images/star.png' />`
    })
    return result
}

const getTime = (input) => { // todo: correct timestamp. wait for backend 
    return input 
}