// app/assets/javascripts/ckeditor/config.js
CKEDITOR.editorConfig = function (config) {
  // Define CKEditor configuration here
  config.toolbar = [
    { name: "styles", items: ["Styles", "Format", "Font", "FontSize"] },
    { name: "basicstyles", items: ["Bold", "Italic", "Underline", "Strike"] },
    { name: "colors", items: ["TextColor", "BGColor"] },
    {
      name: "paragraph",
      items: ["NumberedList", "BulletedList", "Blockquote"],
    },
    { name: "links", items: ["Link", "Unlink"] },
    { name: "tools", items: ["Maximize"] },
  ];
};
