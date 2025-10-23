const components = [
  {
    tag: "div",
    label: "Container",
    description: "Bloco com display padrão",
    attributes: {
      class: "container",
    },
    text: "Container"
  },
  {
    tag: "section",
    label: "Seção",
    description: "Seção semântica",
    text: "Nova seção"
  },
  {
    tag: "p",
    label: "Parágrafo",
    description: "Texto parágrafo",
    text: "Lorem ipsum dolor sit amet"
  },
  {
    tag: "h2",
    label: "Título",
    description: "Título nível 2",
    text: "Novo título"
  },
  {
    tag: "button",
    label: "Botão",
    description: "Botão padrão",
    text: "Clique aqui"
  },
  {
    tag: "input",
    label: "Campo texto",
    description: "Entrada de texto",
    attributes: {
      type: "text",
      placeholder: "Digite algo"
    }
  },
  {
    tag: "textarea",
    label: "Área texto",
    description: "Entrada multilinha",
    attributes: {
      placeholder: "Digite aqui"
    }
  },
  {
    tag: "img",
    label: "Imagem",
    description: "Imagem com placeholder",
    attributes: {
      src: "https://placehold.co/300x150",
      alt: "Placeholder"
    }
  },
  {
    tag: "form",
    label: "Formulário",
    description: "Formulário básico",
    text: "\n  <label>Nome: <input type=\"text\" name=\"nome\"></label>\n  <button type=\"submit\">Enviar</button>\n"
  },
  {
    tag: "ul",
    label: "Lista",
    description: "Lista não ordenada",
    text: "\n  <li>Item 1</li>\n  <li>Item 2</li>\n  <li>Item 3</li>\n"
  }
];

const propertyFields = [
  {
    name: "id",
    label: "ID",
    type: "text",
    applies: () => true,
    get: (el) => el.id,
    set: (el, value) => {
      el.id = value.trim();
    }
  },
  {
    name: "className",
    label: "Classes",
    type: "text",
    applies: () => true,
    get: (el) => el.className,
    set: (el, value) => {
      el.className = value.trim();
    }
  },
  {
    name: "textContent",
    label: "Texto",
    type: "textarea",
    applies: (el) => !["IMG", "INPUT", "TEXTAREA", "SELECT", "FORM"].includes(el.tagName),
    get: (el) => el.textContent,
    set: (el, value) => {
      el.textContent = value;
    }
  },
  {
    name: "value",
    label: "Valor",
    type: "text",
    applies: (el) => "value" in el,
    get: (el) => el.value ?? "",
    set: (el, value) => {
      el.value = value;
    }
  },
  {
    name: "placeholder",
    label: "Placeholder",
    type: "text",
    applies: (el) => "placeholder" in el,
    get: (el) => el.placeholder ?? "",
    set: (el, value) => {
      el.placeholder = value;
    }
  },
  {
    name: "src",
    label: "Src",
    type: "text",
    applies: (el) => "src" in el,
    get: (el) => el.getAttribute("src") ?? "",
    set: (el, value) => {
      if (value.trim()) {
        el.setAttribute("src", value.trim());
      } else {
        el.removeAttribute("src");
      }
    }
  },
  {
    name: "href",
    label: "Href",
    type: "text",
    applies: (el) => "href" in el,
    get: (el) => el.getAttribute("href") ?? "",
    set: (el, value) => {
      if (value.trim()) {
        el.setAttribute("href", value.trim());
      } else {
        el.removeAttribute("href");
      }
    }
  },
  {
    name: "alt",
    label: "Alt",
    type: "text",
    applies: (el) => "alt" in el,
    get: (el) => el.getAttribute("alt") ?? "",
    set: (el, value) => {
      if (value.trim()) {
        el.setAttribute("alt", value.trim());
      } else {
        el.removeAttribute("alt");
      }
    }
  },
  {
    name: "title",
    label: "Title",
    type: "text",
    applies: (el) => true,
    get: (el) => el.getAttribute("title") ?? "",
    set: (el, value) => {
      if (value.trim()) {
        el.setAttribute("title", value.trim());
      } else {
        el.removeAttribute("title");
      }
    }
  }
];

const stylePresets = [
  "display",
  "position",
  "top",
  "left",
  "width",
  "height",
  "padding",
  "margin",
  "background-color",
  "color",
  "border",
  "border-radius",
  "font-size",
  "font-weight",
  "text-align",
  "justify-content",
  "align-items"
];

