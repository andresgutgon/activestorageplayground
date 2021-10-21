import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

const toBase64 = file => new Promise((resolve, reject) => {
  const reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = () => resolve(reader.result);
  reader.onerror = error => reject(error);
})

let uploadedFiles = 0;
let currentId = 0;
let lastUploadCurrentId = 0;
// Connects to data-controller="dropzone"
export default class extends Controller {
  dropzoneDroppingClass = 'dropzone--dropping'
  static targets = ['progress', 'clearFiles', 'textInfo', 'uploadButton', 'fileInput']
  static values = {
    uploadsWrapperDomId: String,
    itemTemplate: String
  }
  connect () {
    this.uploadButtonTarget.setAttribute('disabled', true)
    this.originalText = this.textInfoTarget.innerText

    this.handleFileChange = (files = []) => {
      const textInfo = this.textInfoTarget
      const button = this.uploadButtonTarget
      const filesCount = files.length
      if (filesCount) {
        button.removeAttribute('disabled')
        textInfo.innerText = `(${filesCount}) files selected`
        this.showClearFiles()
      } else {
        this.hideClearFiles()
        this.uploadButtonTarget.setAttribute('disabled', true)
        this.textInfoTarget.innerText = this.originalText
      }
    }

    this.fileInputTarget.addEventListener(
      'change',
      () => this.handleFileChange(event.target.files)
    )

    this.clearFilesTarget.addEventListener(
      'click',
      (event) => {
        event.preventDefault()
        this._clearFiles()
      }
    )

    addEventListener("direct-upload:initialize", async (event) => {
      const { detail } = event
      const { id, file } = detail
      const domId = `direct-upload-${id}`
      const uploadingElement = document.getElementById(domId)

      // Already created
      if (uploadingElement) return

      const item = this._buildItemPreview({ domId, file })
      this._galleryContainer.insertAdjacentHTML('afterbegin', item)
      this.hideClearFiles()
    })

    addEventListener("direct-upload:progress", event => {
      const { id, progress } = event.detail
      const element = document.getElementById(`direct-upload-${id}`)
      const barWrapper = element.querySelector('.js-progress-bar')
      const bar = barWrapper.children[0]
      bar.style.width = `${progress}%`

      const background = element.querySelector('.js-progress-background')
      background.style.width = `${100 - progress}%`
    })

    addEventListener("direct-upload:error", event => {
      event.preventDefault()
      const { id, error } = event.detail
      const element = document.getElementById(`direct-upload-${id}`)
      element.classList.add("direct-upload--error")
      element.setAttribute("title", error)
    })

    addEventListener("direct-upload:end", event => {
      const { id } = event.detail
      const element = document.getElementById(`direct-upload-${id}`)

      // If for some reason the ID is already changed to use the
      // signedId we don't need to enter here again.
      if (!element) return

      const bar = element.querySelector('.js-progress-bar')
      const deleteButton = element.querySelector('.js-delete')
      bar.classList.add('scale-0')
      deleteButton.style.transform = 'scale(1)'

      // Direct uploads creates a hidden input for each upload
      // with the same name as the input[type=file]
      const uploadedSignedIds = document.querySelectorAll(
        `input[type="hidden"][name="${event.target.name}"]`
      )
      // Index 0 base. The IDs are not 0 index based
      const signedId = uploadedSignedIds[(id - lastUploadCurrentId) - 1].value
      element.setAttribute('id', signedId)
      currentId = id
      this.setProgress()
    })

    addEventListener("direct-uploads:end", event => {
      lastUploadCurrentId = currentId
      this._clearFiles()
    })
  }

  _clearFiles () {
    uploadedFiles = 0
    this.fileInputTarget.removeAttribute('disabled')
    const uploadedHiddenInputFiles = this.element.querySelectorAll(
      `input[type="hidden"][name="${event.target.name}"]`
    )
    uploadedHiddenInputFiles.forEach(
      (hiddenInput) => hiddenInput.remove()
    )
    this.fileInputTarget.files = null
    this.progressTarget.removeAttribute('style')

    this.handleFileChange()
  }

  setProgress () {
    uploadedFiles +=1
    const allFiles = this.fileInputTarget.files.length
    this.textInfoTarget.innerText = `(${uploadedFiles} of ${allFiles}) files uploaded`
    this.progressTarget.style.width = `${(uploadedFiles / allFiles) * 100}%`
  }

  hideClearFiles () {
    this.clearFilesTarget.classList.add('hidden')
  }

  showClearFiles () {
    this.clearFilesTarget.classList.remove('hidden')
  }

  get _galleryContainer () {
    return document.getElementById(this.uploadsWrapperDomIdValue)
  }

  _buildItemPreview ({ domId, file }) {
    const template = document.getElementById(this.itemTemplateValue)
    const item = template.content.cloneNode(true)
    toBase64(file).then(src => {
      const preview = document.getElementById(domId)
      const image = preview.querySelector('img')
      image.src = src
    })

    const itemPreview = item.children[0]
    itemPreview.setAttribute('id', domId)
    return itemPreview.outerHTML
  }

  acceptDrop (event) {
    event.preventDefault();
    this.element.classList.add(this.dropzoneDroppingClass);
  }

  leaveDrop (event) {
    event.preventDefault();
    this.element.classList.remove(this.dropzoneDroppingClass);
  }

  handleDrop (event) {
    event.preventDefault();

    const dataTransfer = new DataTransfer();
    this.element.classList.remove(this.dropzoneDroppingClass);
    this.fileInputTarget.files = event.dataTransfer.files;
    this.handleFileChange(this.fileInputTarget.files)
  }
}
