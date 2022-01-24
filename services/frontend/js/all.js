const starsHtml = (num) => { 
    var result = ''
    Array.from(Array(num).keys()).forEach((star, j) => {
        result += `<img class='star' src='images/star.png' />`
    })
    return result
}

const getTime = (input) => { 
    const date = new Date(input)
    var year = date.getFullYear(),
    month = date.getMonth() + 1, 
    day = date.getDate(),
    hour = date.getHours(),
    minute = date.getMinutes(),
    second = date.getSeconds()

    return `${day}-${month}-${year} ${hour}:${minute}:${second}`
}