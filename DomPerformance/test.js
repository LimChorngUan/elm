let string = "some string"

const updateString = () => {
  for (let i = 0; i < 10000; i++) {
    string = "updated string"
  }
}

const t1 = performance.now()
updateString()
const t2 = performance.now()

console.log(`update string: ${t2 -t1}ms`)


const div = document.createElement('div')
const text = document.createTextNode('text')

div.appendChild(text)
document.body.appendChild(div)

const updateDom = () => {
  for (let i = 0; i < 10000; i++) {
    div.innerHTML = "updated text"
  }
}

const t3 = performance.now()
updateDom()
const t4 = performance.now()

console.log(`update dom: ${t4 -t3}ms`)