const eventNames = [
  "click",
  "dblclick",
  "contextmenu",
  "mouseover",
  "mouseout",
  "focus",
  "blur",
  "input",
  "change",
  "keydown",
  "keypress",
  "keyup",
  "submit"
];

const componentList = document.getElementById("component-list");
const canvas = document.getElementById("canvas");
const elementInfo = document.getElementById("element-info");
const propertyForm = document.getElementById("property-form");
const styleForm = document.getElementById("style-form");
const addStyleButton = document.getElementById("add-style");
const eventList = document.getElementById("event-list");
const toggleGridButton = document.getElementById("toggle-grid");
const clearCanvasButton = document.getElementById("clear-canvas");

let selectedElement = null;

function createComponentButton(component) {
  const button = document.createElement("button");
  button.className = "component-button";
  button.type = "button";
  button.innerHTML = `<strong>${component.label}</strong><span>${component.description}</span>`;
  button.addEventListener("click", () => {
    const element = document.createElement(component.tag);
    if (component.text) {
      element.innerHTML = component.text;
    }

    if (component.attributes) {
      Object.entries(component.attributes).forEach(([key, value]) => {
        element.setAttribute(key, value);
      });
    }

    element.dataset.component = component.label;
    bindCanvasEvents(element);
    const target = resolveInsertionTarget();
    target.appendChild(element);
    selectElement(element);
    canvas.focus({ preventScroll: true });
  });

  return button;
}

function bindCanvasEvents(element) {
  element.addEventListener("click", (event) => {
    event.stopPropagation();
    selectElement(element);
  });

  element.addEventListener("dblclick", (event) => {
    event.stopPropagation();
    enableInlineEdit(element);
  });

  Array.from(element.children).forEach((child) => bindCanvasEvents(child));
}

function resolveInsertionTarget() {
  if (!selectedElement) {
    return canvas;
  }

  const voidTags = new Set([
    "AREA",
    "BASE",
    "BR",
    "COL",
    "EMBED",
    "HR",
    "IMG",
    "INPUT",
    "LINK",
    "META",
    "PARAM",
    "SOURCE",
    "TRACK",
    "WBR"
  ]);

  if (voidTags.has(selectedElement.tagName)) {
    return canvas;
  }

  return selectedElement;
}

function enableInlineEdit(element) {
  if (["INPUT", "TEXTAREA"].includes(element.tagName)) {
    element.focus();
    return;
  }

  element.setAttribute("contenteditable", "true");
  element.focus();

  const disableEdit = () => {
    element.removeAttribute("contenteditable");
    element.removeEventListener("blur", disableEdit);
    updateInspector();
  };

  element.addEventListener("blur", disableEdit, { once: true });
}

function populateComponentList() {
  components.forEach((component) => {
    componentList.appendChild(createComponentButton(component));
  });
}

function selectElement(element) {
  if (selectedElement === element) {
    return;
  }

  if (selectedElement) {
    selectedElement.classList.remove("selected");
  }

  selectedElement = element;
  if (selectedElement) {
    selectedElement.classList.add("selected");
  }

  updateInspector();
}

function updateInspector() {
  if (!selectedElement) {
    elementInfo.innerHTML = "<p>Nenhum elemento selecionado.</p>";
    propertyForm.innerHTML = "<p class=\"empty\">Selecione um elemento para editar.</p>";
    styleForm.innerHTML = "";
    eventList.innerHTML = "";
    return;
  }

  elementInfo.innerHTML = `
    <div class="info-row"><strong>Tag:</strong> &lt;${selectedElement.tagName.toLowerCase()}&gt;</div>
    <div class="info-row"><strong>ID:</strong> ${selectedElement.id || "—"}</div>
    <div class="info-row"><strong>Classes:</strong> ${selectedElement.className || "—"}</div>
    <div class="info-row"><strong>Filhos:</strong> ${selectedElement.children.length}</div>
  `;

  renderPropertyForm();
  renderStyleForm();
  renderEventEditors();
}

function renderPropertyForm() {
  propertyForm.innerHTML = "";

  propertyFields
    .filter((field) => field.applies(selectedElement))
    .forEach((field) => {
      const wrapper = document.createElement("label");
      wrapper.textContent = field.label;

      let input;
      if (field.type === "textarea") {
        input = document.createElement("textarea");
      } else {
        input = document.createElement("input");
        input.type = field.type;
      }

      input.name = field.name;
      input.value = field.get(selectedElement) ?? "";
      input.addEventListener("input", (event) => {
        field.set(selectedElement, event.target.value);
        if (field.name === "id" || field.name === "className") {
          updateInspector();
        }
      });

      wrapper.appendChild(input);
      propertyForm.appendChild(wrapper);
    });
}

