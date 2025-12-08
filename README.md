<p align="center">
  <img alt="PDFium binaries" src=".github/images/header.svg" />
</p>

# Pre-compiled binaries of PDFium

[![Patches](https://github.com/bblanchon/pdfium-binaries/actions/workflows/patch.yml/badge.svg?branch=master)](https://github.com/bblanchon/pdfium-binaries/actions/workflows/patch.yml)
[![Total downloads](https://img.shields.io/github/downloads/bblanchon/pdfium-binaries/total)](https://github.com/bblanchon/pdfium-binaries/releases/)

[![Latest release](https://img.shields.io/github/v/release/bblanchon/pdfium-binaries?display_name=release&label=github)](https://github.com/bblanchon/pdfium-binaries/releases/latest/)
[![Nuget](https://img.shields.io/nuget/v/bblanchon.PDFium)](https://www.nuget.org/packages/bblanchon.PDFium/)
[![Conda](https://img.shields.io/conda/v/bblanchon/pdfium-binaries?label=conda)](https://anaconda.org/bblanchon/pdfium-binaries)


This project hosts pre-compiled binaries of the [PDFium library](https://pdfium.googlesource.com/pdfium/), an open-source library for PDF manipulation and rendering.

Builds have been triggered automatically every Monday since 2017.

**Disclaimer**: This project isn't affiliated with Google or Foxit.

## Download

Only Linux builds are published from this repo. For each release you will find:

- **glibc** binaries (`pdfium-linux-<cpu>.tgz`)
- **musl** binaries (`pdfium-linux-musl-<cpu>.tgz`)

Current CPU targets: `arm`, `arm64`, `x64`, and `riscv64`. V8-enabled binaries are no longer produced.

See the [Releases page](https://github.com/bblanchon/pdfium-binaries/releases) for the latest tarballs.

### NuGet Packages

Only the Linux package is maintained at this time:

- [`bblanchon.PDFium.Linux`](https://www.nuget.org/packages/bblanchon.PDFium.Linux/): ships the glibc/musl binaries produced by this repo. V8 variants are no longer published.

**HELP WANTED!**  
I can provide packages for your favorite package manager, but I need help from someone who knows the format. Contact me via [GitHub issues](https://github.com/bblanchon/pdfium-binaries/issues) if you want to help.

## Documentation

### PDFium API documentation

Please find the [documentation of the PDFium API on developers.foxit.com](https://developers.foxit.com/resources/pdf-sdk/c_api_reference_pdfium/index.html).

### How to use PDFium in a CMake project

1. Unzip the downloaded package in a folder (e.g., `C:\Libraries\pdfium`)
2. Set the environment variable `PDFium_DIR` to this folder (e.g., `C:\Libraries\pdfium`)
3. In your `CMakeLists.txt`, add

        find_package(PDFium)

4. Then link your executable with PDFium:

        target_link_libraries(my_exe pdfium)

5. On Windows, make sure that `pdfium.dll` can be found by your executable (copy it on the same folder, or put it on the `PATH`).


## Related projects

The following projects use (or recommend using) our PDFium builds:

| Name                     | Language | Description                                                                                                 |
|:-------------------------|:---------|:------------------------------------------------------------------------------------------------------------|
| [dart_pdf][dart_pdf]     | Dart     | PDF creation module for dart/flutter                                                                        |
| [DtronixPdf][dtronixpdf] | C#       | PDF viewer and editor toolset                                                                               |
| [go-pdfium][go-pdfium]   | Go       | Go wrapper around PDFium with helper functions for various methods like image rendering and text extraction |
| [libvips][libvips]       | C        | A performant image processing library                                                                       |
| [PDFium RS][pdfium_rs]   | Rust     | Rust wrapper around PDFium                                                                                  |
| [pdfium-vfp][pdfium-vfp] | VFP      | PDF Viewer component for Visual FoxPro                                                                      |
| [PDFiumCore][pdfiumcore] | C#       | .NET Standard P/Invoke bindings for PDFium                                                                  |
| [PdfiumLib][pdfiumlib]   | Pascal   | An interface to libpdfium for Delphi                                                                        |
| [PdfLibCore][pdflibcore] | C#       | A fast PDF editing and reading library for modern .NET Core applications                                    |
| [PDFtoImage][pdftoimage] | C#       | .NET library to render PDF content into images                                                              |
| [PDFtoZPL][pdftozpl]     | C#       | A .NET library to convert PDF files (and bitmaps) into Zebra Programming Language code                      |
| [PDFx][pdfx]             | Dart     | Flutter Render & show PDF documents on Web, MacOs 10.11+, Android 5.0+, iOS and Windows                     |
| [PyPDFium2][pypdfium2]   | Python   | Python bindings to PDFium                                                                                   |
| [Spacedrive][spacedrive] | Rust/TS  | Cross-platform file manager, powered by a virtual distributed filesystem                                    |
| [wxPDFView][wxpdfview]   | C++      | wxWidgets components to display PDF content                                                                 |

*Did we miss a project? Please open a PR!*  


## Contributors

<table>
  <thead>
    <tr>
      <th></th>
      <th>Username</th>
      <th>Contributions</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://github.com/bblanchon.png" width="48" height="48" alt="Benoit Blanchon"></td>
      <td><a href="https://github.com/bblanchon"><code>@bblanchon</code></a></td>
      <td>Main contributor</td>
    </tr>
    <tr>
      <td><img src="https://github.com/ChristofferGreen.png" width="48" height="48" alt="Christoffer Green"></td>
      <td><a href="https://github.com/ChristofferGreen"><code>@ChristofferGreen</code></a></td>
      <td>Linux ARM build</td>
    </tr>
    <tr>
      <td><img src="https://github.com/jerbob92.png" width="48" height="48" alt="Jeroen Bobbeldijk"></td>
      <td><a href="https://github.com/jerbob92"><code>@jerbob92</code></a></td>
      <td>Musl and WebAssembly builds</td>
    </tr>
    <tr>
      <td><img src="https://github.com/mara004.png" width="48" height="48" alt="mara004"></td>
      <td><a href="https://github.com/mara004"><code>@mara004</code></a></td>
      <td>Conda packages. ppc64 build. Constant aid.</td>
    </tr>
    <tr>
      <td><img src="https://github.com/mgiessing.png" width="48" height="48" alt="Marvin Gießing"></td>
      <td><a href="https://github.com/mgiessing"><code>@mgiessing</code></a></td>
      <td>ppc64 build</td>
    </tr>
    <tr>
      <td><img src="https://github.com/sungaila.png" width="48" height="48" alt="David Sungaila"></td>
      <td><a href="https://github.com/sungaila"><code>@sungaila</code></a></td>
      <td>NuGet packages</td>
    </tr>
    <tr>
      <td><img src="https://github.com/TcT2k.png" width="48" height="48" alt="Tobias Taschner"></td>
      <td><a href="https://github.com/TcT2k"><code>@TcT2k</code></a></td>
      <td>macOS builds</td>
    </tr>
  </tbody>
</table

[pdfium-vfp]: https://github.com/dmitriychunikhin/pdfium-vfp
[dart_pdf]: https://github.com/DavBfr/dart_pdf
[pdfx]: https://github.com/scerio/packages.flutter/tree/main/packages/pdfx
[go-pdfium]: https://github.com/klippa-app/go-pdfium
[pdfium_rs]: https://github.com/asafigan/pdfium_rs
[pdfiumcore]: https://github.com/Dtronix/PDFiumCore
[pdftoimage]: https://github.com/sungaila/PDFtoImage
[pypdfium2]: https://github.com/pypdfium2-team/pypdfium2
[wxpdfview]: https://github.com/TcT2k/wxPDFView
[libvips]: https://github.com/libvips/libvips
[pdfiumlib]: https://github.com/ahausladen/PdfiumLib
[pdflibcore]: https://github.com/jbaarssen/PdfLibCore
[dtronixpdf]: https://github.com/Dtronix/DtronixPdf
[pdftozpl]: https://github.com/sungaila/PDFtoZPL
[spacedrive]: https://github.com/spacedriveapp/spacedrive
