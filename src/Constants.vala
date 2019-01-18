namespace Application.Constants {
    public const string APP_NAME = "Recipes";
    public const string EXEC_NAME = "recipes";
    public const string DESKTOP_NAME = "com.github.bartzaalberg.recipes.desktop";
    public const string APPLICATION_ID = DESKTOP_NAME;
    public const string ICON = "com.github.bartzaalberg.recipes";
    public const string MAIN_URL = "https://github.com/bartzaalberg/recipes";
    public const string BUG_URL = MAIN_URL + "/issues";
    public const string VERSION = "0.0.1";
    public const string VERSION_INFO = "Unstable";
    public const string APP_YEARS = "2019";

    public const int APPLICATION_HEIGHT = 700;
    public const int APPLICATION_WIDTH = 992;

    public const Gdk.RGBA BRAND_COLOR = { 255, 255, 255, 255 };

    public const string WEBVIEW_STYLESHEET = "
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
      background-color: #FCFCFC;
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

    a,
    a:visited,
    a:hover,
    a:focus,
    a:active {
      color: #3daee9;
    }

    code {
      font-family: 'PT Mono', monospace;
      text-align: left;
      padding: 1rem !important;
      border-radius: 5px;
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
}