function createStyleRow(property, value, { locked = false } = {}) {
  const template = document.getElementById("style-row-template");
  const row = template.content.firstElementChild.cloneNode(true);
  const keyInput = row.querySelector(".style-key");
  const valueInput = row.querySelector(".style-value");
  const removeButton = row.querySelector(".remove-style");

  keyInput.value = property;
  valueInput.value = value ?? "";

  if (locked) {
    keyInput.readOnly = true;
    keyInput.classList.add("locked");
    removeButton.hidden = true;
  }

  const updateStyle = () => {
    const propertyName = keyInput.value.trim();
    const propertyValue = valueInput.value.trim();

    if (!propertyName) {
      return;
    }

    selectedElement.style.setProperty(propertyName, propertyValue);
  };

  keyInput.addEventListener("change", () => {
    updateStyle();
  });

  valueInput.addEventListener("input", () => {
    updateStyle();
  });

  removeButton.addEventListener("click", () => {
    const propertyName = keyInput.value.trim();
    if (propertyName) {
      selectedElement.style.removeProperty(propertyName);
    }
    row.remove();
  });

  return row;
}

function renderStyleForm() {
  styleForm.innerHTML = "";

  const used = new Set();
  stylePresets.forEach((property) => {
    const value = selectedElement.style.getPropertyValue(property);
    const row = createStyleRow(property, value, { locked: true });
    styleForm.appendChild(row);
    used.add(property);
  });

  const inlineStyles = Array.from(selectedElement.style);
  inlineStyles.forEach((property) => {
    if (used.has(property)) {
      return;
    }
    const value = selectedElement.style.getPropertyValue(property);
    const row = createStyleRow(property, value);
    styleForm.appendChild(row);
  });
}

function renderEventEditors() {
  eventList.innerHTML = "";

  eventNames.forEach((eventName) => {
    const template = document.getElementById("event-template");
    const eventNode = template.content.firstElementChild.cloneNode(true);
    const nameSpan = eventNode.querySelector(".event-name");
    const codeArea = eventNode.querySelector(".event-code");

    nameSpan.textContent = eventName;
    codeArea.value = selectedElement.__customEvents?.[eventName]?.code ?? "";

    codeArea.addEventListener("change", () => {
      assignEventHandler(selectedElement, eventName, codeArea.value);
    });

    eventList.appendChild(eventNode);
  });
}

function assignEventHandler(element, eventName, code) {
  if (!element.__customEvents) {
    element.__customEvents = {};
  }

  const existing = element.__customEvents[eventName];
  if (existing?.listener) {
    element.removeEventListener(eventName, existing.listener);
  }

  if (!code.trim()) {
    delete element.__customEvents[eventName];
    return;
  }

  try {
    const fn = new Function("event", code);
    const listener = function (event) {
      return fn.call(element, event);
    };
    element.addEventListener(eventName, listener);
    element.__customEvents[eventName] = { code, listener };
  } catch (error) {
    alert(`Erro ao compilar evento ${eventName}: ${error.message}`);
  }
}

addStyleButton.addEventListener("click", () => {
  if (!selectedElement) {
    return;
  }
  const row = createStyleRow("", "");
  styleForm.appendChild(row);
  row.querySelector(".style-key").focus();
});

canvas.addEventListener("click", () => {
  if (selectedElement) {
    selectedElement.classList.remove("selected");
    selectedElement = null;
    updateInspector();
  }
});

canvas.addEventListener("keydown", (event) => {
  if (!selectedElement) {
    return;
  }

  if (event.key === "Delete" || event.key === "Backspace") {
    event.preventDefault();
    const toRemove = selectedElement;
    const parent = toRemove.parentElement;
    toRemove.remove();
    if (parent && parent.closest("#canvas")) {
      selectElement(parent);
    } else {
      selectedElement = null;
      updateInspector();
    }
  }
});

toggleGridButton.addEventListener("click", () => {
  canvas.classList.toggle("grid");
  toggleGridButton.classList.toggle("active");
});

clearCanvasButton.addEventListener("click", () => {
  if (confirm("Tem certeza de que deseja limpar o canvas?")) {
    canvas.innerHTML = "";
    selectedElement = null;
    updateInspector();
  }
});

populateComponentList();
updateInspector();
