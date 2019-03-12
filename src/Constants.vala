namespace Application.Constants {
    public const string APPLICATION_NAME = "com.github.bartzaalberg.recipes";
    public const int APPLICATION_HEIGHT = 700;
    public const int APPLICATION_WIDTH = 992;
    public const Gdk.RGBA BRAND_COLOR = { 255, 255, 255, 255 };

    public const string WEBVIEW_STYLESHEET_LIGHT = "
    html {
      font-size: 16px;
    }

    p {
      font-size: 1rem;
      color: #232629;
    }

    h1,
    h2,
    h3 {
      margin: 0.755em 0;
      font-style: bold;
    }

    h1 {
      margin-top: 0;
      font-size: 2rem;
    }

    h2 {
      font-size: 1.5rem;
    }

    h3 {
      font-size: 1.25rem;
    }

    h4 {
      font-size: 1rem;
    }

    h5 {
      font-size: .875rem;
    }

    h6 {
      font-size: .75rem;
    }

    small {
      font-size: .7em;
    }

    canvas,
    iframe,
    video,
    svg,
    select,
    textarea {
      display: block;
      max-width: 50%;
    }

    body{
      color: #232629;
      background-color: #F5F5F5;
      font-family: 'Open Sans', Helvetica, sans-serif;
      font-weight: 400;
      line-height: 1.5;
      margin-left: 80px;
      margin-right: 80px;
      margin-top: 40px;
      max-width: 100%;
      text-align: left;
      word-wrap: break-word;
    }

    table {
      border-spacing: 0;
      border-collapse: collapse;
      margin-top: 0;
      margin-bottom: 16px;
    }

    table th {
      font-weight: bold;
      background-color: #E7E7E7;
    }

    table th,
    table td {
      padding: 8px 13px;
      border: 1px solid #EAEAEA;
    }

    table tr {
      border-top: 1px solid #EAEAEA;
    }

    img {
      height: auto;
      width:100%;
      height:300px;
      object-fit:cover;
    }

    img[src*='#image-src'] {
       width:auto;
       height:auto;
       float:right;
    }

    a,
    a:visited,
    a:hover,
    a:focus,
    a:active {
      color: #3daee9;
    }

    code {
        background: #f4f4f4;
        border: 1px solid #ddd;
        border-left: 3px solid #f36d33;
        color: #666;
        page-break-inside: avoid;
        font-family: monospace;
        font-size: 15px;
        line-height: 1.6;
        margin-bottom: 1.6em;
        max-width: 100%;
        overflow: auto;
        padding: 1em 1.5em;
        display: block;
        word-wrap: break-word;
    }

    blockquote {
      margin: 0;
      border-left: 5px solid #3daee9;
      font-style: italic;
      padding-left: .8rem;
      text-align: left;
    }

    ul,
    ol,
    li {
      text-align: left;
      color: #4d4d4d;
    }
  ";

    public const string WEBVIEW_STYLESHEET_DARK = "
    html {
      font-size: 16px;
    }

    p {
      font-size: 1rem;
      color: #F7F7F7;
    }

    h1,
    h2,
    h3 {
      margin: 0.755em 0;
      font-style: bold;
    }

    h1 {
      margin-top: 0;
      font-size: 2rem;
    }

    h2 {
      font-size: 1.5rem;
    }

    h3 {
      font-size: 1.25rem;
    }

    h4 {
      font-size: 1rem;
    }

    h5 {
      font-size: .875rem;
    }

    h6 {
      font-size: .75rem;
    }

    small {
      font-size: .7em;
    }

    canvas,
    iframe,
    video,
    svg,
    select,
    textarea {
      display: block;
      max-width: 50%;
    }

    body{
      color: #F7F7F7;
      background-color: #3B3F45;
      font-family: 'Open Sans', Helvetica, sans-serif;
      font-weight: 400;
      line-height: 1.5;
      margin-left: 80px;
      margin-right: 80px;
      margin-top: 40px;
      max-width: 100%;
      text-align: left;
      word-wrap: break-word;
    }

    table {
      border-spacing: 0;
      border-collapse: collapse;
      margin-top: 0;
      margin-bottom: 16px;
    }

    table th {
      font-weight: bold;
      background-color: #E7E7E7;
    }

    table th,
    table td {
      padding: 8px 13px;
      border: 1px solid #EAEAEA;
    }

    table tr {
      border-top: 1px solid #EAEAEA;
    }

    img {
      height: auto;
      width:100%;
      height:300px;
      object-fit:cover;
    }

    img[src*='#image-src'] {
       width:auto;
       height:auto;
       float:right;
    }

    a,
    a:visited,
    a:hover,
    a:focus,
    a:active {
      color: #3daee9;
    }

    code {
        background: black;
        border: 1px solid #ddd;
        border-left: 3px solid #f36d33;
        color: white;
        page-break-inside: avoid;
        font-family: monospace;
        font-size: 15px;
        line-height: 1.6;
        margin-bottom: 1.6em;
        max-width: 100%;
        overflow: auto;
        padding: 1em 1.5em;
        display: block;
        word-wrap: break-word;
    }

    blockquote {
        margin: 0;
        border-left: 5px solid #3daee9;
        font-style: italic;
        padding-left: .8rem;
        text-align: left;
    }

    ul,
    ol,
    li {
      text-align: left;
      color: #F7F7F7;
    }
  ";
}
