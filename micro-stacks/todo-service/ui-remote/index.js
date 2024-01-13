const vanJs = await import('https://www.unpkg.com/vanjs-core@1.2.7/src/van.js');
const {a, button, div, input, span} = van.tags

const TodoItem = ({text}) => div(
    input({type: "checkbox", onchange: e =>
      e.target.closest("div").querySelector("span").style["text-decoration"] =
        e.target.checked ? "line-through" : ""
    }),
    span(text),
    a({onclick: e => e.target.closest("div").remove()}, "❌"),
  )
  
  const TodoList = () => {
    const inputDom = input({type: "text"})
    const dom = div(
      inputDom,
      button({onclick: () => van.add(dom, TodoItem({text: inputDom.value}))}, "Add"),
    )
    return dom
  }
  

const render = (ele)=>{
    van.add(ele, TodoList());
}

export default render;
